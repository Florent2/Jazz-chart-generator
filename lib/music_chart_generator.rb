class MusicChartGenerator

  class FirstChordsError < StandardError; end

  def initialize(chart=[])
    @chart = chart
  end

  def get_new_chart(first_chord, second_chord)
    next_possible_chords = get_next_possible_chords

    raise FirstChordsError if \
      next_possible_chords[[first_chord, second_chord]].size.zero?

    new_chart = [first_chord, second_chord]
    (@chart.size - 2).times do 
      new_chart << next_possible_chords[[new_chart[-2], new_chart[-1]]].sample
    end
    
    # remove nil elements, might exist if is generated
    # a couple of 2 chords that do not exist in the
    # original sequence
    new_chart.compact 
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

    @chart.each_cons(3) do |chord1, chord2, next_chord| 
      next_possible_chords[[chord1, chord2]] << next_chord
    end

    next_possible_chords
  end

end
