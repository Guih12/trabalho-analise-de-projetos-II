
require_relative '../entities/enums/type_input'
require_relative '../entities/enums/format'
require_relative '../entities/teacher'


require 'pry'
class Controller

  def self.create_orientation(params)
    response = current_teacher.create_orientation(params: params)

    return "Orientação criada com sucesso!!" if response
  end

  def self.select_input = Entities::Enums::TypeInput::TYPE

  def self.select_format = Entities::Enums::Format::TYPE

  def self.current_teacher ;end

end