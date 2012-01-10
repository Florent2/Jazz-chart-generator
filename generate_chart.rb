#!/usr/bin/env ruby

require_relative "./lib/markov_chain"

abort "Usage: ./generate_chart.rb chart_file first_chord" unless ARGV.size == 2
chart_file  = ARGV[0]
first_chord = ARGV[1]

sequence = []
IO.readlines(chart_file).each do |line|
  sequence.concat line.scan(/\S+/)
end

markov_chain = MarkovChain.new sequence
begin
  puts markov_chain.generate_new_sequence first_chord
rescue MarkovChain::FirstStateError
  abort "Your first chord does not appear in the initial chart or it has no \
following chord" 
end
