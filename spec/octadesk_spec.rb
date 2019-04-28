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
        context 'search' do
          it 'by custom field' do
            result = @api.search_by_custom_field(ENV['OCTA_APP_SUB_DOMAIN'], ENV['OCTA_TICKET_CUSTOM_FIELD_ID'], ENV['OCTA_TICKET_CUSTOM_FIELD_VALUE'])
            p result.body.data.ticketSearch.tickets
            expect(result.status_code).to be 200
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
