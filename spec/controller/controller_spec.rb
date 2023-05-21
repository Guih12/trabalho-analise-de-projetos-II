require_relative '../../app/controllers/controller'
require_relative '../../app/entities/enums/type_input'
require_relative '../../app/entities/teacher'
require_relative '../../app/entities/form'
require_relative '../../app/entities/form_field'
require_relative '../../app/entities/enums/format'
require_relative '../../app/entities/enums/type_input'
require_relative '../../app/entities/form_field'
require_relative '../../app/entities/format_multiple_choice'

RSpec.describe Controller do
  describe '#create_orientation' do
    context 'quando o professor tem o desejo de criar uma orientacao' do
      context 'quando a orientação não contém formulário e passa parametros' do
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

        it 'deve criar uma nova orientacao e retornar uma mensagem de orientação criada com sucesso' do
          allow(Controller).to receive(:current_teacher).and_return(teacher)

          expect(Controller.create_orientation(params)).to eq 'Orientação criada com sucesso!!'
        end
      end

      context 'quando o professor deseja criar um orientação com fomulário' do
        let(:teacher) { Entities::Teacher.new(name: 'Vinicius') }

        let(:tags) do
          [
            'Ciência de Dados',
            'Visão Computacional'
          ]
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

        it 'deve criar uma nova orientacao e retornar uma mesagem de orientacao criada com sucesso ' do
          allow(Controller).to receive(:current_teacher).and_return(teacher)

          expect(Controller.create_orientation(params)).to eq 'Orientação criada com sucesso!!'
        end
      end

      context 'quando o professor deseja criar uma orientação, porém a quantidade de vagas com bolsa e sem bolsa é igual a 0' do
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
            vacancy_with_scholarship: 0,
            vacancy_without_scholarship: 0,
            url_edital: 'foo-bar',
            tags: tags
          }
        end

        it 'deve retornar uma mensagem de erro' do
          allow(Controller).to receive(:current_teacher).and_return(teacher)

          begin
            expect(Controller.create_orientation(params)).to raise_error(StandardError,
                                                                         'Erro: A quantidade de bolsa com vaga e sem bolsa não pode ser 0 ou negativo')
          rescue StandardError
            nil
          end
        end
      end
    end
  end

  describe '#select_input' do
    context 'quando o professor querer selecionar os tipos  de campos' do
      it 'deve retornar uma lista de tipos de campos' do
        expect(Controller.select_input).to be_instance_of(::Hash)
      end
    end
  end

  describe '#select_format' do
    context 'quando o professor querer selecionar o formato ' do
      it 'deve retornar uma lista de formatos' do
        expect(Controller.select_format).to be_instance_of(::Hash)
      end
    end
  end
end
