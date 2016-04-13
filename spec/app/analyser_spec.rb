require 'spec_helper.rb'

describe Analyser do
  context "error formated xml from source" do
    it {expect{ Analyser.new('foo') }.to raise_error(Nokogiri::XML::SyntaxError)}
  end
end
