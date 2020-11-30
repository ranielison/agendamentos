class ExpedienteDay {
  final List<int> inicio;
  final List<int> pausa;
  final List<int> retorno;
  final List<int> fim;
  final bool aberto;

  ExpedienteDay({
    this.inicio,
    this.pausa,
    this.retorno,
    this.fim,
    this.aberto = true,
  });
}
