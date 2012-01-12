#!/usr/bin/env ruby

require_relative "../lib/markov_chain"

abort "Usage: ./generate_chart.rb chart_file first_chord second_chord" unless ARGV.size == 3
chart_file   = ARGV[0]
first_chord  = ARGV[1]
second_chord = ARGV[2]

sequence = []
IO.readlines(chart_file).each do |line|
  sequence.concat line.scan(/\S+/)
end

markov_chain = MarkovChain.new sequence
begin
  puts markov_chain.generate_new_sequence first_chord, second_chord
rescue MarkovChain::FirstStatesError
  abort "Your first chords do not appear consecutively in the initial chart \
or have no following chord" 
end
