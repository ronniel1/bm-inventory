PWD = $(shell pwd)
UID = $(shell id -u)

TARGET := $(or ${TARGET},minikube)
KUBECTL=kubectl -n assisted-installer

ifeq ($(TARGET), minikube)
define get_service
minikube service --url $(1) -n assisted-installer | sed 's/http:\/\///g'
endef
else
define get_service
kubectl get service $(1) -n assisted-installer | grep $(1) | awk '{print $$4 ":" $$5}' | \
	awk '{split($$0,a,":"); print a[1] ":" a[2]}'
endef
endif

SERVICE := $(or ${SERVICE},quay.io/ocpmetal/bm-inventory:stable)
OBJEXP := $(or ${OBJEXP},quay.io/ocpmetal/s3-object-expirer:stable)
GIT_REVISION := $(shell git rev-parse HEAD)

all: build

lint:
	golangci-lint run -v

.PHONY: build
build: create-build-dir lint unit-test
	CGO_ENABLED=0 go build -o build/bm-inventory cmd/main.go

create-build-dir:
	mkdir -p build

clean:
	rm -rf build

format:
	goimports -w -l cmd/ internal/

generate:
	go generate $(shell go list ./...)

generate-from-swagger:
	rm -rf client models restapi
	docker run -u $(UID):$(UID) -v $(PWD):$(PWD):rw,Z -v /etc/passwd:/etc/passwd -w $(PWD) quay.io/goswagger/swagger generate server	--template=stratoscale -f swagger.yaml --template-dir=/templates/contrib
	docker run -u $(UID):$(UID) -v $(PWD):$(PWD):rw,Z -v /etc/passwd:/etc/passwd -w $(PWD) quay.io/goswagger/swagger generate client	--template=stratoscale -f swagger.yaml --template-dir=/templates/contrib
	go generate $(shell go list ./client/... ./models/... ./restapi/...)

update: build
	GIT_REVISION=${GIT_REVISION} docker build --build-arg GIT_REVISION -f Dockerfile.bm-inventory . -t $(SERVICE)
	docker push $(SERVICE)

update-expirer: build
	GIT_REVISION=${GIT_REVISION} docker build --build-arg GIT_REVISION -f Dockerfile.s3-object-expirer . -t $(OBJEXP)
	docker push $(OBJEXP)

deploy-all: create-build-dir deploy-namespace deploy-mariadb deploy-s3 deploy-service
	echo "Deployment done"

deploy-namespace:
	python3 ./tools/deploy_namespace.py

deploy-s3-configmap:
	python3 tools/deploy_scality_configmap.py

deploy-s3: deploy-namespace
	python3 ./tools/deploy_s3.py
	sleep 5;  # wait for service to get an address
	make deploy-s3-configmap
	python3 ./tools/create_default_s3_bucket.py

deploy-inventory-service-file: deploy-namespace
	python3 ./tools/deploy_inventory_service.py
	sleep 5;  # wait for service to get an address

deploy-service-requirements: deploy-namespace deploy-inventory-service-file
	python3 ./tools/deploy_assisted_installer_configmap.py

deploy-service: deploy-namespace deploy-service-requirements deploy-role
	python3 ./tools/deploy_assisted_installer.py

deploy-expirer: deploy-role
	python3 ./tools/deploy_s3_object_expirer.py

deploy-role: deploy-namespace
	python3 ./tools/deploy_role.py

deploy-mariadb: deploy-namespace
	python3 ./tools/deploy_mariadb.py

subsystem-run: test subsystem-clean

test:
	INVENTORY=$(shell $(call get_service,bm-inventory) | sed 's/http:\/\///g') \
		DB_HOST=$(shell $(call get_service,mariadb) | sed 's/http:\/\///g' | cut -d ":" -f 1) \
		DB_PORT=$(shell $(call get_service,mariadb) | sed 's/http:\/\///g' | cut -d ":" -f 2) \
		go test -v ./subsystem/... -count=1 -ginkgo.focus=${FOCUS} -ginkgo.v

unit-test:
	go test -v $(shell go list ./... | grep -v subsystem) -cover

subsystem-clean:
	$(KUBECTL) get pod -o name | grep create-image | xargs $(KUBECTL) delete 1> /dev/null ; true
	$(KUBECTL) get pod -o name | grep generate-kubeconfig | xargs $(KUBECTL) delete 1> /dev/null ; true

clear-deployment:
	python3 ./tools/clear_deployment.py
 
