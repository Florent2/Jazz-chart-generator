module MusicChartGenerator

  class Application

    #def initialize(display = MusicChartGenerator::Display.new, chart_file, \
                   #first_chord, second_chord)
    def initialize(params)
      @display      = params.fetch :display, MusicChartGenerator::Display.new
      @chart_file   = params.fetch :chart_file
      @first_chord  = params.fetch :first_chord
      @second_chord = params.fetch :second_chord
    end

    def run
      chords = []
      IO.readlines(@chart_file).each { |line| chords.concat line.scan(/\S+/) }

      new_chart = Chart.new(chords).get_new_chart @first_chord, @second_chord
      @display.render new_chart
    end

  end

end
