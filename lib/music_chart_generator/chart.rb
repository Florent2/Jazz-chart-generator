module MusicChartGenerator

  class Chart < Struct.new(:chords)

    FirstChordsError = Class.new StandardError

    def get_new_chart(first_chord, second_chord)
      @next_possible_chords ||= get_next_possible_chords

      raise FirstChordsError.new("Your first chords do not appear \
consecutively in the initial chart or have no following chord") \
if @next_possible_chords[[first_chord, second_chord]].empty?

      new_chords = [first_chord, second_chord]
      (chords.size - 2).times do 
        new_chords << @next_possible_chords[[new_chords[-2], new_chords[-1]]].sample
      end

      # compact removes nil elements, which might exist if is generated
      # a couple of 2 chords that do not exist in the original sequence
      Chart.new new_chords.compact 
    end

    private

    # returns a data structure that lists for each couple of consecutive chords
    # of the chart the different chords which follow them
    #
    # resulting example for the chart F A B A B F A B A
    # { 
    #   ["F", "A"] => ["B", "B"],
    #   ["A", "B"] => ["A", "F", "A"],
    #   ["B", "A"] => ["B"],
    #   ["B", "F"] => ["A"]
    # }

    def get_next_possible_chords
      next_possible_chords = Hash.new { |hash, k| hash[k] = Array.new }

      chords.each_cons(3) do |chord1, chord2, next_chord| 
        next_possible_chords[[chord1, chord2]] << next_chord
      end

      next_possible_chords
    end

  end

end
