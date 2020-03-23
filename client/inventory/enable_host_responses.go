// Code generated by go-swagger; DO NOT EDIT.

package inventory

// This file was generated by the swagger tool.
// Editing this file might prove futile when you re-run the swagger generate command

import (
	"fmt"

	"github.com/go-openapi/runtime"
	"github.com/go-openapi/strfmt"
)

// EnableHostReader is a Reader for the EnableHost structure.
type EnableHostReader struct {
	formats strfmt.Registry
}

// ReadResponse reads a server response into the received o.
func (o *EnableHostReader) ReadResponse(response runtime.ClientResponse, consumer runtime.Consumer) (interface{}, error) {
	switch response.Code() {
	case 204:
		result := NewEnableHostNoContent()
		if err := result.readResponse(response, consumer, o.formats); err != nil {
			return nil, err
		}
		return result, nil
	case 404:
		result := NewEnableHostNotFound()
		if err := result.readResponse(response, consumer, o.formats); err != nil {
			return nil, err
		}
		return nil, result
	case 409:
		result := NewEnableHostConflict()
		if err := result.readResponse(response, consumer, o.formats); err != nil {
			return nil, err
		}
		return nil, result
	case 500:
		result := NewEnableHostInternalServerError()
		if err := result.readResponse(response, consumer, o.formats); err != nil {
			return nil, err
		}
		return nil, result

	default:
		return nil, runtime.NewAPIError("unknown error", response, response.Code())
	}
}

// NewEnableHostNoContent creates a EnableHostNoContent with default headers values
func NewEnableHostNoContent() *EnableHostNoContent {
	return &EnableHostNoContent{}
}

/*EnableHostNoContent handles this case with default header values.

Enabled
*/
type EnableHostNoContent struct {
}

func (o *EnableHostNoContent) Error() string {
	return fmt.Sprintf("[POST /hosts/{host_id}/actions/enable][%d] enableHostNoContent ", 204)
}

func (o *EnableHostNoContent) readResponse(response runtime.ClientResponse, consumer runtime.Consumer, formats strfmt.Registry) error {

	return nil
}

// NewEnableHostNotFound creates a EnableHostNotFound with default headers values
func NewEnableHostNotFound() *EnableHostNotFound {
	return &EnableHostNotFound{}
}

/*EnableHostNotFound handles this case with default header values.

Host not found
*/
type EnableHostNotFound struct {
}

func (o *EnableHostNotFound) Error() string {
	return fmt.Sprintf("[POST /hosts/{host_id}/actions/enable][%d] enableHostNotFound ", 404)
}

func (o *EnableHostNotFound) readResponse(response runtime.ClientResponse, consumer runtime.Consumer, formats strfmt.Registry) error {

	return nil
}

// NewEnableHostConflict creates a EnableHostConflict with default headers values
func NewEnableHostConflict() *EnableHostConflict {
	return &EnableHostConflict{}
}

/*EnableHostConflict handles this case with default header values.

Conflict
*/
type EnableHostConflict struct {
}

func (o *EnableHostConflict) Error() string {
	return fmt.Sprintf("[POST /hosts/{host_id}/actions/enable][%d] enableHostConflict ", 409)
}

func (o *EnableHostConflict) readResponse(response runtime.ClientResponse, consumer runtime.Consumer, formats strfmt.Registry) error {

	return nil
}

// NewEnableHostInternalServerError creates a EnableHostInternalServerError with default headers values
func NewEnableHostInternalServerError() *EnableHostInternalServerError {
	return &EnableHostInternalServerError{}
}

/*EnableHostInternalServerError handles this case with default header values.

Internal server error
*/
type EnableHostInternalServerError struct {
}

func (o *EnableHostInternalServerError) Error() string {
	return fmt.Sprintf("[POST /hosts/{host_id}/actions/enable][%d] enableHostInternalServerError ", 500)
}

func (o *EnableHostInternalServerError) readResponse(response runtime.ClientResponse, consumer runtime.Consumer, formats strfmt.Registry) error {

	return nil
}
