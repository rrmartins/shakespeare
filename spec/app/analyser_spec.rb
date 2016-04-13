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

      context "aggregates counts for each speech of Bob" do
        before(:each) do
          @xml = "<PLAY><SPEECH><SPEAKER>Bob</SPEAKER>"
          @xml += "<LINE>Hello</LINE><LINE>Bye</LINE></SPEECH>"
          @xml += "<SPEECH><SPEAKER>Bob</SPEAKER>"
          @xml += "<LINE>Hello</LINE><LINE>Bye</LINE></SPEECH></PLAY>"
        end

        it "should return speaker Bob and 4 lines" do
          expect(analyser.analyze_macbeth).to eq "4 Bob"
        end
      end

      context "aggregates counts for each speech by each character" do
        before(:each) do
          @xml = "<PLAY><SPEECH><SPEAKER>Bob</SPEAKER>"
          @xml += "<LINE>Hello</LINE><LINE>Bye</LINE></SPEECH>"
          @xml += "<SPEECH><SPEAKER>Fred</SPEAKER>"
          @xml += "<LINE>Hello</LINE><LINE>Bye</LINE></SPEECH>"
          @xml += "<SPEECH><SPEAKER>Bob</SPEAKER>"
          @xml += "<LINE>Hello</LINE><LINE>Bye</LINE></SPEECH></PLAY>"
        end

        it "should return speaker Bob and 4 lines and Fred 2" do
          expect(analyser.analyze_macbeth).to eq "4 Bob\n2 Fred"
        end
      end

      context "excludes the 'ALL' character" do
        before(:each) do
          @xml = "<PLAY><SPEECH><SPEAKER>Bob</SPEAKER>"
          @xml += "<LINE>Hello</LINE><LINE>Bye</LINE></SPEECH>"
          @xml += "<SPEECH><SPEAKER>Fred</SPEAKER>"
          @xml += "<LINE>Hello</LINE><LINE>Bye</LINE></SPEECH>"
          @xml += "<SPEECH><SPEAKER>ALL</SPEAKER>"
          @xml += "<LINE>Hello</LINE><LINE>Bye</LINE></SPEECH>"
          @xml += "<SPEECH><SPEAKER>Bob</SPEAKER>"
          @xml += "<LINE>Hello</LINE><LINE>Bye</LINE></SPEECH></PLAY>"
        end

        it "should return speaker Bob and 4 lines and Fred 2" do
          expect(analyser.analyze_macbeth).to eq "4 Bob\n2 Fred"
        end
      end

      context "displays results in descending line count order" do
        before(:each) do
          @xml = "<PLAY><SPEECH><SPEAKER>Bob</SPEAKER>"
          @xml += "<LINE>Hello</LINE><LINE>Bye</LINE></SPEECH>"
          @xml += "<SPEECH><SPEAKER>Fred</SPEAKER>"
          @xml += "<LINE>Hello</LINE><LINE>Bye</LINE></SPEECH>"
          @xml += "<SPEECH><SPEAKER>ALL</SPEAKER>"
          @xml += "<LINE>Hello</LINE><LINE>Bye</LINE></SPEECH>"
          @xml += "<SPEECH><SPEAKER>Bill</SPEAKER>"
          @xml += "<LINE>Hello</LINE><LINE>Bye</LINE><LINE>Friends</LINE></SPEECH>"
          @xml += "<SPEECH><SPEAKER>Bob</SPEAKER>"
          @xml += "<LINE>Hello</LINE><LINE>Bye</LINE></SPEECH></PLAY>"
        end

        it "should return in order" do
          expect(analyser.analyze_macbeth).to eq "4 Bob\n3 Bill\n2 Fred"
        end
      end
    end
  end
end
