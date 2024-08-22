// import 'package:coopmt_app/helpers/dialogs.dart';
// import 'package:flutter/material.dart';

// class AuthPage extends StatelessWidget {
//   static const String ROUTE = '/auth';

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           'COOPMT',
//           textDirection: TextDirection.ltr,
//           style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32.0),
//         ),
//         backgroundColor: const Color.fromRGBO(48, 138, 64, 1),
//         foregroundColor: Colors.white,
//         actions: <Widget>[
//           IconButton(
//               icon: const Icon(Icons.add_alert),
//               tooltip: 'Ver notificaciones',
//               color: Colors.white,
//               onPressed: () => print('Abriste tus notificaciones')),
//           IconButton(
//               icon: const Icon(Icons.menu),
//               tooltip: 'Abrir menu',
//               color: Colors.white,
//               onPressed: () => print('Abriste el menu'))
//         ],
//       ),
//       body: Builder(
//         builder: (BuildContext context) => SingleChildScrollView(
//           child: Container(
//             padding: EdgeInsets.all(20.0),
//             child: Card(
//               color: Colors.white,
//               elevation: 0,
//               child: Column(
//                 children: <Widget>[
//                   TextField(
//                     decoration: InputDecoration(
//                         prefix: Icon(Icons.email),
//                         contentPadding: EdgeInsets.all(10.0),
//                         hintText: 'Correo electrónico',
//                         enabledBorder: OutlineInputBorder(
//                             borderSide: BorderSide(
//                                 color: Theme.of(context).primaryColor)),
//                         focusedBorder: OutlineInputBorder(
//                             borderSide: BorderSide(
//                                 color: Colors.green)),
//                   ),
//                   ElevatedButton(
//                       onPressed: () {},
//                       child: Text("Iniciar sesión"))
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   login(BuildContext context) {
//     infoDialog(
//         context: context, title: "Iniciar sesión", content: "Iniciar sesion");
//   }
// }
