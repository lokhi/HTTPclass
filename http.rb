require 'socket'

class HTTP
   class Request
   
   attr_accessor :status, :headers, :body
   
     def initialize(s)
     	@status=s.gets
     	@headers={}
     	begin
          header = s.gets
          header_name, header_val = header.chomp.split(': ')
          headers[header_name] = header_val
        end until header.chomp.empty?
          
        @body = nil
        unless headers["Content-Length"].nil?
          @body = s.read(headers["Content-Length"].to_i)
        end
     end
     
     def type
       status.split(" ")[0]
     end
     
     def path
       status.split(" ")[1]
     end
   end
 	
  class Response
    attr_accessor :code,:code_message,:headers
    attr_reader :body
    
    def initialize
       @code = ""
       @code_message = ""
       @headers = {}
       @body = ""      
    end
    
    def write(str)
      @body = str
      @headers["Content-Length"]=str.length
    end
    
    def to_s
      str="#{@code} HTTP/1.1 #{@code_message}\n"
      headers.each{|key,val| str+="#{key}: #{val}\n"}
      str+="\n#{@body}"
    end
    
 	
  end
end
