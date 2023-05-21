
require_relative '../entities/enums/type_input'
require_relative '../entities/enums/format'
require_relative '../entities/teacher'
require_relative '../entities/orientation'


require 'pry'
class Controller

  def self.create_orientation(params)
    response = current_teacher.create_orientation(params: params)

    return "Orientação criada com sucesso!!" if response
  end

  def self.sign_up_in_orientation(orientation)
    current_student.sign_up_for_orientation(orientation)
  end

  def self.search_orientations(word: )
    Entities::Teacher.orientations(word).orientations.map do |orientation|
        {
          teacher: orientation.teacher.name,
          tags: orientation.tags.map(&:description),
          vacancy_with_scholarship: orientation.vacancy_with_scholarship,
          vacancy_without_scholarship: orientation. vacancy_without_scholarship
        }
    end
  end

  def self.select_input = Entities::Enums::TypeInput::TYPE

  def self.select_format = Entities::Enums::Format::TYPE

end