RSpec.describe Octadesk do
  it "has a version number" do
    expect(Octadesk::VERSION).not_to be nil
  end

  context 'instance' do
    it "sucess" do
      api = Octadesk::Api.new({
        user_email: ENV['OCTA_USER_EMAIL'],
        api_token: ENV['OCTA_API_TOKEN']
      })
      expect(api).to_not be_nil
    end 

    context 'generics calls' do
      before {
        @api = Octadesk::Api.new({
          user_email: ENV['OCTA_USER_EMAIL'],
          api_token: ENV['OCTA_API_TOKEN']
        })
      }
      it "get" do
        request = @api.get_request("/persons?email=#{ENV['OCTA_USER_EMAIL']}")
        expect(request.status_code).to be 200
      end   
    end
  end


end
