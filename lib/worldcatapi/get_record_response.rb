require 'ostruct'
require 'marc'

module WORLDCATAPI
  class GetRecordResponse 

    attr_accessor :record, :raw

    def initialize(doc)
      #super doc
      @raw = doc
      parse_marcxml(doc)
    end

   def parse_marcxml(xml)
      
      reader = MARC::XMLReader.new(StringIO.new(xml))
      
      for r in reader        
        @record = OpenStruct.new
        @record.id = r["001"].value
        @record.title = r['245']['a']
        @record.author = Array.new.push r['100']['a']
        @record.summary = r['500']['a']
        @record.link = "http://www.worldcat.org/oclc/#{@record.id}"
        @record.isbn = r['020']['a']
        @record.publisher = r['260'].value
        @record.published_date = r['260']['c']
        @record.edition = r['250']['a'] if r['250']
        @record.physical_description = r['300'].value
        
      end
      
      @record.xml = xml
         
      @record
   end

  end
end
