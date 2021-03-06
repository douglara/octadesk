# Octadesk

Octadesk gem implements interface to Oficial Octadesk API.

## Requirements

You need to account in Octadesk and create API Token, oficial docummentation:
https://help.octadesk.com/kb/article/como-trabalhar-com-a-api-da-octadesk

Rest Client is used to perform all API calls.

## Installation

```ruby
gem 'octadesk'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install octadesk

## Getting started

First need to instance the API:

    api = Octadesk::Api.new({
        user_email: 'OCTA_USER_EMAIL',
        api_token: 'OCTA_API_TOKEN'
      })

## Methods

##### Generics


    * api.get_request("/API_PATH", params={}, headers={})
      -> Returns get from Octa API.
      -> Example: api.get_request("/persons?email=custumer@email.com")

    * api.post_request("/API_PATH", params={}, headers={})
      -> Returns post from Octa API.

    * api.put_request("/API_PATH", params={}, headers={})
      -> Returns put from Octa API.

    * api.patch_request("/API_PATH", params={}, headers={})
      -> Returns patch from Octa API.

    * api.head_request("/API_PATH", params={}, headers={})
      -> Returns head from Octa API.

    * api.delete_request("/API_PATH", params={}, headers={})
      -> Returns delete from Octa API.


##### Tickets

    * api.search_by_custom_field("YOU_OCTA_SUB_DOMAIN", "CUSTOM_FIELD_ID", "Value to search")
      -> Returns search from Octa tickets by one custom field.
    * api.create_ticket(body)
      -> Create ticket.
      -> Example: api.create_ticket({
              "summary": 'Ticket title',
              "numberChannel": 0,
              "inbox": {
                "domain": "",
                "email": ""
                }
            })
    * api.get_ticket("TICKET_NUMBER")
      -> Returns ticket, attention because it is by ticket number and not by ticket id.
      
    * api.get_ticket_interactions("TICKET_NUMBER")
      -> Returns ticket interactions, attention because it is by ticket number and not by ticket id.

## Contributing / Problems?

If you have encountered any problem, difficulty or bug, please start by opening a issue.

Bug reports and pull requests are welcome on GitHub at https://github.com/douglaslaraa/octadesk. This project is intended to be a safe, welcoming space for collaboration.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
