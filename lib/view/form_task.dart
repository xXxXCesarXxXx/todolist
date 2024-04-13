import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// Definición de la pantalla para añadir una nueva tarea como StatefulWidget
class AddNewTaskScreen extends StatefulWidget {
  const AddNewTaskScreen({super.key});

  @override
  State<AddNewTaskScreen> createState() => _AddNewTaskScreen();
}

// Estado de la pantalla para añadir una nueva tarea
class _AddNewTaskScreen extends State<AddNewTaskScreen> {
  // Controladores para los campos de texto
  final nameController = TextEditingController();
  final numberController = TextEditingController();

  // Método para liberar los recursos de los controladores cuando la pantalla es eliminada
  @override
  void dispose() {
    nameController.dispose();
    numberController.dispose();
    print('dispose');
    super.dispose();
  }

  // Método para construir la interfaz de usuario de la pantalla
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            const Text('Add New Task'), // Título de la barra de la aplicación
        backgroundColor: Theme.of(context)
            .colorScheme
            .primary, // Color de fondo de la barra de la aplicación
      ),
      body: Center(
        child: Column(
          children: [
            // Campo de texto para el nombre de la tarea
            Padding(
              padding: const EdgeInsets.all(16),
              child: TextField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Name',
                ),
                controller: nameController,
              ),
            ),
            // Campo de texto para el número de la tarea
            Padding(
              padding: const EdgeInsets.all(16),
              child: TextField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Number',
                ),
                controller: numberController,
              ),
            ),
            // Botón para agregar una nueva tarea
            ElevatedButton(
                onPressed: () {
                  // Crear un mapa con los datos de la tarea
                  final task = <String, dynamic>{
                    "name": nameController.text,
                    "number": int.parse(numberController.text),
                  };

                  // Acceder a Firestore y agregar la tarea a la colección 'todolist'
                  final db = FirebaseFirestore.instance;
                  db
                      .collection("todolist")
                      .add(task)
                      .then((DocumentReference doc) {
                    // Navegar de vuelta a la pantalla anterior cuando la tarea es añadida
                    Navigator.pop(context);
                    print('DocumentSnapshot added with ID: ${doc.id}');
                  });
                },
                child: const Text(
                    'Add New Task')), // Texto del botón para agregar una nueva tarea
          ],
        ),
      ),
    );
  }
}
