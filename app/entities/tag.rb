module Entities
  require 'securerandom'

  class Tag
    attr_reader :description, :id

    def initialize(description:)
      @id = SecureRandom.random_number(100)
      @description = description
    end
  end
end
