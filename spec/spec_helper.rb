# spec_helper.rb

# Configure o ambiente de teste

# Carregue as bibliotecas e dependências necessárias para os testes
require 'rspec'

require 'simplecov'
SimpleCov.start

# Carregue os arquivos de teste
Dir['./spec/**/*.rb'].sort.each { |f| require f }

# Configurações do RSpec
RSpec.configure do |config|
  config.color = true
  config.formatter = :documentation
end
