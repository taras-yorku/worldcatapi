require 'test_helper'

class GetRecordResponseTest  < Test::Unit::TestCase
  
  setup do
    @response_xml = "<record>\n    <leader>00000cam a2200000Ia 4500</leader>\n    <controlfield tag=\"001\">671660984</controlfield>\n    <controlfield tag=\"008\">101025s2008    nz      o     000 d eng d</controlfield>\n    <datafield ind1=\" \" ind2=\" \" tag=\"020\">\n      <subfield code=\"a\">9781775413158 (electronic bk.)</subfield>\n    </datafield>\n    <datafield ind1=\" \" ind2=\" \" tag=\"020\">\n      <subfield code=\"a\">1775413152 (electronic bk.)</subfield>\n    </datafield>\n    <datafield ind1=\"1\" ind2=\" \" tag=\"100\">\n      <subfield code=\"a\">Shakespeare, William,</subfield>\n      <subfield code=\"d\">1564-1616.</subfield>\n    </datafield>\n    <datafield ind1=\"1\" ind2=\"0\" tag=\"245\">\n      <subfield code=\"a\">Julius Caesar</subfield>\n      <subfield code=\"h\">[electronic resource] /</subfield>\n      <subfield code=\"c\">William Shakespeare.</subfield>\n    </datafield>\n    <datafield ind1=\" \" ind2=\" \" tag=\"260\">\n      <subfield code=\"a\">[Waiheke Island] :</subfield>\n      <subfield code=\"b\">Floating Press,</subfield>\n      <subfield code=\"c\">c2008.</subfield>\n    </datafield>\n    <datafield ind1=\" \" ind2=\" \" tag=\"300\">\n      <subfield code=\"a\">1 online resource (182 p.)</subfield>\n    </datafield>\n    <datafield ind1=\" \" ind2=\" \" tag=\"500\">\n      <subfield code=\"a\">Title from PDF title page (viewed Oct. 25, 2010).</subfield>\n    </datafield>\n    <datafield ind1=\"1\" ind2=\"0\" tag=\"600\">\n      <subfield code=\"a\">Caesar, Julius</subfield>\n      <subfield code=\"x\">Assassination</subfield>\n      <subfield code=\"v\">Drama.</subfield>\n    </datafield>\n    <datafield ind1=\"1\" ind2=\"0\" tag=\"600\">\n      <subfield code=\"a\">Brutus, Marcus Junius,</subfield>\n      <subfield code=\"d\">85 B.C.?-42 B.C.</subfield>\n      <subfield code=\"v\">Drama.</subfield>\n    </datafield>\n    <datafield ind1=\" \" ind2=\"0\" tag=\"651\">\n      <subfield code=\"a\">Rome</subfield>\n      <subfield code=\"x\">History</subfield>\n      <subfield code=\"y\">Civil War, 43-31 B.C.</subfield>\n      <subfield code=\"v\">Drama.</subfield>\n    </datafield>\n    <datafield ind1=\" \" ind2=\"0\" tag=\"650\">\n      <subfield code=\"a\">Conspiracies</subfield>\n      <subfield code=\"v\">Drama.</subfield>\n    </datafield>\n    <datafield ind1=\" \" ind2=\"0\" tag=\"650\">\n      <subfield code=\"a\">Assassins</subfield>\n      <subfield code=\"v\">Drama.</subfield>\n    </datafield>\n    <datafield ind1=\" \" ind2=\"4\" tag=\"655\">\n      <subfield code=\"a\">Electronic books.</subfield>\n    </datafield>\n    <datafield ind1=\"4\" ind2=\"0\" tag=\"856\">\n      <subfield code=\"3\">EBSCOhost</subfield>\n      <subfield code=\"u\">http://search.ebscohost.com/login.aspx?direct=true&amp;scope=site&amp;db=nlebk&amp;db=nlabk&amp;AN=313629</subfield>\n    </datafield>\n  </record>"
  end
  
  
  should "parse the response and put it into a proper record" do
    response = WORLDCATAPI::GetRecordResponse.new(@response_xml)
    assert_not_nil response.record, "Record was created"
    
    record = response.record
    assert_equal "Julius Caesar", record.title, "Title must match"
    assert_equal "671660984", record.id, "Id must match"
    
    assert_equal 1, record.author.size, "Only one author"
    assert_equal "Shakespeare, William,", record.author.first, "Author must match"
    assert_equal "9781775413158 (electronic bk.)", record.isbn, "ISBN must match"
    assert_equal "[Waiheke Island] :Floating Press,c2008.", record.publisher, "Publisher must match"
    assert_equal "1 online resource (182 p.)", record.physical_description, "PhysDesc must match"
    assert_equal "Title from PDF title page (viewed Oct. 25, 2010).", record.summary, "Summary must match"
        
    assert_not_nil record.xml, "Should copy xml"
  end
end