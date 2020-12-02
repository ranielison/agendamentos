import 'package:agendamentos/app/data/models/agendamento.dart';
import 'package:agendamentos/app/data/models/cliente.dart';
import 'package:agendamentos/app/data/models/servico.dart';

List<Agendamento> agendamentosMock = [
  Agendamento(
    cliente: Cliente(
      nome: 'Raniélison Soares',
      telefone: '(84) 998306460',
      dataNascimento: '20/12/1997',
    ),
    concluido: false,
    duration: Duration(minutes: 30),
    startDate: DateTime(2020, 11, 28),
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
    duration: Duration(hours: 4),
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
