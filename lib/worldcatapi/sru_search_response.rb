module WORLDCATAPI
  class SruSearchResponse 

    attr_accessor :header, :records, :raw

    def initialize(doc)
      @raw = doc
      @header = OpenStruct.new
      parse_marcxml(doc)      
    end

   def parse_marcxml(xml)
     @header = {}
     @records = Array.new
     
      _title = ""
      #this is an array
      _author = Array.new()
      _link = ""
      _id = ""
      _citation = ""
      _summary = ""
      _xml = xml
      _rechash = {}
      _records = Array.new()
      _x = 0

      xml = xml.gsub('<?xml-stylesheet type="text/xsl" href="/webservices/catalog/xsl/searchRetrieveResponse.xsl"?>', "")

      doc = Nokogiri::XML(xml)
      doc.remove_namespaces!
      @header["numberOfRecords"] = doc.xpath("//numberOfRecords").text
      @header["recordSchema"] = doc.xpath("//recordSchema").text
      @header["nextRecordPosition"] = doc.xpath("//nextRecordPosition").text
      @header["maxiumumRecords"] = doc.xpath("//maximumRecords").text
      @header["startRecord"] = doc.xpath("//startRecord").text
 
 
      xml_records =  doc.xpath("//records/record/recordData/record").to_xml

      reader = MARC::XMLReader.new(StringIO.new(xml_records))
      
      reader.each do |r|
        record = OpenStruct.new
        record.id = r["001"].value
        record.title = r['245']['a']
        #record.author = Array.new
        #record.author.push r['100']['a'] if r['100']
        record.summary = r['500']['a'] if r['500']
        record.link = "http://www.worldcat.org/oclc/#{record.id}"
        record.isbn = r['020']['a'] if r['020']
        record.publisher = r['260'].value
        record.published_date = r['260']['c']
        record.edition = r['250']['a'] if r['250']
        record.physical_description = r['300'].value
        @records << record
      end
      
      @records
      
      
      # nodes = doc.xpath("//records/record/recordData/record")
 #      nodes.each { |item |
 #         _title = item.xpath("datafield[@tag='245']/subfield[@code='a'][position()=1]").text
 #         if item.xpath("datafield[@tag='1*']") != nil 
 #            item.xpath("datafield[@tag='1*']/sufield[@code='a']").each { |i|
 #              _author.push(i.text)
 #           }
 #         end
 #         if item.xpath("datafield[@tag='7*']") != nil  
 #            item.xpath("datafield[@tag='7*']/sufield[@code='a']").each { |i|
 #              _author.push(i.text)
 #           }
 #         end
 # 
 #         if item.xpath("controlfield[@tag='001']") != nil 
 #           _id = item.xpath("controlfield[@tag='001'][position()=1]").text 
 #           _link = 'http://www.worldcat.org/oclc/' + _id.to_s
 #         end
 # 
 #         if item.xpath("datafield[@tag='520']") != nil
 #       _summary = item.xpath("datafield[@tag='520']/subfield[@code='a'][position()=1]").text
 #         else
 #            if item.xpath("datafield[@tag='500']") != nil
 #         _summary = item.xpath("datafield[@tag='500']/subfield[@code='a'][position()=1]").text
 #       end
 #    end
 # 
 #         _rechash = {:title => _title, :author => _author, :link => _link, :id => _id, :citation => _citation, 
 #          :summary => _summary, :xml => item.to_s}
 #   _records.push(_rechash)
 #      }
 #      @records = _records
   end

  end
end
