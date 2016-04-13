require 'spec_helper.rb'

describe Analyser do
  context "error formated xml from source" do
    it {expect{ Analyser.new('foo') }.to raise_error(Nokogiri::XML::SyntaxError)}
  end

  context "success" do
    let(:analyser) { Analyser.new(@xml) }

    context "#new" do
      before(:each) do
        @xml = "<PLAY><SPEECH><SPEAKER>Bob</SPEAKER>"
        @xml += "<LINE>Hello</LINE><LINE>Bye</LINE></SPEECH></PLAY>"
      end
      it "should analyser is Analyser class" do
        expect(analyser.class).to eq Analyser
      end
    end

    context ".analyze_macbeth" do
      context "Speaker Bob and 2 lines" do
        before(:each) do
          @xml = "<PLAY><SPEECH><SPEAKER>Bob</SPEAKER>"
          @xml += "<LINE>Hello</LINE><LINE>Bye</LINE></SPEECH></PLAY>"
        end

        it "should return speaker Bob and 2 lines" do
          expect(analyser.analyze_macbeth).to eq "2 Bob"
        end
      end

      
    end
  end
end
