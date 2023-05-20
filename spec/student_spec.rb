require_relative '../app/entities/student'

RSpec.describe do
  describe '.new' do
    context 'quando receber nome e matricula' do
      let(:student) { Entities::Student.new(name: 'George', registration: '123456') }

      it 'retorne uma nova instancia de aluno' do
        expect(student).to be_an_instance_of(Entities::Student)
      end
    end
  end
end
