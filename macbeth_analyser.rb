require './app/analyser.rb'

source_xml = "http://www.ibiblio.org/xml/examples/shakespeare/macbeth.xml"

puts Analyser.new(source_xml, "html").analyze_macbeth
