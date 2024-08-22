import 'package:flutter/material.dart';
import 'package:coopmt_app/ui/views/static_page_view.dart';

class TermsAndConditions extends StatefulWidget {
  static String id = 'terms_and_conditions_view';
  const TermsAndConditions({Key? key}) : super(key: key);

  @override
  State<TermsAndConditions> createState() => _TermsAndConditions();
}

class _TermsAndConditions extends State<TermsAndConditions> {
  @override
  Widget build(BuildContext context) {
    String title = ModalRoute.of(context)!.settings.arguments as String;

    if (title == null) {
      title = 'Página de prueba';
    }

    return StaticPageView(title: title);
  }
}
