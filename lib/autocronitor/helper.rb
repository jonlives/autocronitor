require 'unirest'

module Autocronitor
  class Helper

    def initialize(api_key)
      @monitor_template = {
        name: '',
        notifications: {
          templates: [],
        },
        rules: [],
        type: 'heartbeat'
      }

      @api_url = 'https://cronitor.io/v3'
      @monitor_url = 'https://cronitor.link'
      @monitor_details = {}
      @api_key = api_key
    end

    def monitor_create(monitor_name, cron_expression, template_names)
      @monitor_template[:name] = monitor_name[0..99]
      @monitor_template[:rules] = [
        { 
          rule_type: 'not_on_schedule',
          value: cron_expression
        }
      ]
      @monitor_template[:notifications][:templates] = template_names.kind_of?(Array) ? template_names : [template_names]

      response = Unirest.post(
          "#{@api_url}/monitors",
          auth: { user: @api_key },
          parameters: @monitor_template.to_json
      )

      monitor_id = response.body["code"]
      if response.code == 201
        puts "Monitor '#{monitor_name}' created with ID #{monitor_id}"
      elsif response.code == 400 && JSON.parse(response.body)['name'] == ["name must be unique"]
        puts "Monitor '#{monitor_name}' already exists, skipping \n"
      else
        puts "Error code: #{response.code} returned, exiting"
        puts "Response: \n\n #{response.body}"
        exit 1
      end
      @monitor_details[monitor_name] = monitor_id
      return "#{@monitor_url}/#{monitor_id}"
    end

  end
end