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
require 'rspec'

RSpec.describe Entities::Teacher do
  describe '.new' do
    context 'quando receber parametro nome' do
      subject { described_class.new(name: 'Vinicius') }

      it 'crie uma nova instancia de professor' do
        expect(subject).to be_a_instance_of(Entities::Teacher)
      end
    end
  end

  describe '.create_orientation' do
    context 'quando receber os parametros: quantide de vagas com bolsa, sem bolsa, prazo de validade e url do edital, tags, porém sem formulário' do
      let(:teacher) { Entities::Teacher.new(name: 'Vinicius') }

      let(:tags) do
        [
          Entities::Tag.new(description: 'Ciência de Dados'),
          Entities::Tag.new(description: 'Visão Computacional')
        ]
      end

      let(:params) do
        {
          validate: Time.now,
          vacancy_with_scholarship: 10,
          vacancy_without_scholarship: 20,
          url_edital: 'foo-bar',
          tags: tags
        }
      end

      it 'deve criar uma orientação e retornar uma lista de instancias de orientacção' do
        teacher.create_orientation(params: params)
        expect(teacher.orientations).to all(be_an_instance_of(Entities::Orientation))
      end
    end

    context 'quando receber receber os parametros: quantide de vagas com bolsa, sem bolsa, prazo de validade e url do edital, tags, porém com formulário' do
      let(:teacher) { Entities::Teacher.new(name: 'Vinicius') }

      let(:tags) do
        [
          'Ciência de Dados',
          'Visão Computacional'
        ]
      end

      let(:form_fields) do
        [
          {
            type_input: Entities::Enums::TypeInput::TYPE[:MULTIPLE_CHOICE],
            name: 'xxx',
            format_multiple_choice: Entities::Enums::Format::TYPE[:UMA_OPCAO]
          },
          {
            type_input: Entities::Enums::TypeInput::TYPE[:MULTIPLE_CHOICE],
            name: 'xxx',
            format_multiple_choice: Entities::Enums::Format::TYPE[:UMA_OPCAO]
          }
        ]
      end

      let(:params) do
        {
          validate: Time.now,
          vacancy_with_scholarship: 10,
          vacancy_without_scholarship: 20,
          url_edital: 'foo-bar',
          tags: tags,
          form_fields: form_fields
        }
      end

      it 'deve criar uma orientação e retornar uma lista de instancias de orientacção e orientacao deve conter uma instancia de formulário' do
        teacher.create_orientation(params: params)
        teacher.orientations.each do |orientation|
          expect(orientation.form).to be_an_instance_of(Entities::Form)
        end
      end
    end

    context 'quando receber receber os parametros: quantide de vagas com bolsa, sem bolsa, prazo de validade e url do edital, tags, porém a quantide de vagas com bolsa e sem bolsa é igual zero ou negativo' do
      let(:teacher) { Entities::Teacher.new(name: 'Vinicius') }

      let(:tags) do
        [
          'Ciência de Dados',
          'Visão Computacional'
        ]
      end

      let(:params) do
        {
          validate: Time.now,
          vacancy_with_scholarship: 0,
          vacancy_without_scholarship: 0,
          url_edital: 'foo-bar',
          tags: tags
        }
      end

      it 'deve retornar um erro com a messagem Erro: A quantidade de bolsa com vaga e sem bolsa não pode ser 0 ou negativo e não pode ter instancia de orientacao relacionada' do
        begin
          expect(teacher.create_orientation(params: params)).to raise_error(StandardError,
                                                                            'Erro: A quantidade de bolsa com vaga e sem bolsa não pode ser 0 ou negativo')
        rescue StandardError
          nil
        end
        expect(teacher.orientations).to be_empty
      end
    end
  end
end
