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
        
        @record.author = Array.new        
        if r['100']
          @record.author.push r['100']['a'] if r['100']
        elsif
          @record.author = extract_multiple(r, '700', 'a')
        end
        
        @record.summary = extract_multiple(r,'500', 'a') if r['500']                        
        @record.isbn = extract_multiple(r, '020', 'a')
        
        @record.publisher = r['260'].value if r['260']
        @record.published_date = r['260']['c'] if r['260']
        @record.edition = r['250']['a'] if r['250']
        @record.physical_description = r['300'].value if r['300']
                
        @record.link = "http://www.worldcat.org/oclc/#{@record.id}"  
      end
      
      @record.xml = xml
         
      @record
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
