require 'test_helper'

class SruSearchResponseTest  < Test::Unit::TestCase
  
  setup do
    @response_marcxml =  File.read("test/sru_response_example.xml")
  end

  should "parse MarcXML response using marc ruby library" do    
    response = WORLDCATAPI::SruSearchResponse.new(@response_marcxml)
    assert_not_nil response.records, "There are Records"
    assert_not_nil response.header, "There's a header"
    
  end
end
