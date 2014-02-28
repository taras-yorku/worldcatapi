module WORLDCATAPI
  class GetRecordResponse 

    attr_accessor :record, :raw

    def initialize(doc)
      #super doc
      @raw = doc
      parse_marcxml(doc)
    end

   def parse_marcxml(xml)
      _title = ""
      #this is an array
      _author = Array.new()
      _link = ""
      _id = ""
      _citation = ""
      _summary = ""
      _xml = xml
      _rechash = {}
      _x = 0

      doc = Nokogiri::XML(xml)
      doc.remove_namespaces!
      nodes = doc.xpath("/record")
      
      # puts "NODE Count: " + nodes.length.to_s
      
      nodes.each { |item |
	 _title = item.xpath("datafield[@tag='245']/subfield[@code='a'][position()=1]").text
	 
         if item.xpath("datafield[@tag='1*']") != nil
             item.xpath("datafield[@tag='1*']").each {|i|
	        _author.push(i.xpath("subfield[@code='a']").text)
             }	
         end

         if item.xpath("datafield[@tag='7*']") != nil
	     item.xpath("datafield[@tag='7*']").each {|i|
	        _author.push(i.xpath("subfield[@code='a']").text)
 	     }
   	 end	

	 if item.xpath("controlfield[@tag='001']") != nil
	    _id = item.xpath("controlfield[@tag='001']").text
	    _link = 'http://www.worldcat.org/oclc/' + _id.to_s
	 end	 
 	
	 if item.xpath("datafield[@tag='520']") != nil
	    _summary = item.xpath("datafield[@tag='520']/subfield[@code='a'][position()=1]").text
	 else
	    if item.xpath("datafield[@tag='500']") != nil
	       _summary = item.xpath("datafield[@tag='500']/subfield[@code='a'][position()=1]").text
	    end
	 end
         
         _rechash = {:title => _title, :author => _author, :link => _link, :id => _id, :citation => _citation, 
		     :summary => _summary, :xml => item.to_s}
      }
      @record = _rechash
   end

  end
end
