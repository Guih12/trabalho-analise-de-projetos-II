module Entities
  require 'securerandom'
  require_relative './orientation'

  class Teacher
    attr_reader :name, :orientations

    def initialize(name:)
      @id = SecureRandom.random_number(100)
      @name = name
      @orientations = []
    end

    def create_orientation(params:)
      orientation = Entities::Orientation.new(
        validate: params[:validate],
        vacancy_with_scholarship: params[:vacancy_with_scholarship],
        vacancy_without_scholarship: params[:vacancy_without_scholarship],
        url_edital: params[:url_edital],
        teacher: self
      )

      orientation.create_tags(params[:tags])           unless params[:tags].nil?
      orientation.create_form(params[:form_fields])    unless params[:form_fields].nil?

      if orientation.valid?
        @orientations << orientation
        return true
      end

      false
    end

    def self.orientations(_word)
      []
    end
  end
end
