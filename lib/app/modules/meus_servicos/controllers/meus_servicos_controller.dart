import 'package:agendamentos/app/data/models/servico.dart';
import 'package:agendamentos/app/global/helpers/local_data_helper.dart';
import 'package:agendamentos/app/modules/meus_servicos/widgets/dialog_novo_servico.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class MeusServicosController extends GetxController {
  final _localDataHelper = Get.find<LocalDataHelper>();
  final _uuid = Get.find<Uuid>();

  final formKey = GlobalKey<FormState>();

  RxList<Servico> _servicos = <Servico>[].obs;
  List<Servico> get servicos => _servicos.toList();

  String _servicoField = '';
  String get servicoField => _servicoField;

  String _durationField = '';
  String get durationField => _durationField;

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
      id: _uuid.v1(),
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

  void openDialogEdit(Servico servico) {
    _servicoField = servico.description;
    _durationField = servico.durationInMinutes.toString();
    Get.dialog(DialogNovoServico(servico: servico));
  }

  void editServico(Servico s) {
    Servico servico = Servico(
      id: s.id,
      description: _servicoField,
      durationInMinutes: int.parse(_durationField),
    );

    _localDataHelper.editServico(servico);
    int index = _servicos.indexWhere((item) => item.id == servico.id);
    if (index >= 0) {
      _servicos[index] = servico;
    }
    Get.back();
  }

  void excluirServico(String id) {
    _localDataHelper.excluirServico(id);
    int index = _servicos.indexWhere((item) => item.id == id);
    if (index >= 0) {
      _servicos.removeAt(index);
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
