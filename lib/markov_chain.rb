class MarkovChain

  class FirstStatesError < StandardError; end

  def initialize(sequence=[])
    @sequence = sequence
  end

  def generate_new_sequence(first_state, second_state)
    next_states = build_next_states_structure

    raise FirstStatesError if next_states[[first_state, second_state]].size.zero?

    new_sequence = [first_state, second_state]
    (@sequence.size - 2).times do 
      new_sequence << next_states[[new_sequence[-2], new_sequence[-1]]].sample
    end
    new_sequence.compact # remove nil elements, might exist if is generated
                         # a couple of 2 states that do not exist in the
                         # original sequence
  end

  private
  
  # returns a data structure that lists for each couple of consecutive states
  # of the sequence the different states which follow them
  #
  # resulting example for the sequence F A B A B F A B A
  # { 
  #   ["F", "A"] => ["B", "B"],
  #   ["A", "B"] => ["A", "F", "A"],
  #   ["B", "A"] => ["B"],
  #   ["B", "F"] => ["A"]
  # }
  
  def build_next_states_structure
    next_states = Hash.new { |hash, k| hash[k] = Array.new }

    @sequence.each_cons(3) do |state1, state2, next_state| 
      next_states[[state1, state2]] << next_state
    end

    next_states
  end

end
