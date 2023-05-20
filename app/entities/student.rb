module Entities
  require 'securerandom'

  class Student
    attr_reader :id, :name, :registration

    def initialize(name:, registration:)
      @id           = SecureRandom.random_number(100)
      @name         = name
      @registration = registration
    end
  end
end
