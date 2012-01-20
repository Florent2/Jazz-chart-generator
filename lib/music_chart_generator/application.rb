module MusicChartGenerator

  class Application

    def initialize(display = MusicChartGenerator::Display.new, chart_file, \
                   first_chord, second_chord)

      @display      = display 
      @chart_file   = chart_file
      @first_chord  = first_chord
      @second_chord = second_chord
    end

    def run
      chords = []
      IO.readlines(@chart_file).each { |line| chords.concat line.scan(/\S+/) }

      new_chart = Chart.new(chords).get_new_chart @first_chord, @second_chord
      @display.render new_chart
    end

  end

end
