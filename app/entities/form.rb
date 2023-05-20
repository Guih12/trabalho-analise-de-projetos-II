module Entities
  require 'securerandom'

  class Form
    attr_reader :id, :form_fields

    def initialize(form_fields:)
      @id          = SecureRandom.random_number(100)
      @form_fields = []
      add_form_fields(form_fields)
    end

    def add_form_fields(form_fields)
      @form_fields << form_fields if validate_quantity_form_fields
    end

    private

    def validate_quantity_form_fields
      @form_fields.size >= 1
    end
  end
end
