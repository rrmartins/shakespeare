require 'open-uri'
require 'nokogiri'
class Analyser
  def initialize(xml_source, source_type="local")
    open_xml = source_type == "html" ? open(xml_source) : xml_source
    @doc = Nokogiri::XML(open_xml) {|config| config.strict}
  end
end
