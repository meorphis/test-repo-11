// File generated from our OpenAPI spec by Stainless. See CONTRIBUTING.md for details.

package meorphistest40_test

import (
	"context"
	"os"
	"testing"

	"github.com/meorphis/test-repo-11"
	"github.com/meorphis/test-repo-11/internal/testutil"
	"github.com/meorphis/test-repo-11/option"
)

func TestUsage(t *testing.T) {
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
	card, err := client.Cards.New(context.TODO(), meorphistest40.CardNewParams{
		Type: meorphistest40.F(meorphistest40.CardNewParamsTypeReplaceMe),
	})
	if err != nil {
		t.Error(err)
	}
	t.Logf("%+v\n", card.Token)
}
