require 'http'
require 'oj'
module Sncf
  class ApiResponse
    attr_reader :response, :body, :content, :pagination, :start_page

    def initialize(response, query)
      @response = response
      @query    = query
      @body     = @response.body
      @content  = ''
      loop do
        chunk = @body.readpartial(HTTP::Connection::BUFFER_SIZE) rescue nil
        break if chunk.nil?
        @content << chunk
      end
      if @response.content_type.mime_type == 'application/json'
        @content = Oj.load(@content)
        @pagination = @content['pagination']
        @start_page = @pagination ? @pagination['start_page'] : 0
      end
    end
  end
end
