#!/usr/bin/env ruby
require 'rbconfig'
abort "This script requires JRuby" unless RbConfig::CONFIG["ruby_install_name"] == "jruby"

require 'hammelin'
require_relative "../lib/music_chart_generator"
script_name = File.basename __FILE__

if ARGV.size != 3
  abort "#{script_name}: Usage: #{__FILE__} chart_file first_chord second_chord"
end

begin
  args = { chart_file:   ARGV[0],
           first_chord:  ARGV[1],
           second_chord: ARGV[2]
         }

  application = MusicChartGenerator::Application.new(args)
  chords = application.process_chart_file.chords

  Hammelin.compose("something.mid") do
    play_string "I[ALTO_SAX]" + chords.join(" ")
  end

rescue MusicChartGenerator::Chart::FirstChordsError => error
  abort "#{script_name}: #{error.message}"
end
