import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:coopmt_app/ui/labels/custom_labels.dart';

class StaticPageView extends StatelessWidget {
  final String title;
  StaticPageView({required this.title});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          title == null ? 'Página de prueba' : title,
          textDirection: TextDirection.ltr,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
        ),
        foregroundColor: const Color.fromRGBO(48, 138, 64, 1),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              _title(),
              const SizedBox(
                height: 20,
              ),
              Text(
                  'Loren ipsum dolor sit amet consectetur adipiscing elit. Pellentesque odio ut, tincidunt id, accumsan sit amet, nunc. Nunc, dui. Vivamus, tellus, vel, scelerisque. Nunc, ut, sed. Duis, pellentesque. Duis, pellentesque. Loren ipsum dolor sit amet consectetur adipiscing elit. Pellentesque odio ut, tincidunt id, accumsan sit amet, nunc. Nunc, dui. Vivamus, tellus, vel, scelerisque. Nunc, ut, sed. Duis, pellentesque. Duis, pellentesque.',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey),
                  maxLines: 500,
                  textAlign: TextAlign.left),
            ],
          ),
        ),
      ),
    );
  }

  Text _title() =>
      Text(title, style: CustomLabels.h1, textAlign: TextAlign.left);
}
