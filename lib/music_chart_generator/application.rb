module MusicChartGenerator

  class Application

    def initialize(params)
      @display      = params.fetch :display, MusicChartGenerator::Display.new
      @chart_file   = params.fetch :chart_file
      @first_chord  = params.fetch :first_chord
      @second_chord = params.fetch :second_chord
    end

    def process_chart_file
      chords = File.foreach(@chart_file).map { |line| line.scan(/\S+/) }.flatten
      Chart.new(chords).transform @first_chord, @second_chord
    end

    def run
      chart = process_chart_file
      @display.render chart.chords
    end

  end

end
