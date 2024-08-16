import 'package:flutter/material.dart';

import 'package:coopmt_app/helpers/dialogs.dart';

void main() => runApp(CoopApp());

class CoopApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            backgroundColor: const Color.fromRGBO(48, 138, 64, 1),
            foregroundColor: Colors.white,
            title: const Text(
              'COOPMT',
              textDirection: TextDirection.ltr,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32.0),
            ),
            actions: <Widget>[
              IconButton(
                  icon: const Icon(Icons.add_alert),
                  tooltip: 'Ver notificaciones',
                  color: Colors.white,
                  onPressed: () => print('Abriste tus notificaciones')),
              IconButton(
                  icon: const Icon(Icons.menu),
                  tooltip: 'Abrir menu',
                  color: Colors.white,
                  onPressed: () => print('Abriste el menu'))
            ],
          ),
          body: Builder(
              builder: (BuildContext context) => SingleChildScrollView(
                    child: Container(
                      // width: double.infinity,
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 20.0),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          // color: Color.fromRGBO(48, 138, 64, 1),
                          border: Border.all(color: Colors.grey, width: 1.0),
                          borderRadius: BorderRadius.circular(10.0),
                          boxShadow: const [
                            BoxShadow(
                                blurRadius: 10.0,
                                color: const Color.fromRGBO(0, 0, 0, 0.5),
                                offset: Offset(1.0, 1.0))
                          ]),
                      child: Column(
                        children: <Widget>[
                          const Text(
                            'Estos son tus productos',
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              color: Color.fromRGBO(0, 0, 0,
                                  1), // Color.fromRGBO(r, g, b, opacity)
                            ),
                          ),
                          const Text(
                            'Qué deseas hacer?',
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              color: Color.fromRGBO(0, 0, 0,
                                  1), // Color.fromRGBO(r, g, b, opacity)
                            ),
                          ),
                          const Text(
                            'Novedades',
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              color: Color.fromRGBO(0, 0, 0,
                                  1), // Color.fromRGBO(r, g, b, opacity)
                            ),
                          ),
                          Image.asset('assets/images/event_img.jpg',
                              height: 200.0),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: ElevatedButton(
                              child: const Text('Iniciar sesión'),
                              onPressed: () => showAlert(context),
                            ),
                          )
                        ],
                      ),
                    ),
                  ))),
    );
  }

  showAlert(BuildContext context) {
    infoDialog(
        context: context,
        title: 'Lorem Ipsum',
        content:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Mauris at ligula sed erat consequat condimentum. Etiam tellus lorem, pellentesque nec eleifend sit amet, facilisis hendrerit neque.');
  }
}
