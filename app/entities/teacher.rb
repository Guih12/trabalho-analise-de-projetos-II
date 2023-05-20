module Entities
  require 'securerandom'

  class Teacher
    attr_reader :name

    def initialize(name:)
      @id = SecureRandom.random_number(100)
      @name = name
    end
  end
end
