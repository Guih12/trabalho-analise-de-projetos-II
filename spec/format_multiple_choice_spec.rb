require_relative '../app/entities/format_multiple_choice'
require_relative '../app/entities/enums/format'

RSpec.describe Entities::FormatMultipleChoice do
  describe '.new' do
    context 'quando receber um formato' do
      let(:format_multiple_choice) do
        Entities::FormatMultipleChoice.new(format: Entities::Enums::Format::TYPE[:UMA_OPCAO])
      end

      it 'retorna uma nova instancia de formatMultipleChoice' do
        expect(format_multiple_choice).to be_an_instance_of(Entities::FormatMultipleChoice)
      end
    end
  end
end
