import 'dart:convert';

import '../model/animal.dart';
import 'package:http/http.dart' as http;

class animalServicio {
  Map<String, String> headers = {'Content-Type': 'application/json'};

  Future<List<Animal>> fetchData() async {
    var apiUrl = 'http://localhost:8080/api/v1/animal';
    List<Animal> animals = new List.empty();
    try {
      http.Response response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        // La solicitud fue exitosa, puedes acceder a los datos en response.body
        animals = (jsonDecode(response.body) as List)
            .map((item) => Animal.fromJson(item))
            .toList();
        return animals;
      } else {
        return animals;
        // La solicitud no fue exitosa, maneja el error según sea necesario
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      return animals;
      // Ocurrió un error durante la solicitud
      print('Error: $e');
    }
  }

  Future<Animal> saveAnimal(Animal animal) async {
    var apiUrl = 'http://localhost:8080/api/v1/animal';

    try {
      Map<String, dynamic> requestBody = {
        'id': 0,
        'commonName': animal.getCommonName.toString(),
        'scientificName': animal.getScientificName.toString(),
        'specie': animal.getScientificName.toString(),
        'family': animal.getScientificName.toString(),
      };

      http.Response response = await http.post(Uri.parse(apiUrl),
          headers: this.headers, body: jsonEncode(requestBody));

      if (response.statusCode == 201) {
        // La solicitud fue exitosa, puedes acceder a los datos en response.body
        print('el objeto se ha creado con éxito!');
        return Animal.fromJson(jsonDecode(response.body));
      } else {
        print(
            'el objeto no se ha creado con éxito: ${response.statusCode} + ${response.body}');
        return Animal.empty();
        // La solicitud no fue exitosa, maneja el error según sea necesario
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
      return Animal.empty();
      // Ocurrió un error durante la solicitud
      print('Error: $e');
    }
  }

  Future<String> deleteAnimal(int id) async {
    var apiUrl = 'http://localhost:8080/api/v1/animal/$id';

    try {
      http.Response response = await http.delete(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        // Animal eliminado exitosamente
        return ('Animal eliminado con éxito!');
      } else if (response.statusCode == 404) {
        // Animal no encontrado
        return ('Animal no encontrado');
      } else {
        // Error con el servicio
        return ('Error con el servicio');
      }
    } catch (e) {
      // Ocurrió un error durante la solicitud
      return ('Error: $e');
    }
  }

  Future<Animal> updateAnimal(Animal animal) async {
    var apiUrl = 'http://localhost:8080/api/v1/animal';

    try {
      Map<String, dynamic> requestBody = {
        'id': animal.getId,
        'commonName': animal.getCommonName.toString(),
        'scientificName': animal.getScientificName.toString(),
        'specie': animal.getScientificName.toString(),
        'family': animal.getScientificName.toString(),
      };

      print(requestBody);

      http.Response response = await http.put(Uri.parse(apiUrl),
          headers: this.headers, body: jsonEncode(requestBody));

      if (response.statusCode == 200) {
        // La solicitud fue exitosa, puedes acceder a los datos en response.body
        print('el objeto se ha actualizado con éxito!');
        return Animal.fromJson(jsonDecode(response.body));
      } else {
        print(
            'el objeto no se ha actualizado con éxito: ${response.statusCode} + ${response.body}');
        return Animal.empty();
        // La solicitud no fue exitosa, maneja el error según sea necesario
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
      return Animal.empty();
      // Ocurrió un error durante la solicitud
      print('Error: $e');
    }
  }
}
