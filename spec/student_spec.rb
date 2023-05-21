require_relative '../app/entities/student'
require_relative '../app/entities/orientation'

require 'spec_helper'

RSpec.describe do
  describe '.new' do
    context 'quando receber nome e matricula' do
      let(:student) { Entities::Student.new(name: 'George', registration: '123456') }

      it 'retorne uma nova instancia de aluno' do
        expect(student).to be_an_instance_of(Entities::Student)
      end
    end
  end

  describe '.sign_up_for_orientation' do
    context 'quando um aluno já buscou por uma orientação' do
      context 'quando o mesmo já selecionou em qual deseja se inscrever' do
        let(:student) { Entities::Student.new(name: 'George', registration: '123456') }

        let(:orientation) do
          Entities::Orientation.new(validate: Time.now, vacancy_with_scholarship: 10, vacancy_without_scholarship: 20,
                                    url_edital: 'foo-bar')
        end

        it 'deve criar uma inscrição de uma orientação e retornar uma mesagem de suscesso e quantidade de vagas restantes' do
          expect(student.sign_up_for_orientation(orientation)).to eq 'Inscrição realizada com sucesso!! quantidade de vagas restantes: 29'
          expect(student.orientations).to all(be_an_instance_of(Entities::Orientation))
        end
      end
    end
  end
end
