import 'dart:ui';

const String apiUrl = String.fromEnvironment('API_URL');
const String baseUrl = String.fromEnvironment('BASE_URL');

const List<Map<String, String>> estadosBrasileiros = [
  {'sigla': 'AC', 'nome': 'Acre'},
  {'sigla': 'AL', 'nome': 'Alagoas'},
  {'sigla': 'AP', 'nome': 'Amapá'},
  {'sigla': 'AM', 'nome': 'Amazonas'},
  {'sigla': 'BA', 'nome': 'Bahia'},
  {'sigla': 'CE', 'nome': 'Ceará'},
  {'sigla': 'DF', 'nome': 'Distrito Federal'},
  {'sigla': 'ES', 'nome': 'Espírito Santo'},
  {'sigla': 'GO', 'nome': 'Goiás'},
  {'sigla': 'MA', 'nome': 'Maranhão'},
  {'sigla': 'MT', 'nome': 'Mato Grosso'},
  {'sigla': 'MS', 'nome': 'Mato Grosso do Sul'},
  {'sigla': 'MG', 'nome': 'Minas Gerais'},
  {'sigla': 'PA', 'nome': 'Pará'},
  {'sigla': 'PB', 'nome': 'Paraíba'},
  {'sigla': 'PR', 'nome': 'Paraná'},
  {'sigla': 'PE', 'nome': 'Pernambuco'},
  {'sigla': 'PI', 'nome': 'Piauí'},
  {'sigla': 'RJ', 'nome': 'Rio de Janeiro'},
  {'sigla': 'RN', 'nome': 'Rio Grande do Norte'},
  {'sigla': 'RS', 'nome': 'Rio Grande do Sul'},
  {'sigla': 'RO', 'nome': 'Rondônia'},
  {'sigla': 'RR', 'nome': 'Roraima'},
  {'sigla': 'SC', 'nome': 'Santa Catarina'},
  {'sigla': 'SP', 'nome': 'São Paulo'},
  {'sigla': 'SE', 'nome': 'Sergipe'},
  {'sigla': 'TO', 'nome': 'Tocantins'},
];

const Map<String, Locale> supportedLocales = {
  'Português (Brasil)': Locale('pt', 'BR'),
  'English': Locale('en', 'US'),
};

enum Breakpoints {
  small(480),
  mobile(720);

  final double value;

  const Breakpoints(this.value);
}
