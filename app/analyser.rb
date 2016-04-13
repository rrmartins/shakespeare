require 'open-uri'
require 'nokogiri'
class Analyser
  def initialize(xml_source, source_type="local")
    open_xml = source_type == "html" ? open(xml_source) : xml_source
    @doc = Nokogiri::XML(open_xml) {|config| config.strict}
  end

  def analyze_macbeth
    list = sum_lines_by_speaker
    display(list)
  end

  def sum_lines_by_speaker
    speeches = @doc.xpath("//SPEECH[not(SPEAKER='ALL')]")
    list = speeches.inject(Hash.new(0)) do |agg, speech|
      character = speech.xpath("./SPEAKER").text.to_s
      lines = speech.xpath("./LINE")
      lines.each do |line|
        agg[character] += 1
      end
      agg
    end
  end

  def display(hash)
    output = hash.sort_by{|k,v|-v}.collect {|k,v| "#{v} #{k}"}.join("\n")
  end
end
