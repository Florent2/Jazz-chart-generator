#!/usr/bin/env ruby

require_relative "../lib/music_chart_generator"
script_name = File.basename __FILE__

if ARGV.size != 3
  abort "#{script_name}: Usage: #{__FILE__} chart_file first_chord second_chord"
end

begin
  MusicChartGenerator::Application.new(chart_file:    ARGV[0], 
                                       first_chord:   ARGV[1],
                                       second_chord:  ARGV[2]
                                      ).run
rescue MusicChartGenerator::Chart::FirstChordsError => error
  abort "#{script_name}: #{error.message}"
end
