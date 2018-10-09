require 'rest-client'

class CotohaClient
  class << self
    def get_access_token
      url = "https://api.ce-cotoha.com/v1/oauth/accesstokens"
      json = {
        grantType: "client_credentials",
        clientId: Rails.application.credentials.cotoha[:clientId],
        clientSecret: Rails.application.credentials.cotoha[:clientSecret],
      }.to_json
      headers = {
        content_type: :json,
        accept: :json
      }

      response = RestClient.post(url, json, headers)
      body = JSON.parse(response.body)
      return body['access_token']
    end

    def get_person_names(text)
      base_url = 'https://api.ce-cotoha.com/api/dev/nlp/v1/'
      api_path = 'ne'
      url = base_url + '/' + api_path
      access_token = get_access_token
      json = {
        sentence: text,
        type: "default"
      }.to_json
      headers = {
        content_type: :json,
        accept: :json,
        Authorization: "Bearer #{access_token}",
      }

      response = RestClient.post(url, json, headers)
      body = JSON.parse(response.body)
      result = body['result']
      result.map do |keyword|
        keyword['std_form'] if keyword['class'] == 'PSN'
      end.compact
    end
  end
end
