require "spec_helper"

describe "Beers API" do
  let!(:customer) { create(:user) }
  let(:headers)  { { 'HTTP_AUTHORIZATION' => "Token token=\"#{customer.api_token}\"", 'Accept' => 'application/json' } }

  context "GET /api/v1/beers.json" do
    context "when the user provides a valid API token" do
      it "responds with 200" do
        get "/api/v1/beers.json", nil, headers

        response.should be_success
      end

      context "when the user has purchased beers" do
        let!(:beer1) { create(:beer, user: customer) }
        let!(:beer2) { create(:beer, user: customer) }

        it "responds with a valid JSON representation" do
          get "/api/v1/beers.json", nil, headers

          response_body = %{
            {
              "beers": [
                {
                  "id": #{beer1.id},
                  "user_id": #{customer.id},
                  "updated_at": "#{beer1.updated_at.iso8601}"
                },
                {
                  "id": #{beer2.id},
                  "user_id": #{customer.id},
                  "updated_at": "#{beer2.updated_at.iso8601}"
                }
              ]
            }
          }

          JSON.parse(response.body).should == JSON.parse(response_body)
        end
      end
    end

    context "when the user does not provide a valid API token" do
      it "responds with 401" do
        get "/api/v1/beers.json"

        response.status.should eq(401)
      end
    end
  end

  context "POST /api/v1/beers.json" do
    context "with valid beer json" do
      let(:json) { %{
          {
            "beer": {
              "deliciousness": 3
            }
          }
        } }

      it "should succeed" do
        post "/api/v1/beers.json", JSON.parse(json), headers

        response.should be_success
      end

      it "creates a beer" do
        expect {
          post "/api/v1/beers.json", JSON.parse(json), headers 
        }.to change(Beer, :count).by(1)
      end

      it "allows specification of deliciousness" do
        post "/api/v1/beers.json", JSON.parse(json), headers 

        Beer.last.deliciousness.should == 3
      end
    end
  end
end
