require "minitest/autorun"
require_relative "../lib/markov_chain"

describe MarkovChain do

  describe "#generate_new_sequence" do

    before do
      @markov_chain = MarkovChain.new [1, 2, 1, 2, 3]  
    end

    describe "when the first and second states appear consecutively in the \
chain" do
      
      before do
        @new_sequence = @markov_chain.generate_new_sequence 1, 2
      end

      it "returns a new sequence of size between 3 and the original size" do
        @new_sequence.size.must_be_within_delta 3, 5
      end

      it "returns a new semi random sequence" do
        possible_generated_sequences = [
          [1, 2, 1, 2, 3],
          [1, 2, 1, 2, 1],
          [1, 2, 3]
        ]
        possible_generated_sequences.must_include @new_sequence
      end

    end

    describe "when the first and second states do not appear consecutively \
in the chain" do

      it "raises a FirstStatesError exception" do
        lambda { @markov_chain.generate_new_sequence(6,7) }.must_raise \
          MarkovChain::FirstStatesError
      end

    end

  end

end
