module WORLDCATAPI
  class OpenSearchResponse 

    attr_accessor :header, :records, :raw

    def initialize(doc)
      #super doc
      @raw = doc
      if doc.index('rss')
        parse_rss(doc)
      else
	parse_atom(doc)
      end
    end

   def parse_rss(xml)
      _title = ""
      #this is an array
      _author = Array.new()
      _link = ""
      _id = ""
      _citation = ""
      _summary = ""
      _xml = xml
      _record = Array.new()
      _x = 0

      doc = Nokogiri::XML(xml)

      namespaces = {'content' => 'http://purl.org/rss/1.0/modules/content/',
                    'atom' => 'http://www.w3.org/2005/Atom',
		    'opensearch' => 'http://a9.com/-/spec/opensearch/1.1/',
		    'srw' => 'http://www.loc.gov/zing/srw/'
                   }

      
      @header = {}
      @header["totalResults"] = doc.xpath("//opensearch:totalResults").text
      @header["startIndex"] = doc.xpath("//opensearch:startIndex").text
      @header["itemsPerPage"] = doc.xpath("//opensearch:itemsPerPage").text

      nodes = doc.xpath("//item", namespaces)
      nodes.each { |item |
         _title = item.xpath("title[position()=1]", namespaces).text 
         if item.xpath("author/name[position()=1]", namespaces) != nil 
            item.xpath("author/name", namespaces).each { |i|
              _author.push(i.text)
           }
         end
         if item.xpath("link[position()=1]") != nil 
           _link = item.xpath("link[position()=1]", namespaces).text
         end

         if _link != ''
           _id = _link.slice(_link.rindex("/")+1, _link.length-_link.rindex("/"))
         end 
         if item.xpath("content:encoded[position()=1]", namespaces) != nil
            _citation = item.xpath("content:encoded[position()=1]", namespaces).text
         end

         if item.xpath("description[position()=1]", namespaces) != nil
	    _summary = item.xpath("description[position()=1]", namespaces).text
	 end
         _rechash = {:title => _title, :author => _author, :link => _link, :id => _id, :citation => _citation, 
		     :summary => _summary, :xml => item.to_s}
         _record.push(_rechash)
      }
      @records = _record
   end

   def parse_atom(xml)
      _title = ""
      #this is an array
      _author = Array.new()
      _link = ""
      _id = ""
      _citation = ""
      _summary = ""
      _xml = xml
      _record = Array.new()
      _x = 0

      doc = Nokogiri::XML(xml)
      namespaces = {'n0' => 'http://www.w3.org/2005/Atom',
                    'opensearch' => 'http://a9.com/-/spec/opensearch/1.1/'
                   }


      @header = {}
      @header["totalResults"] = doc.xpath("//opensearch:totalResults").text
      @header["startIndex"] = doc.xpath("//opensearch:startIndex").text
      @header["itemsPerPage"] = doc.xpath("//opensearch:itemsPerPage").text

      nodes = doc.xpath("//*[local-name()='entry']")
      nodes.each { |item |
	 _author = []
         _title = item.xpath("*[local-name() = 'title'][position()=1]").text
 	 _tmpauthor = item.xpath("*[local-name() = 'author'][position()=1]")

         if _tmpauthor != nil
            if item.xpath("*[local-name() = 'author']/*[local-name() = 'name']") != nil
              item.xpath("*[local-name() = 'author']/*[local-name() = 'name']").each { |i|
                _author.push(i.text)
              }
            end
 	 end

         if item.xpath("*[local-name() = 'id']") != nil
           _link = item.xpath("*[local-name() = 'id']").text
         end

         if _link != ''
           _id = _link.slice(_link.rindex("/")+1, _link.length-_link.rindex("/"))
         end
         if item.xpath("*[local-name() = 'content']") != nil
            _citation = item.xpath("*[local-name() = 'content'][position()=1]").text
         end

         if item.xpath("*[local-name() = 'summary']") != nil
            _summary = item.xpath("*[local-name() = 'summary'][position()=1]").text
         end
         _rechash = {:title => _title, :author => _author, :link => _link, :id => _id, :citation => _citation,
                     :summary => _summary, :xml => item.to_s}
         _record.push(_rechash)
      }
      @records = _record
   end

  end
end
