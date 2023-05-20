require_relative '../app/entities/form_field'
require_relative '../app/entities/format_multiple_choice'
require_relative '../app/entities/enums/format'
require_relative '../app/entities/enums/type_input'

RSpec.describe do
  describe '.new' do
    context 'quando receber o tipo de campo e nome' do
      context 'quando o tipo de campo for MULTIPLA_ESCOLHA' do
        let(:form_field) do
          Entities::FormField.new(type_input: Entities::Enums::TypeInput::TYPE[:MULTIPLE_CHOICE],
                                  name: 'xxx',
                                  format_multiple_choice: Entities::FormatMultipleChoice.new(format: Entities::Enums::Format::TYPE[:UMA_OPCAO]))
        end

        it 'retorna uma nova instancia de campo formulário e também uma relação com Formato Multipla Escolha' do
          expect(form_field).to be_an_instance_of(Entities::FormField)
          expect(form_field.format_multiple_choice).to be_an_instance_of(Entities::FormatMultipleChoice)
        end
      end

      context 'quando o tipo de campo não for MULTIPLA_ESCOLHA' do
        let(:form_field) do
          Entities::FormField.new(type_input: Entities::Enums::TypeInput::TYPE[:NUMBER_FIELD],
                                  name: 'xxx',
                                  format_multiple_choice: Entities::FormatMultipleChoice.new(format: Entities::Enums::Format::TYPE[:UMA_OPCAO]))
        end

        it 'retorna uma noa instancia de campo formulário e Formato Multiplica Escolha igual a nil' do
          expect(form_field).to be_an_instance_of(Entities::FormField)
          expect(form_field.format_multiple_choice).to be_nil
          expect(form_field.format_multiple_choice).to_not be_an_instance_of(Entities::FormatMultipleChoice)
        end
      end
    end
  end
end
