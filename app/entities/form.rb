module Entities
  require 'securerandom'
  require 'pry'

  class Form
    attr_reader :id, :fields

    def initialize(form_fields:)
      @id          = SecureRandom.random_number(100)
      @fields = []
      create_form_field(form_fields)
    end

    def create_form_field(params)
      return unless validate_quantity_form_fields(params)

      params.each do |param|
        @fields << Entities::FormField.new(type_input: param[:type_input], name: param[:name],
                                                format_multiple_choice: param[:format_multiple_choice])
      end
    end

    private

    def validate_quantity_form_fields(fields)
      fields.size >= 1
    end
  end
end
