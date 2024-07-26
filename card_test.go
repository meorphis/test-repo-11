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

func TestCardNewWithOptionalParams(t *testing.T) {
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
	_, err := client.Cards.New(context.TODO(), meorphistest40.CardNewParams{
		Type:             meorphistest40.F(meorphistest40.CardNewParamsTypeVirtual),
		AccountToken:     meorphistest40.F("182bd5e5-6e1a-4fe4-a799-aa6d9a6ab26e"),
		CardProgramToken: meorphistest40.F("00000000-0000-0000-1000-000000000000"),
		Carrier: meorphistest40.F(meorphistest40.CardNewParamsCarrier{
			QrCodeURL: meorphistest40.F("qr_code_url"),
		}),
		DigitalCardArtToken: meorphistest40.F("00000000-0000-0000-1000-000000000000"),
		ExpMonth:            meorphistest40.F("06"),
		ExpYear:             meorphistest40.F("2027"),
		Memo:                meorphistest40.F("New Card"),
		Pin:                 meorphistest40.F("pin"),
		ProductID:           meorphistest40.F("1"),
		ShippingAddress: meorphistest40.F(meorphistest40.CardNewParamsShippingAddress{
			FirstName:   meorphistest40.F("Michael"),
			LastName:    meorphistest40.F("Bluth"),
			Line2Text:   meorphistest40.F("The Bluth Company"),
			Address1:    meorphistest40.F("5 Broad Street"),
			Address2:    meorphistest40.F("Unit 25A"),
			City:        meorphistest40.F("NEW YORK"),
			State:       meorphistest40.F("NY"),
			PostalCode:  meorphistest40.F("10001-1809"),
			Country:     meorphistest40.F("USA"),
			Email:       meorphistest40.F("johnny@appleseed.com"),
			PhoneNumber: meorphistest40.F("+12124007676"),
		}),
		ShippingMethod:     meorphistest40.F(meorphistest40.CardNewParamsShippingMethodStandard),
		SpendLimit:         meorphistest40.F(int64(1000)),
		SpendLimitDuration: meorphistest40.F(meorphistest40.CardNewParamsSpendLimitDurationTransaction),
		State:              meorphistest40.F(meorphistest40.CardNewParamsStateOpen),
		IdempotencyKey:     meorphistest40.F("Idempotency-Key"),
	})
	if err != nil {
		var apierr *meorphistest40.Error
		if errors.As(err, &apierr) {
			t.Log(string(apierr.DumpRequest(true)))
		}
		t.Fatalf("err should be nil: %s", err.Error())
	}
}

func TestCardGet(t *testing.T) {
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
	_, err := client.Cards.Get(context.TODO(), "182bd5e5-6e1a-4fe4-a799-aa6d9a6ab26e")
	if err != nil {
		var apierr *meorphistest40.Error
		if errors.As(err, &apierr) {
			t.Log(string(apierr.DumpRequest(true)))
		}
		t.Fatalf("err should be nil: %s", err.Error())
	}
}

func TestCardUpdateWithOptionalParams(t *testing.T) {
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
	_, err := client.Cards.Update(
		context.TODO(),
		"182bd5e5-6e1a-4fe4-a799-aa6d9a6ab26e",
		meorphistest40.CardUpdateParams{
			AuthRuleToken:       meorphistest40.F("auth_rule_token"),
			DigitalCardArtToken: meorphistest40.F("00000000-0000-0000-1000-000000000000"),
			Memo:                meorphistest40.F("Updated Name"),
			Pin:                 meorphistest40.F("pin"),
			SpendLimit:          meorphistest40.F(int64(100)),
			SpendLimitDuration:  meorphistest40.F(meorphistest40.CardUpdateParamsSpendLimitDurationForever),
			State:               meorphistest40.F(meorphistest40.CardUpdateParamsStateOpen),
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

func TestCardProvisionWithOptionalParams(t *testing.T) {
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
	_, err := client.Cards.Provision(
		context.TODO(),
		"182bd5e5-6e1a-4fe4-a799-aa6d9a6ab26e",
		meorphistest40.CardProvisionParams{
			Certificate:    meorphistest40.F("U3RhaW5sZXNzIHJvY2tz"),
			DigitalWallet:  meorphistest40.F(meorphistest40.CardProvisionParamsDigitalWalletGooglePay),
			Nonce:          meorphistest40.F("U3RhaW5sZXNzIHJvY2tz"),
			NonceSignature: meorphistest40.F("U3RhaW5sZXNzIHJvY2tz"),
			IdempotencyKey: meorphistest40.F("Idempotency-Key"),
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
