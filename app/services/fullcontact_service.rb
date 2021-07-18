class FullcontactService
  class << self

    def get_fullcontact_api(email)
      require "uri"
      require "net/https"

      url = URI("https://api.fullcontact.com/v2/person.json?email=renilraphyp100@gmail.com")

      https = Net::HTTP.new(url.host, url.port)
      https.use_ssl = true

      request = Net::HTTP::Get.new(url)
      request["X-FullContact-APIKey"] = FULLCONTACT_APIKEY

      response = https.request(request)
      if response && (response.code == 200)
        return JSON.parse(response.body)
      else
        return nil
      end
      return response
    end

  end
end