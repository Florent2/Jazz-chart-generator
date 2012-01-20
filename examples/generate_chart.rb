#!/usr/bin/env ruby

require_relative "../lib/music_chart_generator"
script_name = File.basename __FILE__

abort "#{script_name}: Usage: #{__FILE__} chart_file first_chord second_chord" \
if ARGV.size != 3

begin
  MusicChartGenerator::Application.new(*ARGV).run
rescue MusicChartGenerator::Chart::FirstChordsError => error
  abort "#{script_name}: #{error.message}"
end
