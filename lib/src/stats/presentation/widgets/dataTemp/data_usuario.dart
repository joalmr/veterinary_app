class DataUsuario {
  String? name;
  int? value;

  DataUsuario({
    this.name,
    this.value,
  });
}

List<DataUsuario> dataUsuario = [
  DataUsuario(name: 'Enero', value: 30),
  DataUsuario(name: 'Febrero', value: 40),
  DataUsuario(name: 'Marzo', value: 8),
];
