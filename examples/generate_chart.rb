#!/usr/bin/env ruby

require_relative "../lib/music_chart_generator"

abort "Usage: ./generate_chart.rb chart_file first_chord second_chord" unless \
  ARGV.size == 3
chart_file   = ARGV[0]
first_chord  = ARGV[1]
second_chord = ARGV[2]

chart = []
IO.readlines(chart_file).each do |line|
  chart.concat line.scan(/\S+/)
end

music_chart_generator = MusicChartGenerator.new chart
begin
  puts music_chart_generator.get_new_chart first_chord, second_chord
rescue MusicChartGenerator::FirstChordsError
  abort "Your first chords do not appear consecutively in the initial chart \
or have no following chord" 
end
