class EmployeeApiService
    BASE_URI = "https://dummy-employees-api-8bad748cda19.herokuapp.com/employees"
  
    def self.list_employees(page: nil)
      uri = URI("#{BASE_URI}#{'?page=' + page if page}")
      perform_request(uri)
    end
  
    def self.fetch_employee(id)
      uri = URI("#{BASE_URI}/#{id}")
      perform_request(uri)
    end
  
    def self.create_employee(params)
      uri = URI(BASE_URI)
      perform_post_request(uri, params)
    end
  
    def self.update_employee(id, params)
      uri = URI("#{BASE_URI}/#{id}")
      perform_put_request(uri, params)
    end
  
    private
  
    def self.perform_request(uri)
      response = Net::HTTP.get(uri)
      JSON.parse(response)
    end
  
    def self.perform_post_request(uri, params)
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = (uri.scheme == 'https')
      request = Net::HTTP::Post.new(uri)
      request['Content-Type'] = 'application/json'
      request.body = params.to_json
      response = http.request(request)
      JSON.parse(response.body)
    end
  
    def self.perform_put_request(uri, params)
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = (uri.scheme == 'https')
      request = Net::HTTP::Put.new(uri)
      request['Content-Type'] = 'application/json'
      request.body = params.to_json
      response = http.request(request)
      JSON.parse(response.body)
    end
  end
  