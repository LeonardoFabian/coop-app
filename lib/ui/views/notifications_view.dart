import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:coopmt_app/ui/views/statics_view.dart';

class NotificationsView extends StatefulWidget {
  static String id = 'notifications_view';
  const NotificationsView({Key? key}) : super(key: key);

  @override
  State<NotificationsView> createState() => _NotificationsView();
}

class _NotificationsView extends State<NotificationsView> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    String? title = ModalRoute.of(context)!.settings.arguments as String?;

    if (title == null) {
      title = 'Notificaciones';
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
          textDirection: TextDirection.ltr,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
        ),
        foregroundColor: const Color.fromRGBO(48, 138, 64, 1),
        backgroundColor: Colors.white,
        actions: <Widget>[
          // Notifications
          IconButton(
              icon: const Icon(FontAwesomeIcons.solidBell),
              tooltip: 'Ver notificaciones',
              onPressed: () {
                Navigator.pushNamed(context, NotificationsView.id,
                    arguments: 'Notificaciones');
              }),

          // Statics
          IconButton(
            icon: const Icon(FontAwesomeIcons.chartSimple),
            tooltip: 'Estadisticas',
            onPressed: () {
              Navigator.pushNamed(context, StaticsView.id,
                  arguments: 'Estadisticas');
            },
          ),

          // Menu
          IconButton(
              icon: const Icon(FontAwesomeIcons.bars),
              tooltip: 'Abrir menu',
              onPressed: () => print('Abriste el menu'))
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ListView.builder(
                  shrinkWrap:
                      true, // Permite que ListView.builder se ajuste a su contenido
                  physics:
                      NeverScrollableScrollPhysics(), // Desactiva el scroll interno del ListView
                  itemCount: 10,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  itemBuilder: (context, int index) {
                    return Card(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Container(
                        padding: EdgeInsets.all(15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Date
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  '20 Septiembre 2024',
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.green,
                                      fontWeight: FontWeight.w400),
                                  textAlign: TextAlign.right,
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),

                            // Message
                            ListTile(
                              leading: Icon(FontAwesomeIcons.solidCircle,
                                  color: Color.fromRGBO(48, 138, 64, 1)),
                              title: Text(
                                'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras sed laoreet enim. Fusce sit amet accumsan est. Cras ac quam odio.',
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black),
                                textAlign: TextAlign.left,
                              ),
                            ),
                            const SizedBox(height: 10),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
