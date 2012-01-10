class MarkovChain

  class FirstStateError < StandardError; end

  def initialize(sequence=[])
    @sequence = sequence
    
    @next_states = Hash.new { |hash, k| hash[k] = Array.new }
    @sequence.each_cons(2) do |state, next_state| 
      @next_states[state] << next_state unless next_state.nil?
    end
  end

  def generate_new_sequence(first_state)
    raise FirstStateError if @next_states[first_state].size.zero?

    new_sequence = [first_state]
    (@sequence.size - 1).times do 
      new_sequence << @next_states[new_sequence.last].sample
    end
    new_sequence
  end

end
