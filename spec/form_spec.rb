require_relative '../app/entities/form'
require_relative '../app/entities/form_field'
require_relative '../app/entities/format_multiple_choice'
require_relative '../app/entities/enums/format'
require_relative '../app/entities/enums/type_input'

require 'spec_helper'

RSpec.describe do
  describe '.new' do
    context 'quando receber 1 ou mais campos de fomulário' do
      let(:form_fields) do
        [
          Entities::FormField.new(type_input: Entities::Enums::TypeInput::TYPE[:MULTIPLE_CHOICE],
                                  name: 'xxx',
                                  format_multiple_choice: Entities::FormatMultipleChoice.new(format: Entities::Enums::Format::TYPE[:UMA_OPCAO])),
          Entities::FormField.new(type_input: Entities::Enums::TypeInput::TYPE[:MULTIPLE_CHOICE],
                                  name: 'xxx',
                                  format_multiple_choice: Entities::FormatMultipleChoice.new(format: Entities::Enums::Format::TYPE[:UMA_OPCAO]))
        ]
      end

      let(:form) { Entities::Form.new(form_fields: form_fields) }

      it 'retorna uma nova instancia de formulário e também uma lista de campo fomulário' do
        expect(form).to be_an_instance_of(Entities::Form)
        expect(form.form_fields).to all(be_an_instance_of(Entities::FormField))
      end
    end

    context 'quando receber 1 ou mais campos de fomulário' do
      let(:form_fields) do
        []
      end

      let(:form) { Entities::Form.new(form_fields: form_fields) }

      it 'retorna uma nova instancia de formulário porém a lista de campo formulário vazia' do
        expect(form).to be_an_instance_of(Entities::Form)
        expect(form.form_fields).to be_empty
      end
    end
  end
end
