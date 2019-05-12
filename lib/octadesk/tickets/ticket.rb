module Octadesk
  module Tickets
    module Ticket

      def search_by_custom_field(app_sub_domain, custom_field_id, custom_field_value)        
        begin
          headers = {
            'Content-Type' => 'application/json', 
            'Access-Control-Allow-Origin' => '*',
            'accept' => '*/*',
            'Access-Control-Allow-Headers' => '*',
            'AppSubDomain' => app_sub_domain,
            'Authorization' => "Bearer #{@user_token}"
          }

          params = '{ 
            "operationName":null,
            "variables": {
              "externalQueries":[
                {
                  "type":"ticket",
                  "propertyName":"CustomField.'+custom_field_id.to_s+'",
                  "textValue":"'+custom_field_value.to_s+'",
                  "operator":4,
                  "objectsCompare":[],
                  "valueCompare":"'+custom_field_value.to_s+'",
                  "hasValue":true,
                  "dataSourceItemEmpty":false,
                  "typeControl":"text"}
                  ],
                  "propertySort":"Number","sortDirection":"desc","take":20,"queryType":"","skip":0,"executeTotalItems":true,"includeArchiveds":true,"idCustomList":"","action":"search"},"query":"query ($externalQueries: [QueryFilterInputType], $propertySort: String, $sortDirection: String, $executeTotalItems: Boolean, $includeArchiveds: Boolean, $searchId: String, $page: Int) {\n  ticketSearch(externalQueries: $externalQueries, propertySort: $propertySort, sortDirection: $sortDirection, executeTotalItems: $executeTotalItems, includeArchiveds: $includeArchiveds, searchId: $searchId, page: $page) {\n    tickets {\n      id\n      doneDate\n      dueDate\n      stateProgressName\n      merge {\n        type\n        __typename\n      }\n      merge {\n        numberParentTicket\n        __typename\n      }\n      reportedAsSpam\n      viewers {\n        id\n        __typename\n      }\n      viewers {\n        name\n        __typename\n      }\n      groupAssignedName\n      idRequester\n      currentStatusName\n      number\n      summary\n      requesterName\n      assignedName\n      priorityName\n      openDate\n      lastDateUpdate\n      sla {\n        dueDate\n        __typename\n      }\n      lastPersonUpdate {\n        type\n        __typename\n      }\n      __typename\n    }\n    searchId\n    totalItems\n    executionDetails {\n      timings\n      __typename\n    }\n    __typename\n  }\n}\n"}'
  
          api_response_kind = headers.delete('api_response_kind')
          api_response_kind = headers.delete(:api_response_kind) if api_response_kind.nil?
          api_response_kind = 'object' if api_response_kind.nil?
  
          parse_response(api_response_kind, RestClient.post("https://ticket.octadesk.services/api/graphql/query", params, headers))
        rescue => e
          parse_response('object', e.response)
        end

      end

      def create_ticket(body)
        payload = body.to_json
        post_request("/tickets", payload)
      end

      def get_ticket(number)
        get_request("/tickets/#{number}")
      end

      def get_ticket_interactions(number)
        get_request("/tickets/#{number}/interactions")
      end
    
    end
  end
end