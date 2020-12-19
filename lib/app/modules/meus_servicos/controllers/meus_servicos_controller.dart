import 'package:agendamentos/app/data/models/servico.dart';
import 'package:agendamentos/app/global/helpers/local_data_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MeusServicosController extends GetxController {
  final _localDataHelper = Get.find<LocalDataHelper>();

  final formKey = GlobalKey<FormState>();

  RxList<Servico> _servicos = <Servico>[].obs;
  List<Servico> get servicos => _servicos.toList();

  String _servicoField = '';
  String _durationField = '';

  @override
  void onInit() {
    super.onInit();
    _getServicos();
  }

  void _getServicos() {
    List<Servico> servicosData = _localDataHelper.getAllServicos() ?? [];
    _servicos.assignAll(servicosData);
  }

  void addServico() {
    if (!formKey.currentState.validate()) return;
    Servico servico = Servico(
      description: _servicoField,
      durationInMinutes: int.parse(_durationField),
    );

    try {
      _localDataHelper.addServico(servico);
      _servicos.add(servico);
    } catch (e) {
      print(e);
    }
    Get.back();
  }

  void setServicoField(String value) {
    _servicoField = value;
  }

  void setDurationField(String value) {
    _durationField = value;
  }

  void resetFields() {
    _servicoField = '';
    _durationField = '';
  }
}
