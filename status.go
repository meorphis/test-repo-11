// File generated from our OpenAPI spec by Stainless. See CONTRIBUTING.md for details.

package meorphistest40

import (
	"context"
	"net/http"

	"github.com/meorphis/test-repo-11/internal/apijson"
	"github.com/meorphis/test-repo-11/internal/requestconfig"
	"github.com/meorphis/test-repo-11/option"
)

// StatusService contains methods and other services that help with interacting
// with the meorphis-test-40 API.
//
// Note, unlike clients, this service does not read variables from the environment
// automatically. You should not instantiate this service directly, and instead use
// the [NewStatusService] method instead.
type StatusService struct {
	Options []option.RequestOption
}

// NewStatusService generates a new service that applies the given options to each
// request. These options are applied after the parent client's options (if there
// is one), and before any request-specific options.
func NewStatusService(opts ...option.RequestOption) (r *StatusService) {
	r = &StatusService{}
	r.Options = opts
	return
}

// API status check
func (r *StatusService) List(ctx context.Context, opts ...option.RequestOption) (res *StatusListResponse, err error) {
	opts = append(r.Options[:], opts...)
	path := "status"
	err = requestconfig.ExecuteNewRequest(ctx, http.MethodGet, path, nil, &res, opts...)
	return
}

type StatusListResponse struct {
	Message string                 `json:"message"`
	JSON    statusListResponseJSON `json:"-"`
}

// statusListResponseJSON contains the JSON metadata for the struct
// [StatusListResponse]
type statusListResponseJSON struct {
	Message     apijson.Field
	raw         string
	ExtraFields map[string]apijson.Field
}

func (r *StatusListResponse) UnmarshalJSON(data []byte) (err error) {
	return apijson.UnmarshalRoot(data, r)
}

func (r statusListResponseJSON) RawJSON() string {
	return r.raw
}
