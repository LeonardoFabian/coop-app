import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:coopmt_app/ui/labels/custom_labels.dart';
import 'package:coopmt_app/ui/style_inputs/style_input_decoration.dart';

import 'package:coopmt_app/ui/views/login_view.dart';

class ForgotPasswordView extends StatefulWidget {
  static String id = 'forgot_password_view';
  const ForgotPasswordView({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordView();
}

class _ForgotPasswordView extends State<ForgotPasswordView> {
  final _formKey = GlobalKey<FormState>();
  final _documentIdController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final String logo = 'assets/images/logo.svg';
    final Widget logoSvg = SvgPicture.asset(
      logo,
      width: 200.0,
      semanticsLabel: 'Logo',
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Recuperar contraseña',
          textDirection: TextDirection.ltr,
        ),
        foregroundColor: const Color.fromRGBO(48, 138, 64, 1),
        backgroundColor: Colors.white,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  logoSvg,

                  const SizedBox(
                    height: 50,
                  ),

                  _title(context),
                  const SizedBox(
                    height: 20,
                  ),

                  Text(
                    'Por favor, introduce tu número de documento para recuperar tu contraseña. Te enviaremos un correo con las instrucciones para restablecerla.',
                    style: Theme.of(context).textTheme.bodyLarge,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 25,
                  ),

                  ///Email
                  _documentIdTextField(context),
                  const SizedBox(
                    height: 20,
                  ),

                  ///Button
                  SizedBox(
                    width: double.infinity,
                    child: _actions(context),
                  ),

                  const SizedBox(
                    height: 50.0,
                  ),

                  TextButton(
                      child: Text(
                        'Volver atrás',
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(color: Theme.of(context).primaryColor),
                      ),
                      onPressed: () {
                        if (Navigator.canPop(context)) Navigator.pop(context);
                      }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Text _title(BuildContext context) {
    return Text('¿Olvidaste tu contraseña?',
        style: Theme.of(context)
            .textTheme
            .headlineLarge!
            .copyWith(color: Theme.of(context).primaryColor),
        textAlign: TextAlign.center);
  }

  ElevatedButton _actions(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Color.fromRGBO(48, 138, 64, 1),
        foregroundColor: Colors.white,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        elevation: 5,
        padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
      ),
      child: const Text(
        "Enviar",
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w700,
        ),
      ),
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          print('Correo enviado');
          // Navigator.pushNamed(context, LoginView.id);
        } else {
          print('Correo no enviado');
        }
      },
    );
  }

  TextFormField _documentIdTextField(BuildContext context) {
    return TextFormField(
      controller: _documentIdController,
      validator: (value) => value!.length != 11
          ? 'El número de cédula debe tener 11 digitos'
          : null,
      style: TextStyle(color: Theme.of(context).primaryColor),
      decoration: inputDecorationBorderGreen(
          icon: Icon(
            FontAwesomeIcons.idCard,
            color: Theme.of(context).primaryColor,
          ),
          hintText: 'Número de cédula'),
    );
  }
}
