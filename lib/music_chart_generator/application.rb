module MusicChartGenerator

  class Application

    def initialize(argv, display = MusicChartGenerator::Display.new)
      raise ArgumentError.new("Usage: ./generate_chart.rb chart_file \
first_chord second_chord") unless argv.size == 3

      @chart_file   = argv[0]
      @first_chord  = argv[1]
      @second_chord = argv[2]

      @display = display 
    end

    def run
      chords = []
      IO.readlines(@chart_file).each { |line| chords.concat line.scan(/\S+/) }

      new_chart = Chart.new(chords).get_new_chart @first_chord, @second_chord
      @display.render new_chart
    end

  end

end
