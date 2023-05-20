require_relative '../app/entities/teacher'

RSpec.describe Entities::Teacher do
  describe '.new' do
    context 'quando receber parametro nome' do
      subject { described_class.new(name: 'Vinicius') }

      it 'crie uma nova instancia de professor' do
        expect(subject).to be_a_instance_of(Entities::Teacher)
      end
    end
  end
end
