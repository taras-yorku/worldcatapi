require 'test_helper'

class SruSearchResponseTest  < Test::Unit::TestCase
  
  setup do
    @response_marcxml =  File.read("test/sru_response_example.xml")
  end

  should "parse MarcXML response using marc ruby library" do    
    response = WORLDCATAPI::SruSearchResponse.new(@response_marcxml)
    assert_not_nil response.records, "There are Records"
    assert_not_nil response.header, "There's a header"
    
    # test header stuff
    
    assert response.records.size > 1, "there are more the one response records"
    
    record = response.records.first
    
    assert_equal "The Civil War", record.title, "Title must match"
    assert_equal "57408580", record.id, "Id must match"
    
    assert_equal 13, record.author.size, "Thirteen authors for Civil War"
    assert_equal "Burns, Ken,", record.author.first, "Author must match"
    assert_equal "1415702470", record.isbn.first, "ISBN must match"
    assert_equal "Burbank, CA :PBS Home Video :Distributed by Paramount Home Entertainment,2004.", record.publisher, "Publisher must match"
    assert_equal "2004.", record.published_date, "Published Date matches"
    assert_equal "5 videodiscs (ca. 700 min.) :sd., col. with b&w ;4 3/4 in.", record.physical_description, "PhysDesc must match"
    assert_equal "Originally broadcast as a television mini-series in 1990; produced in 1989.", record.summary.first, "Summary must match"
    
  end
end
