import 'package:flutter/material.dart';

// packages
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

// helpers
import 'package:coopmt_app/services/strapi_service.dart';
import 'package:coopmt_app/ui/labels/custom_labels.dart';
import 'package:coopmt_app/ui/style_inputs/style_input_decoration.dart';

// views
import 'package:coopmt_app/ui/views/login_view.dart';
import 'package:coopmt_app/ui/views/main_view.dart';
import 'package:coopmt_app/ui/views/terms_and_conditions_view.dart';

class RegisterView extends StatefulWidget {
  static String id = 'register_view';
  const RegisterView({Key? key}) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterView();
}

class _RegisterView extends State<RegisterView> {
  final _formKey = GlobalKey<FormState>();
  // final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _obscurePassword = true;
  bool isSubmitted = false;
  // final _documentIdController = TextEditingController();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final StrapiService strapiService = StrapiService();

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
      // key: _scaffoldKey,
      appBar: AppBar(
        title: const Text(
          'Regístrate ahora',
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
                  const SizedBox(height: 20),

                  ///Document Id
                  // _documentIdTextField(context),
                  // const SizedBox(height: 20),

                  ///Document Id
                  _usernameTextField(context),
                  const SizedBox(height: 20),

                  ///Email
                  _emailTextField(context),
                  const SizedBox(height: 20),

                  ///Username
                  // TextField(
                  //   decoration: inputDecorationBorderGreen(
                  //       icon: Icon(
                  //         Icons.person,
                  //       ),
                  //       hintText: 'Usuario'),
                  // ),
                  // const SizedBox(height: 20),

                  ///Password
                  _passwordTextField(context),
                  const SizedBox(
                    height: 20,
                  ),

                  ///Button
                  _actions(context),

                  const SizedBox(
                    height: 50,
                  ),

                  Text(
                    'Si ya tienes cuenta',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(
                    height: 10,
                  ),

                  ///Login
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        child: Text('Inicia sesión',
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(
                                    color: Theme.of(context).primaryColor)),
                        onPressed: () {
                          setState(() {
                            Navigator.pushNamed(context, LoginView.id);
                          });
                        },
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),

                  TextButton(
                    child: Text('Términos y condiciones',
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(color: Theme.of(context).primaryColor)),
                    onPressed: () {
                      Navigator.pushNamed(context, TermsAndConditions.id,
                          arguments: "Términos y condiciones");
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Text _title(BuildContext context) {
    return Text(
      'Regístrate ahora',
      style: Theme.of(context)
          .textTheme
          .headlineLarge!
          .copyWith(color: Theme.of(context).primaryColor),
      textAlign: TextAlign.center,
    );
  }

  // TextFormField _documentIdTextField(BuildContext context) {
  //   return TextFormField(
  //       controller: _documentIdController,
  //       validator: (value) => value!.length != 11
  //           ? 'El número de cédula debe tener 11 digitos'
  //           : null,
  //           style: TextStyle(color: Theme.of(context).primaryColor),
  //       decoration: inputDecorationBorderGreen(
  //           icon: Icon(
  //             FontAwesomeIcons.idCard,
  //             color: Theme.of(context).colorScheme.tertiary,
  //           ),
  //           hintText: 'Número de cédula'));
  // }

  TextFormField _usernameTextField(BuildContext context) {
    return TextFormField(
        controller: _usernameController,
        validator: (value) => value!.length != 11
            ? 'El número de cédula debe tener 11 digitos'
            : null,
        style: TextStyle(color: Theme.of(context).primaryColor),
        decoration: inputDecorationBorderGreen(
            icon: Icon(
              FontAwesomeIcons.user,
              color: Theme.of(context).primaryColor,
            ),
            hintText: 'Número de cédula'));
  }

  Widget _actions(BuildContext context) {
    return isSubmitted
        ? CircularProgressIndicator(
            color: Theme.of(context).primaryColor,
          )
        : SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                elevation: 5,
                padding: const EdgeInsets.symmetric(
                    horizontal: 40.0, vertical: 20.0),
              ),
              child: Text(
                "Crear cuenta",
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(color: Colors.white),
              ),
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  setState(() => isSubmitted = true);

                  // print('Formulario valido');
                  // se removio _documentIdController.text
                  final response = await strapiService.registerUser(
                      _usernameController.text,
                      _emailController.text,
                      _passwordController.text);

                  setState(() => isSubmitted = false);

                  if (response.statusCode == 200 ||
                      response.statusCode == 201) {
                    print('Registro exitoso: ${response.body}');

                    /// Display success message
                    _successResponse(context);

                    _storeUserData(response.body);

                    _redirectUser();
                  } else {
                    print(response.body);
                    // {data: null, error: {status: 400, name: ValidationError, message: This attribute must be unique, details: {errors: [{path: [documentId], message: This attribute must be unique, name: ValidationError}]}}}

                    _errorResponse(context, response.body['error']);
                  }
                } else {
                  print('Formulario no valido');
                }
              },
            ),
          );
  }

  void _successResponse(BuildContext context) {
    final _snackBar = SnackBar(
      content: Text('Usuario ${_usernameController.text} creado con exito!',
          style: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(color: Colors.white)),
      backgroundColor: Color(0xff54c500),
    );
    // _scaffoldKey.currentState!.showSnackBar(_snackBar);
    ScaffoldMessenger.of(context).showSnackBar(_snackBar);
  }

  void _errorResponse(BuildContext context, dynamic error) {
    if (error['details'].isNotEmpty) {
      error['details']['errors'].forEach((element) {
        // print('${element['path']}: ${element['message']}');

        // TODO: remover el documentId de la respuesta
        if (element['path'].isNotEmpty && element['path'][0] == 'documentId') {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('El número de cédula ya existe',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: Colors.white)),
            backgroundColor: Theme.of(context).colorScheme.error,
          ));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('${element['path']}: ${element['message']}',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: Colors.white)),
            backgroundColor: Colors.red,
          ));
        }
      });
    } else {
      final _snackBar = SnackBar(
        content: Text('${error['message']}',
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(color: Colors.white)),
        backgroundColor: Colors.red,
      );
      ScaffoldMessenger.of(context).showSnackBar(_snackBar);
    }
  }

  TextFormField _passwordTextField(BuildContext context) {
    return TextFormField(
      controller: _passwordController,
      validator: (value) => value!.length < 6
          ? 'La contraseña debe tener al menos 6 caracteres'
          : null,
      obscureText: _obscurePassword,
      style: TextStyle(color: Theme.of(context).primaryColor),
      decoration: inputDecorationBorderGreen(
          icon: Icon(
            Icons.lock_outline,
            color: Theme.of(context).primaryColor,
          ),
          suffixIcon: GestureDetector(
            onTap: () {
              setState(() {
                _obscurePassword = !_obscurePassword;
              });
            },
            child: Icon(
              _obscurePassword
                  ? FontAwesomeIcons.eye
                  : FontAwesomeIcons.eyeSlash,
              color: Theme.of(context).primaryColor,
            ),
          ),
          hintText: 'Contraseña'),
    );
  }

  TextFormField _emailTextField(BuildContext context) {
    return TextFormField(
      controller: _emailController,
      validator: (value) => !value!.contains('@') ? 'Email inválido' : null,
      style: TextStyle(color: Theme.of(context).primaryColor),
      decoration: inputDecorationBorderGreen(
          icon: Icon(
            FontAwesomeIcons.envelope,
            color: Theme.of(context).primaryColor,
          ),
          hintText: 'Correo electrónico'),
    );
  }

  void _storeUserData(Map<String, dynamic> responseData) async {
    final prefs = await SharedPreferences.getInstance();

    prefs.setString('jwt', responseData['jwt']);
    prefs.setString('email', responseData['user']['email']);
    prefs.setString('username', responseData['user']['username']);
    prefs.setString('userId', responseData['user']['id'].toString());

    print(prefs.getString('jwt'));
    print(prefs.getString('email'));
    print(prefs.getString('username'));
    print(prefs.getString('userId'));
  }

  void _redirectUser() {
    Future.delayed(Duration(seconds: 2), () {
      Navigator.pushReplacementNamed(context, MainView.id);
    });
  }
}
