module WORLDCATAPI
  class SruSearchResponse 

    attr_accessor :header, :records, :raw

    def initialize(doc)
      @raw = doc
      @header = OpenStruct.new
      parse_marcxml(doc)      
    end

   def parse_marcxml(xml)
      @header = OpenStruct.new
      @records = Array.new
     
      xml = xml.gsub('<?xml-stylesheet type="text/xsl" href="/webservices/catalog/xsl/searchRetrieveResponse.xsl"?>', "")

      doc = Nokogiri::XML(xml)
      doc.remove_namespaces!
      @header.numberOfRecords = doc.xpath("//numberOfRecords").text
      @header.recordSchema = doc.xpath("//recordSchema").text
      @header.nextRecordPosition = doc.xpath("//nextRecordPosition").text
      @header.maxiumumRecords = doc.xpath("//maximumRecords").text
      @header.startRecord = doc.xpath("//startRecord").text
 
 
      xml_records =  doc.xpath("//records/record/recordData/record").to_xml

      reader = MARC::XMLReader.new(StringIO.new(xml_records))
      
      reader.each do |r|
        record = OpenStruct.new
        record.id = r["001"].value
        record.title = r['245']['a']
        
        record.author = Array.new        
        if r['100']
          record.author.push r['100']['a'] if r['100']
        elsif
          record.author = extract_multiple(r, '700', 'a')
        end
        
        record.summary = extract_multiple(r,'500', 'a') if r['500']                        
        record.isbn = extract_multiple(r, '020', 'a')
        
        record.publisher = r['260'].value if r['260']
        record.published_date = r['260']['c'] if r['260']
        record.edition = r['250']['a'] if r['250']
        record.physical_description = r['300'].value if r['300']
        
        record.link = "http://www.worldcat.org/oclc/#{record.id}"  
        @records << record
      end
      
      @records
   end
   
   
   ## Extract Multiple fields for record
   def extract_multiple(record, field, tag)
     a = Array.new
     record.fields(field).each do |field|
       a.push field[tag]
     end
     return a
   end
   
  end
end
