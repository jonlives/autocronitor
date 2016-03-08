require 'unirest'

module Autocronitor
  class Helper

    def initialize(api_key)
      @monitor_template = {
          name: '',
          notifications: {
            templates: [],
      },
          rules: [
      ],
          note: 'A human-friendly description of this monitor'
      }

      @api_url = 'https://cronitor.io/v1'
      @monitor_url = 'https://cronitor.link'
      @monitor_details = {}
      @api_key = api_key
    end

    def monitor_create(monitor_name,rules,template_names)
      @monitor_template[:name] = monitor_name
      @monitor_template[:rules] = rules
      @monitor_template[:notifications][:templates] = rules.kind_of?(Array) ? template_names : [template_names]

      response = Unirest.post(
          "#{@api_url}/monitors",
          auth: { user: @api_key },
          parameters: @monitor_template.to_json
      )

      monitor_id = response.body["code"]
      if response.code == 201
        puts "Monitor '#{monitor_name}' created with ID #{monitor_id}"
      else
        puts "Error code: #{response.code} returned, exiting"
        exit 1
      end
      @monitor_details[monitor_name] = monitor_id
      return "#{@monitor_url}/#{monitor_id}"
    end

    def monitor_suggest(cron_expression)
      response = Unirest.get(
          "#{@api_url}/rules/suggest",
          auth: { user: @api_key },
          parameters:{ 'cron-expression' => cron_expression }
      )
      return response.body
    end
  end
end