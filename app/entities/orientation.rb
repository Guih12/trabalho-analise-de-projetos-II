module Entities
  require 'securerandom'
  require_relative './form'
  require_relative './tag'
  class Orientation
    attr_reader :teacher, :tags, :form

    def initialize(validate:, vacancy_with_scholarship:, vacancy_without_scholarship:, url_edital:, teacher: nil)
      @id                          = SecureRandom.random_number(100)
      @validate                    = validate
      @vacancy_with_scholarship    = vacancy_with_scholarship
      @vacancy_without_scholarship = vacancy_without_scholarship
      @url_edital                  = url_edital
      @teacher                     = teacher
      @tags                        = []
      @form                        = nil
    end

    def create_tags(tags)
      tags.each { |tag| @tags << Entities::Tag.new(description: tag) }
    end

    def create_form(form_fields)
      @form = Entities::Form.new(form_fields: form_fields) unless form_fields.nil?
    end

    def valid?
      if (@vacancy_with_scholarship + @vacancy_with_scholarship) == 0
        raise StandardError,
              'Erro: A quantidade de bolsa com vaga e sem bolsa não pode ser 0 ou negativo'
      end

      true
    end

    def decrease_vacancies
      (@vacancy_with_scholarship + @vacancy_without_scholarship) - 1
    end
  end
end
