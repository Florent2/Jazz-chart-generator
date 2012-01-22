require "forwardable"

module MusicChartGenerator

  class ChordList
    extend Forwardable
    include Enumerable

    def initialize(chords)
      @chords = chords
    end

    def_delegators :@chords, :each, :size, :to_a
  end

end
