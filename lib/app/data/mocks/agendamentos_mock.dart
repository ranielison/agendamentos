import 'package:agendamentos/app/data/models/agendamento.dart';
import 'package:agendamentos/app/data/models/cliente.dart';
import 'package:agendamentos/app/data/models/expediente.dart';
import 'package:agendamentos/app/data/models/expediente_settings.dart';
import 'package:agendamentos/app/data/models/servico.dart';

List<Agendamento> agendamentosMock = [
  Agendamento(
    cliente: Cliente(
      nome: 'Raniélison Soares',
      telefone: '(84) 998306460',
      dataNascimento: '20/12/1997',
    ),
    concluido: false,
    duration: Duration(hours: 4),
    startDate: DateTime(2020, 11, 28, 8, 0),
    isRetorno: false,
    servicos: [
      Servico(
        description: 'Limpeza de pele',
        value: 23.00,
      ),
      Servico(
        description: 'Pigmentação',
        value: 43.00,
      ),
    ],
  ),
  Agendamento(
    cliente: Cliente(
      nome: 'Ronin Oliveira',
      telefone: '(84) 998346460',
      dataNascimento: '20/11/1997',
    ),
    concluido: false,
    duration: Duration(hours: 2),
    startDate: DateTime(2020, 11, 21, 8),
    isRetorno: false,
    servicos: [
      Servico(
        description: 'Pigmentação',
        value: 43.00,
      ),
    ],
  ),
];

ExpedienteSettings allExpedientes = ExpedienteSettings(
  intervalo: Duration(minutes: 30),
  expedientes: [
    ExpedienteDay(
      inicio: [8, 0],
      pausa: [12, 0],
      retorno: [14, 0],
      fim: [18, 0],
    ),
    ExpedienteDay(
      inicio: [8, 0],
      pausa: [12, 0],
      retorno: [14, 0],
      fim: [18, 0],
    ),
    ExpedienteDay(
      inicio: [8, 0],
      pausa: [12, 0],
      retorno: [14, 0],
      fim: [18, 0],
    ),
    ExpedienteDay(
      inicio: [8, 0],
      pausa: [12, 0],
      retorno: [14, 0],
      fim: [18, 0],
    ),
    ExpedienteDay(
      inicio: [8, 0],
      pausa: [12, 0],
      retorno: [14, 0],
      fim: [18, 0],
    ),
    ExpedienteDay(
      inicio: [8, 0],
      fim: [12, 0],
    ),
    ExpedienteDay(
      aberto: false,
    ),
  ],
);

List<Servico> servicosMock = [
  Servico(
    id: 1,
    description: 'Serviço 1',
    value: 11,
  ),
  Servico(
    id: 2,
    description: 'Serviço 2',
    value: 12,
  ),
];
