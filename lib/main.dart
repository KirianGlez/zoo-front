import 'package:flutter/material.dart';
import 'package:flutter_zoo_2/pages/new.dart';
import 'package:flutter_zoo_2/service/animal_service.dart';

import 'model/animal.dart';

void main() {
  animalServicio servicio = animalServicio();
  runApp(MyApp(servicio: servicio));
}

class MyApp extends StatelessWidget {
  final animalServicio servicio;

  MyApp({super.key, required this.servicio});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page', servicio: servicio),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title, required this.servicio});

  final animalServicio servicio;
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Animal> animals = List.empty();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Animal>>(
        future: widget.servicio.fetchData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            animals = snapshot.data!;
            return DataTable(
              columns: const [
                DataColumn(label: Text('ID')),
                DataColumn(label: Text('Nombre Común')),
                DataColumn(label: Text('Nombre Científico')),
                DataColumn(label: Text('Especie')),
                DataColumn(label: Text('Familia')),
                DataColumn(label: Text('')),
                DataColumn(label: Text('')),
              ],
              rows: animals.map((animal) {
                return DataRow(cells: [
                  DataCell(Text(animal.getId.toString())),
                  DataCell(Text(animal.getCommonName.toString())),
                  DataCell(Text(animal.getScientificName.toString())),
                  DataCell(Text(animal.getSpecie.toString())),
                  DataCell(Text(animal.getFamily.toString())),
                  DataCell(
                    InkWell(
                      onTap: () {
                        // Redirigir a otra página al hacer clic en el botón
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => NewPage(
                              servicio: widget.servicio,
                              animal: animal,
                            ),
                          ),
                        );
                      },
                      child: Icon(Icons.edit),
                    ),
                  ),
                  DataCell(
                    InkWell(
                      onTap: () {
                        deleteAnimal(animal);
                      },
                      child: Icon(Icons.delete),
                    ),
                  ),
                ]);
              }).toList(),
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text('Error al obtener los datos'),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => NewPage(
                      servicio: widget.servicio,
                    )),
          );
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  deleteAnimal(Animal animal) async {
    String respuesta = await widget.servicio.deleteAnimal(animal.getId!);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Mensaje'),
          content: Text(respuesta),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Aceptar'),
            ),
          ],
        );
      },
    );

    // Actualizar la lista de animales
    setState(() {
      animals.removeWhere((item) => item.getId == animal.getId);
    });
  }
}
