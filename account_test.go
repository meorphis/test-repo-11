// File generated from our OpenAPI spec by Stainless. See CONTRIBUTING.md for details.

package meorphistest40_test

import (
	"context"
	"errors"
	"os"
	"testing"

	"github.com/meorphis/test-repo-11"
	"github.com/meorphis/test-repo-11/internal/testutil"
	"github.com/meorphis/test-repo-11/option"
)

func TestAccountGet(t *testing.T) {
	baseURL := "http://localhost:4010"
	if envURL, ok := os.LookupEnv("TEST_API_BASE_URL"); ok {
		baseURL = envURL
	}
	if !testutil.CheckTestServer(t, baseURL) {
		return
	}
	client := meorphistest40.NewClient(
		option.WithBaseURL(baseURL),
	)
	_, err := client.Accounts.Get(context.TODO(), "182bd5e5-6e1a-4fe4-a799-aa6d9a6ab26e")
	if err != nil {
		var apierr *meorphistest40.Error
		if errors.As(err, &apierr) {
			t.Log(string(apierr.DumpRequest(true)))
		}
		t.Fatalf("err should be nil: %s", err.Error())
	}
}

func TestAccountUpdateWithOptionalParams(t *testing.T) {
	baseURL := "http://localhost:4010"
	if envURL, ok := os.LookupEnv("TEST_API_BASE_URL"); ok {
		baseURL = envURL
	}
	if !testutil.CheckTestServer(t, baseURL) {
		return
	}
	client := meorphistest40.NewClient(
		option.WithBaseURL(baseURL),
	)
	_, err := client.Accounts.Update(
		context.TODO(),
		"182bd5e5-6e1a-4fe4-a799-aa6d9a6ab26e",
		meorphistest40.AccountUpdateParams{
			DailySpendLimit:    meorphistest40.F(int64(1000)),
			LifetimeSpendLimit: meorphistest40.F(int64(0)),
			MonthlySpendLimit:  meorphistest40.F(int64(0)),
			State:              meorphistest40.F(meorphistest40.AccountUpdateParamsStateActive),
			VerificationAddress: meorphistest40.F(meorphistest40.AccountUpdateParamsVerificationAddress{
				Address1:   meorphistest40.F("address1"),
				Address2:   meorphistest40.F("address2"),
				City:       meorphistest40.F("city"),
				State:      meorphistest40.F("state"),
				PostalCode: meorphistest40.F("postal_code"),
				Country:    meorphistest40.F("country"),
			}),
		},
	)
	if err != nil {
		var apierr *meorphistest40.Error
		if errors.As(err, &apierr) {
			t.Log(string(apierr.DumpRequest(true)))
		}
		t.Fatalf("err should be nil: %s", err.Error())
	}
}
