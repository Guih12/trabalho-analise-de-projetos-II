module Entities
  require_relative './enums/type_input'
  require_relative './format_multiple_choice'
  require 'pry'

  class FormField
    attr_reader :type_input, :name, :format_multiple_choice

    def initialize(type_input:, name:, format_multiple_choice: nil)
      @type_input             = type_input
      @name                   = name
      @format_multiple_choice = set_format_multiple_choice(format_multiple_choice)
    end

    private

    def set_format_multiple_choice(format)
      @format_multiple_choice = Entities::FormatMultipleChoice.new(format: format) if validate_type_input
    end

    def validate_type_input
      @type_input == Entities::Enums::TypeInput::TYPE[:MULTIPLE_CHOICE]
    end
  end
end
