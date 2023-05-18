class Animal {
  int? _id;
  String? _commonName;
  String? _scientificName;
  String? _specie;
  String? _family;

  Animal({
    required int id,
    required String commonName,
    required String scientificName,
    required String specie,
    required String family,
  })  : _id = id,
        _commonName = commonName,
        _scientificName = scientificName,
        _specie = specie,
        _family = family;

  Animal.empty()
      : _id = 0,
        _commonName = '',
        _scientificName = '',
        _specie = '',
        _family = '';

  factory Animal.fromJson(Map<String, dynamic> json) {
    return Animal(
      id: json['id'],
      commonName: json['commonName'],
      scientificName: json['scientificName'],
      specie: json['specie'],
      family: json['family'],
    );
  }

  int? get getId => _id;
  set setId(int? value) => _id = value;

  String? get getCommonName => _commonName;
  set setCommonName(String? value) => _commonName = value;

  String? get getScientificName => _scientificName;
  set setScientificName(String? value) => _scientificName = value;

  String? get getSpecie => _specie;
  set setSpecie(String? value) => _specie = value;

  String? get getFamily => _family;
  set setFamily(String? value) => _family = value;
}
