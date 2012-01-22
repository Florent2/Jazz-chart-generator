module MusicChartGenerator

  class Display
    
    def initialize(chords_per_line_nb=4)
      @chords_per_line_nb = chords_per_line_nb
    end

    def render(chords)
      longest_chord_size = chords.map(&:size).max

      chords.each_slice(@chords_per_line_nb) do |chords|
        line_of_chords = chords.map do |chord|
          chord + " " * (longest_chord_size - chord.size)
        end.join " "

        puts line_of_chords + "\n"
      end
    end
    
  end

end
