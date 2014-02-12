module WORLDCATAPI
  class GetLocationResponse 
   
    attr_accessor :institutions, :raw

    def initialize(doc)
      #super doc
      @raw = doc
      parse_holdings(doc)
    end

   def parse_holdings(xml)
      _oclc_symbol = ""
      _link = ""
      _copies = ""
      _xml = xml
      _instchash = {}
      _records = Array.new()
      _x = 0

      doc = Nokogiri::XML(xml)
      nodes = doc.xpath("//holding")
      nodes.each { |item |
         _oclc_symbol = item.xpath("institutionIdentifier/value[position()=1]").text

	 if item.xpath("electronicAddress/text") != nil
	    _link = item.xpath("electronicAddress/text[position()=1]").text
         end
	
   	 if item.xpath("holdingSimple/copiesSummary/copiesCount") != nil
	    _copies = item.xpath("holdingSimple/copiesSummary/copiesCount[position()=1]").text
	 end 


         _instchash = {:institutionIdentifier => _oclc_symbol, :link => _link, :copies => _copies ,
		     :xml => item.to_s}
	_records.push(_instchash)
      }
      @institutions = _records
   end

  end
end
