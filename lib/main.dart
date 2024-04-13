import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:todolist/view/form_task.dart';

import 'firebase_options.dart'; // Importación de las opciones de Firebase. Esto puede contener la configuración de Firebase para la plataforma específica.

void main() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: Colors
                .deepPurple), // Configura el esquema de colores de la aplicación.
        useMaterial3:
            true, // Habilita el uso de Material 3, una nueva versión de los diseños de Material.
      ),
      home: const MyHomePage(
          title:
              'Flutter Demo Home Page'), // Establece MyHomePage como la página de inicio.
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context)
            .colorScheme
            .inversePrimary, // Configura el color de fondo de la barra de aplicaciones.
        title: Text(widget
            .title), // Muestra el título de la página en la barra de aplicaciones.
      ),
      body: StreamBuilder(
          // Utiliza un StreamBuilder para mostrar los datos de Firestore en tiempo real.
          stream: FirebaseFirestore.instance
              .collection("todolist")
              .snapshots(), // Escucha los cambios en la colección 'todolist'.
          builder: (context, snapshot) {
            if (!snapshot.hasData)
              return const Text(
                  'Cargando Datos.....'); // Muestra un mensaje de carga si no hay datos disponibles.
            return ListView.builder(
                itemCount: snapshot.data?.docs
                    .length, // Obtiene la cantidad de documentos en la colección.
                itemBuilder: (context, index) => ListTile(
                      // Crea un ListTile para cada elemento en la lista.
                      leading: const Icon(
                          Icons.task_alt), // Muestra un ícono para cada tarea.
                      title: Text(
                          'Numero de Tareas ${snapshot.data!.docs[index]['number']}'), // Muestra el número de tareas.
                      subtitle: Text(snapshot.data!.docs[index][
                          'name']), // Muestra el nombre de la tarea como subtítulo.
                    ));
          }),
      floatingActionButton: FloatingActionButton(
        // Botón flotante para agregar nuevas tareas.
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddNewTaskScreen()),
          ); //redirecciona a otra ventana
        },
        tooltip: 'Agregar Nueva Tarea', // Tooltip del botón flotante.
        child: const Icon(Icons.add), // Icono del botón flotante.
      ),
    );
  }
}
