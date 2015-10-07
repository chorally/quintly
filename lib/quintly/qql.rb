require 'faraday'
require 'json'
require 'uri'

module Quintly
  class QQL < Struct.new(:configuration)
    SERVICE_URL = 'https://api.quintly.com'
    API_VERSION = 'v0.9'

    def metric(metric)
      call('metric', metric)
    end

    def query(qql_query)
      call('qqlQuery', qql_query)
    end

    private

    def api_client
      connection = Faraday.new(SERVICE_URL)
      connection.basic_auth(
        configuration.username, configuration.password
      )
      connection
    end

    def call(api, action)
      url = URI.parse(URI.encode(
        "/#{API_VERSION}/qql?#{api}=#{action}&" +
        "startTime=#{configuration.start_time}&" +
        "endTime=#{configuration.end_time}&" +
        "interval=#{configuration.interval}&" +
        "profileIds=#{configuration.profile_ids}")
      )
      response = api_client.get(url)
      response.success? ? JSON.parse(response.body)['data'] : response.body
    end
  end
end
