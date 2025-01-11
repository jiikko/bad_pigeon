require 'bad_pigeon/elements/timeline_instruction'
require 'bad_pigeon/util/assertions'

module BadPigeon
  # Represents a timeline response for a timeline of user's posts as seen on their profile page.
  #
  # A timeline includes one or more "instructions" ({BadPigeon::TimelineInstruction}), and usually in particular a
  # "TimelineAddEntries" instruction which provides one or more entries containing tweets.

  class SearchTimeline
    include Assertions

    EXPECTED_INSTRUCTIONS = [
      TimelineInstruction::Type::ADD_ENTRIES,
      TimelineInstruction::Type::CLEAR_CACHE,
      TimelineInstruction::Type::PIN_ENTRY
    ]

    def initialize(json)
      @json = json
    end

    def instructions
      @instructions ||= begin
        list = @json.dig('data', 'search_by_raw_query', 'search_timeline', 'timeline', 'instructions') || []
        assert { list.all? { |i| EXPECTED_INSTRUCTIONS.include?(i['type']) } }
        list.map { |j| TimelineInstruction.new(j, self.class) }
      end
    end
  end
end
