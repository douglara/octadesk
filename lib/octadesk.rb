require "octadesk/version"
require "rest-client"
require 'ostruct'
require 'json'

require "octadesk/tickets/ticket"

module Octadesk
  class Api

    # Includes
    include Octadesk::Tickets::Ticket

    # Attrbutes
    attr_accessor :user_token

    def initialize(args={})
      @user_email = args[:user_email]
      @api_token = args[:api_token]

      raise ArgumentError if (args[:user_email] == nil or args[:user_email] == "") and (args[:api_token] == nil or args[:api_token] == "")

      if args[:endpoint_url]
        @endpoint_url = args[:endpoint_url]
      else
        @endpoint_url = 'https://api.octadesk.services'
      end

      @user_token = get_token(@user_email).body['token']
      #raise ArgumentError if @token == false
    end

    def get_request(action, params={}, headers={})
      begin
        headers = headers.merge({
          'accept' => 'application/json', 
          'Content-Type' => 'application/json',
          'Authorization' => "Bearer #{@user_token}"
        })

        api_response_kind = headers.delete('api_response_kind')
        api_response_kind = headers.delete(:api_response_kind) if api_response_kind.nil?
        api_response_kind = 'object' if api_response_kind.nil?

        parse_response(api_response_kind, RestClient.get("#{@endpoint_url}#{action}", {params: params}.merge(headers)))
      rescue => e
        parse_response('object', e.response)
      end
    end

    def post_request(action, params={}, headers={})
      begin
        headers = headers.merge({
          'accept' => 'application/json', 
          'Content-Type' => 'application/x-www-form-urlencoded',
          'Authorization' => "Bearer #{@user_token}"
        })

        api_response_kind = headers.delete('api_response_kind')
        api_response_kind = headers.delete(:api_response_kind) if api_response_kind.nil?
        api_response_kind = 'object' if api_response_kind.nil?

        parse_response(api_response_kind, RestClient.post("#{@endpoint_url}#{action}", params, headers))
      rescue => e
        parse_response('object', e.response)
      end
    end

    def put_request(action, params={}, headers={})
      begin
        headers = headers.merge({
          'accept' => 'application/json', 
          'Content-Type' => 'application/json',
          'Authorization' => "Bearer #{@user_token}"
        })

        api_response_kind = headers.delete('api_response_kind')
        api_response_kind = headers.delete(:api_response_kind) if api_response_kind.nil?
        api_response_kind = 'object' if api_response_kind.nil?

        parse_response(api_response_kind, RestClient.put("#{@endpoint_url}#{action}", params, headers))
      rescue => e
        parse_response('object', e.response)
      end
    end

    def patch_request(action, params={}, headers={})
      begin
        headers = headers.merge({
          'accept' => 'application/json', 
          'Content-Type' => 'application/json',
          'Authorization' => "Bearer #{@user_token}"
        })

        api_response_kind = headers.delete('api_response_kind')
        api_response_kind = headers.delete(:api_response_kind) if api_response_kind.nil?
        api_response_kind = 'object' if api_response_kind.nil?

        parse_response(api_response_kind, RestClient.patch("#{@endpoint_url}#{action}", params, headers))
      rescue => e
        parse_response('object', e.response)
      end
    end

    def head_request(action, params={}, headers={})
      begin
        headers = headers.merge({
          'accept' => 'application/json', 
          'Content-Type' => 'application/json',
          'Authorization' => "Bearer #{@user_token}"
        })

        api_response_kind = headers.delete('api_response_kind')
        api_response_kind = headers.delete(:api_response_kind) if api_response_kind.nil?
        api_response_kind = 'object' if api_response_kind.nil?

        parse_response(api_response_kind, RestClient.head("#{@endpoint_url}#{action}", params))
      rescue => e
        parse_response('object', e.response)
      end
    end

    def delete_request(action, params={}, headers={})
      begin
        headers = headers.merge({
          'accept' => 'application/json', 
          'Content-Type' => 'application/json',
          'Authorization' => "Bearer #{@user_token}"
        })
        
        api_response_kind = headers.delete('api_response_kind')
        api_response_kind = headers.delete(:api_response_kind) if api_response_kind.nil?
        api_response_kind = 'object' if api_response_kind.nil?

        parse_response(api_response_kind, RestClient.delete("#{@endpoint_url}#{action}", params))
      rescue => e
        parse_response('object', e.response)
      end
    end

    private

    def get_token(user_email)
      header = { 
        'apiToken' => @api_token,
        'username' => "#{user_email}".downcase
      }
      request = post_request("/login/apiToken", {}, header )
      request
    end

    def parse_response(api_response_kind, response)
      result = OpenStruct.new
      result.status_code = response.code

      if api_response_kind == 'object'
        result.headers = (JSON.parse(response.headers.to_json, object_class: OpenStruct) rescue response.headers)
        result.body = (JSON.parse(response.body, object_class: OpenStruct) rescue response.body)
      elsif api_response_kind == 'hash'
        result.headers = response.headers
        result.body = (JSON.parse(response.body) rescue response.body)
      else
        result.headers = response.headers
        result.body = response.body
      end

      @last_result = result

      result
    end
    
  end
end