RSpec.describe Octadesk do
  it "has a version number" do
    expect(Octadesk::VERSION).not_to be nil
  end

  context 'instance' do
    context "sucess" do
      before {
        @api = Octadesk::Api.new({
          user_email: ENV['OCTA_USER_EMAIL'],
          api_token: ENV['OCTA_API_TOKEN']
        })
      }
      it {
        expect(@api).to_not be_nil  
      }

      context 'tickets' do 
        context 'create' do 
          it 'success' do 
            ticket = {
              "summary": 'Ticket title',
              "numberChannel": 0,
              "inbox": {
                "domain": "",
                "email": ""
                }
            }

            result = @api.create_ticket(ticket)
            expect(result.status_code).to be 200
          end

          it 'success with html elements' do
            ticket = {
              "summary": "TEST API - System.....",
              "numberChannel": 0,
              "inbox": {
                "domain": "",
                "email": ""
                },
              "comments": {
                "internal": { 
                  "content": "<html><head></head><body><p>Buy details: <a href=\"https://..../sales/19861176574564/detail?\" target=\"_blank\">https://..../sales/19861176574564/detail??</a></p></body></html>"
                 }
              },
              "customField": { "ml_order_id": "19861176574564" }
            }

            result = @api.create_ticket(ticket)
            expect(result.status_code).to be 200
          end
        end
        context 'search' do
          it 'by custom field' do
            result = @api.search_by_custom_field(ENV['OCTA_APP_SUB_DOMAIN'], ENV['OCTA_TICKET_CUSTOM_FIELD_ID'], ENV['OCTA_TICKET_CUSTOM_FIELD_VALUE'])
            p result.body.data.ticketSearch.tickets
            expect(result.status_code).to be 200
          end
        end

        context 'get' do
          it 'success' do
            result = @api.get_ticket(876)
            expect(result.status_code).to be 200
          end
          it 'not fount' do
            result = @api.get_ticket(8456476)
            expect(result.status_code).to be 404
          end
        end
      end
      context 'generics calls' do
        it "get" do
          request = @api.get_request("/persons?email=#{ENV['OCTA_USER_EMAIL']}")
          expect(request.status_code).to be 200
        end   
      end

    end 
  end


end
