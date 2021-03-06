// Code generated by go-swagger; DO NOT EDIT.

package models

// This file was generated by the swagger tool.
// Editing this file might prove futile when you re-run the swagger generate command

import (
	"github.com/go-openapi/strfmt"
	"github.com/go-openapi/swag"
)

// StepReply step reply
//
// swagger:model step-reply
type StepReply struct {

	// error
	Error string `json:"error,omitempty"`

	// exit code
	ExitCode int64 `json:"exit_code,omitempty"`

	// output
	Output string `json:"output,omitempty"`

	// step id
	StepID string `json:"step_id,omitempty"`
}

// Validate validates this step reply
func (m *StepReply) Validate(formats strfmt.Registry) error {
	return nil
}

// MarshalBinary interface implementation
func (m *StepReply) MarshalBinary() ([]byte, error) {
	if m == nil {
		return nil, nil
	}
	return swag.WriteJSON(m)
}

// UnmarshalBinary interface implementation
func (m *StepReply) UnmarshalBinary(b []byte) error {
	var res StepReply
	if err := swag.ReadJSON(b, &res); err != nil {
		return err
	}
	*m = res
	return nil
}
