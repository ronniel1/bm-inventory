module github.com/filanov/bm-inventory

go 1.13

require (
	github.com/alecthomas/units v0.0.0-20190924025748-f65c72e2690d
	github.com/cpuguy83/go-md2man/v2 v2.0.0 // indirect
	github.com/fatih/color v1.9.0 // indirect
	github.com/filanov/stateswitch v0.0.0-20200513095115-051501b05b45
	github.com/git-chglog/git-chglog v0.0.0-20200414013904-db796966b373 // indirect
	github.com/go-openapi/errors v0.19.3
	github.com/go-openapi/loads v0.19.4
	github.com/go-openapi/runtime v0.19.11
	github.com/go-openapi/spec v0.19.6
	github.com/go-openapi/strfmt v0.19.4
	github.com/go-openapi/swag v0.19.9
	github.com/go-openapi/validate v0.19.5
	github.com/golang/mock v1.2.0
	github.com/google/uuid v1.1.1
	github.com/imdario/mergo v0.3.9 // indirect
	github.com/jinzhu/gorm v1.9.12
	github.com/kelseyhightower/envconfig v1.4.0
	github.com/mattn/go-colorable v0.1.6 // indirect
	github.com/onsi/ginkgo v1.12.0
	github.com/onsi/gomega v1.10.0
	github.com/pborman/uuid v1.2.0
	github.com/pkg/errors v0.9.1
	github.com/sirupsen/logrus v1.6.0
	github.com/stretchr/testify v1.4.0
	github.com/tsuyoshiwada/go-gitcmd v0.0.0-20180205145712-5f1f5f9475df // indirect
	github.com/urfave/cli v1.22.4 // indirect
	golang.org/x/net v0.0.0-20200226121028-0de0cce0169b // indirect
	golang.org/x/sys v0.0.0-20200620081246-981b61492c35 // indirect
	golang.org/x/tools v0.0.0-20190920225731-5eefd052ad72
	golang.org/x/xerrors v0.0.0-20191204190536-9bdfabe68543 // indirect
	gopkg.in/AlecAivazis/survey.v1 v1.8.8 // indirect
	gopkg.in/kyokomi/emoji.v1 v1.5.1 // indirect
	gopkg.in/yaml.v2 v2.3.0
	k8s.io/api v0.17.3
	k8s.io/apimachinery v0.17.3
	k8s.io/client-go v11.0.0+incompatible
	sigs.k8s.io/controller-runtime v0.5.0
)

replace (
	k8s.io/cli-runtime => k8s.io/cli-runtime v0.0.0-20191016114015-74ad18325ed5
	k8s.io/client-go => k8s.io/client-go v0.0.0-20191016111102-bec269661e48
)
