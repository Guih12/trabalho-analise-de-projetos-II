module Entities
  class FormatMultipleChoice
    attr_reader :format

    def initialize(format:)
      @format = format
    end
  end
end
