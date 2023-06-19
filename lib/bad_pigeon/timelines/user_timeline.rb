require 'bad_pigeon/elements/timeline_instruction'
require 'bad_pigeon/util/assertions'

module BadPigeon
  class UserTimeline
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
        list = @json['data']['user']['result']['timeline_v2']['timeline']['instructions']
        assert { list.all? { |i| EXPECTED_INSTRUCTIONS.include?(i['type']) }}
        list.map { |j| TimelineInstruction.new(j, self.class) }
      end
    end
  end
end
