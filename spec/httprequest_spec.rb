$:.unshift File.join(File.dirname(__FILE__), '..')

require 'http'

	
describe HTTP::Request do
  before(:each) do
    @socket = double("socket")
    @socket.stub(:gets).and_return("GET /page.html HTTP/1.1","Host: localhost:8080","User-Agent: agent du stub","Content-Length: 20","Content-Type: application/x-www-form-urlencoded", "Cookie: Session_id=abcdef1234","")
    @socket.stub(:read).and_return("Le contenu de la req")
  end

  describe "Construction" do    
    it "should use gets method of a socket" do
      @socket.should_receive(:gets).and_return("GET /a HTTP/1.1")
      req = HTTP::Request.new(@socket)
     end
     
    it "should initialize the status" do
     req = HTTP::Request.new(@socket)
     req.status.should be_an String
     req.status.should == "GET /page.html HTTP/1.1"
    end
    
    it "should initialize the header" do
      req = HTTP::Request.new(@socket)
      req.headers.should be_an Hash
      req.headers["Host"].should == "localhost:8080"
      req.headers["User-Agent"].should == "agent du stub"
      req.headers["Cookie"].should == "Session_id=abcdef1234"
    end
    
    # Context avec un test avec le body et l'autre test sans ?
    it "should initialize the body" do
      req = HTTP::Request.new(@socket)
      req.body.should be_an String
      req.body.should == "Le contenu de la req"
    end
  end	
  
  it "should return the type of request" do
    req = HTTP::Request.new(@socket)
    req.type.should == "GET"
  end 
  
  it "should return the pass of request" do
    req = HTTP::Request.new(@socket)
    req.path.should == "/page.html"
  end
  
end


