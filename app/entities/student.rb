module Entities
  require 'securerandom'

  class Student
    attr_reader :id, :name, :registration, :orientations

    def initialize(name:, registration:)
      @id           = SecureRandom.random_number(100)
      @name         = name
      @registration = registration
      @orientations = []
    end

    def sign_up_for_orientation(orientation)
      @orientations << orientation

      "Inscrição realizada com sucesso!! quantidade de vagas restantes: #{orientation.decrease_vacancies}"
    end
  end
end
