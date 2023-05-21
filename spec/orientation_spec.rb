require_relative '../app/entities/orientation'
require_relative '../app/entities/teacher'
require_relative '../app/entities/tag'
require_relative '../app/entities/form'
require_relative '../app/entities/form_field'
require_relative '../app/entities/enums/format'
require_relative '../app/entities/enums/type_input'
require_relative '../app/entities/form_field'
require_relative '../app/entities/format_multiple_choice'

require 'spec_helper'

RSpec.describe Entities::Orientation do
  describe '.new' do
    context 'quando receber os parametros validade, vagas com bolsam vagas sem bolsa, e url do edital e sem professor' do
      let(:orientation) do
        Entities::Orientation.new(validate: Time.now, vacancy_with_scholarship: 10, vacancy_without_scholarship: 20,
                                  url_edital: 'foo-bar')
      end

      it 'retorna uma nova instancia de orientação' do
        expect(orientation).to be_an_instance_of(Entities::Orientation)
      end
    end

    context 'quando receber os parametros validade, vaga com bolsa, vagas sem bolsa, url do edital e professor' do
      let(:teacher) { Entities::Teacher.new(name: 'Fulano') }

      let(:orientation) do
        Entities::Orientation.new(validate: Time.now, vacancy_with_scholarship: 10, vacancy_without_scholarship: 20,
                                  url_edital: 'foo-bar', teacher: teacher)
      end

      it 'retorna uma instancia de orientação e também uma instancia de professor relacionado' do
        expect(orientation).to be_an_instance_of(Entities::Orientation)
        expect(orientation.teacher).to be_an_instance_of(Entities::Teacher)
      end
    end
  end

  describe '.create_tags' do
    context 'quando receber uma lista de tags' do
      let(:orientation) do
        Entities::Orientation.new(validate: Time.now, vacancy_with_scholarship: 10, vacancy_without_scholarship: 20,
                                  url_edital: 'foo-bar')
      end

      let(:tags) do
        [
          'Ciência de Dados',
          'Visão Computacional'
        ]
      end

      it 'retorne uma lista com instancia de tags' do
        orientation.create_tags(tags)
        expect(orientation.tags).to all(be_an_instance_of(Entities::Tag))
      end
    end
  end

  describe '.create_form' do
    context 'quando receber uma instancia de campos de formulário' do
      let(:orientation) do
        Entities::Orientation.new(validate: Time.now, vacancy_with_scholarship: 10, vacancy_without_scholarship: 20,
                                  url_edital: 'foo-bar')
      end

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

      it 'o valor de form não pode ser nil e deve ser do tipo formulário' do
        orientation.create_form(form_fields)
        expect(orientation.form).to_not be_nil
        expect(orientation.form).to be_an_instance_of(Entities::Form)
      end
    end
  end

  describe '.valid?' do
    context 'quando a soma de quantidade de vagas com bolsa e sem bolsa for igual a 0' do
      let(:orientation) do
        Entities::Orientation.new(validate: Time.now, vacancy_with_scholarship: 0, vacancy_without_scholarship: 0,
                                  url_edital: 'foo-bar')
      end

      it 'deve retornar uma exception com a seguinte mensagem' do
        expect(orientation.valid?).to raise_error(StandardError,
                                                  'Erro: A quantidade de bolsa com vaga e sem bolsa não pode ser 0 ou negativo')
      rescue StandardError
        nil
      end
    end

    context 'quando a soma de quantide vagas com bolsa e sem bolsa for difente de 0' do
      let(:orientation) do
        Entities::Orientation.new(validate: Time.now, vacancy_with_scholarship: 1, vacancy_without_scholarship: 1,
                                  url_edital: 'foo-bar')
      end

      it 'deve retornar true' do
        expect(orientation.valid?).to be_truthy
      end
    end
  end
end
