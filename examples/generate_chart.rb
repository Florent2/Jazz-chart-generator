#!/usr/bin/env ruby

require_relative "../lib/music_chart_generator"

begin
  MusicChartGenerator::Application.new(ARGV).run
rescue ArgumentError, MusicChartGenerator::Chart::FirstChordsError => error
  abort "music_chart_generator: #{error.message}"
end
