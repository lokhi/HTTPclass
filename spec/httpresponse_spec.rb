$:.unshift File.join(File.dirname(__FILE__), '..')

require 'http'

	
describe HTTP::Response do

  context "when just created" do
    it "should have a blank code" do
      subject.code.should == ""
    end
    
    it "should have a blank code_message" do
      subject.code_message.should == ""
    end
    
    it "should have an empty headers" do
      subject.headers.should == {}
    end
    
    it "should have an empty body" do
      subject.body.should == ""
    end
  end
  
  it "should accept new header" do
    subject.headers["User_agent"] = "nouvel user agent"
    subject.headers["User_agent"].should == "nouvel user agent"
  end
  
  it "should write into the body" do
    subject.write "Je suis le body de la reponse"
    subject.body.should == "Je suis le body de la reponse"
  end
  
  it "should have the method to_s" do
    subject.code = 200
    subject.code_message = "ok"
    subject.headers["Set_Cookie"] = "session_id=1234abcd"
    subject.write "body de la rep"
    subject.to_s.should == "200 HTTP/1.1 ok\nSet_Cookie: session_id=1234abcd\nContent-Length: 14\n\nbody de la rep"
  end




end
