import 'package:flutter/material.dart';
import 'package:flutter_zoo_2/main.dart';
import 'package:flutter_zoo_2/pages/done.dart';

import '../model/animal.dart';
import '../service/animal_service.dart';

class NewPage extends StatefulWidget {
  final Animal? animal;
  final animalServicio servicio;

  const NewPage({super.key, required this.servicio, this.animal});

  @override
  State<StatefulWidget> createState() => _NewPageState();
}

class _NewPageState extends State<NewPage> {
  final _formKey = GlobalKey<FormState>();
  Animal _animal = Animal.empty();

  void submit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      if (widget.animal == null) {
        recuperarObjeto();
      } else {
        _animal.setId = widget.animal!.getId;
        actualizarObjeto();
      }
    }
  }

  Future<void> actualizarObjeto() async {
    Animal animalResponse = await widget.servicio.updateAnimal(_animal);

    if (animalResponse.getCommonName != 0) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => DonePage(
                  message:
                      '¡Animal ${animalResponse.getCommonName} actualizado!')));
    }
  }

  Future<void> recuperarObjeto() async {
    Animal animalResponse = await widget.servicio.saveAnimal(_animal);

    if (animalResponse.getCommonName != 0) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => DonePage(
                  message: '¡Animal ${animalResponse.getCommonName} creado!')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Nombre común'),
                onSaved: (value) => _animal.setCommonName = value,
                initialValue:
                    widget.animal != null ? widget.animal!.getCommonName : '',
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Por favor, ingresa un nombre común';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Nombre científico'),
                onSaved: (value) => _animal.setScientificName = value,
                initialValue: widget.animal != null
                    ? widget.animal!.getScientificName
                    : '',
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Por favor, ingresa un nombre científico';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Especie'),
                onSaved: (value) => _animal.setSpecie = value,
                initialValue:
                    widget.animal != null ? widget.animal!.getSpecie : '',
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Por favor, ingresa una Especie';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Familia'),
                onSaved: (value) => _animal.setSpecie = value,
                initialValue:
                    widget.animal != null ? widget.animal!.getFamily : '',
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Por favor, ingresa una Familia';
                  }
                  return null;
                },
              ),
              ElevatedButton(
                onPressed: submit,
                child: Text(widget.animal != null ? 'Actualizar' : 'Guardar'),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushReplacementNamed(context, '/');
        },
        tooltip: 'Increment',
        child: const Icon(Icons.keyboard_return),
      ),
    );
  }
}
