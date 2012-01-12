require "minitest/autorun"
require_relative "../lib/music_chart_generator"

describe MusicChartGenerator do

  describe "#get_new_chart" do

    before do
      @music_chart_generator = MusicChartGenerator.new [1, 2, 1, 2, 3]  
    end

    describe "when the first and second states appear consecutively in the \
chart" do
      
      before do
        @new_chart = @music_chart_generator.get_new_chart 1, 2
      end

      it "returns a new chart of size between 3 and the original size" do
        @new_chart.size.must_be_within_delta 3, 5
      end

      it "returns a new semi random chart" do
        possible_generated_charts = [
          [1, 2, 1, 2, 3],
          [1, 2, 1, 2, 1],
          [1, 2, 3]
        ]
        possible_generated_charts.must_include @new_chart
      end

    end

    describe "when the first and second states do not appear consecutively \
in the chart" do

      it "raises a FirstChordError exception" do
        lambda { @music_chart_generator.get_new_chart(6,7) }.must_raise \
          MusicChartGenerator::FirstChordsError
      end

    end

  end

end
