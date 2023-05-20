require_relative '../app/entities/tag'

RSpec.describe Entities::Tag do
  describe '.new' do
    context 'quando receber uma descricão' do
      subject { described_class.new(description: 'ciências') }

      it 'retorne uma nova instancia de tag' do
        expect(subject).to be_a_kind_of(Entities::Tag)
      end
    end
  end
end
