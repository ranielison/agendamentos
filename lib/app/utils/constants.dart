import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Constants {
  static const Color grey = Color(0xFF808080);
  static const Color green = Color(0xFF0C9C23);
  static const Color pink = Color(0xFFEA028E);
  static const Color primary = Color(0xFF902195);

  static final dformat = DateFormat('dd/MM/yyyy');
  static final dhformat = DateFormat('dd/MM/yyyy - HH:mm');
  static final hformat = DateFormat.Hm();

  static const hiveAgendamentoAdapter = 0;
  static const hiveClienteAdapter = 1;
  static const hiveExpedienteAdapter = 2;
  static const hiveExpedienteSettingsAdapter = 3;
  static const hiveHoraioAdapter = 4;
  static const hiveServicoAdapter = 5;
}
