import 'package:flutter/material.dart';

// packages
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

// helpers
import 'package:coopmt_app/ui/labels/custom_labels.dart';
import 'package:coopmt_app/ui/style_inputs/style_input_decoration.dart';
import 'package:coopmt_app/services/strapi_service.dart';

// views
import 'package:coopmt_app/ui/views/register_view.dart';
import 'package:coopmt_app/ui/views/main_view.dart';
import 'package:coopmt_app/ui/views/forgot_password_view.dart';
import 'package:coopmt_app/ui/views/terms_and_conditions_view.dart';

class LoginView extends StatefulWidget {
  // static const String ROUTE = '/auth';
  static String id = 'login_view';
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();
  bool isSubmitted = false;
  bool _obscurePassword = true;
  final _usernameController = TextEditingController();
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
      appBar: AppBar(
        title: const Text(
          'Inicia sesión',
          textDirection: TextDirection.ltr,
        ),
        foregroundColor: const Color(0xFF308A40),
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
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    logoSvg,

                    const SizedBox(
                      height: 50,
                    ),

                    _title(context),
                    const SizedBox(
                      height: 20,
                    ),

                    ///Email
                    _emailTextField(),
                    const SizedBox(
                      height: 20,
                    ),

                    ///Password
                    _passwordTextField(),
                    const SizedBox(
                      height: 20,
                    ),

                    ///Forgot password
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          child: Text(
                            '¿Olvidaste tu contraseña?',
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(
                                    color: Theme.of(context).primaryColor),
                          ),
                          onPressed: () {
                            setState(() {
                              Navigator.pushNamed(
                                  context, ForgotPasswordView.id);
                            });
                          },
                        ),
                      ],
                    ),

                    const SizedBox(
                      height: 20,
                    ),

                    ///Button
                    _actions(context),

                    const SizedBox(
                      height: 50,
                    ),

                    Text(
                      'Si eres un socio nuevo',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    const SizedBox(
                      height: 10,
                    ),

                    ///Register
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          child: Text('Regístrate ahora',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .copyWith(
                                      color: Theme.of(context).primaryColor)),
                          onPressed: () {
                            setState(() {
                              Navigator.pushNamed(context, RegisterView.id,
                                  arguments: "John Doe");
                            });
                          },
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 50,
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

                    ///Login with Google
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: [
                    //     ElevatedButton(
                    //       onPressed: () {},
                    //       child: const Icon(
                    //         FontAwesomeIcons.google,
                    //       ),
                    //     ),
                    //   ],
                    // ),
                  ]),
            ),
          ),
        ),
      ),
    );
  }

  Text _title(BuildContext context) {
    return Text(
      'Inicia sesión',
      style: Theme.of(context)
          .textTheme
          .headlineLarge!
          .copyWith(color: Theme.of(context).primaryColor),
      textAlign: TextAlign.center,
    );
  }

  Widget _actions(BuildContext context) {
    return isSubmitted
        ? CircularProgressIndicator(color: Theme.of(context).primaryColor)
        : SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                elevation: 0,
                padding: const EdgeInsets.symmetric(
                    horizontal: 40.0, vertical: 20.0),
              ),
              child: Text(
                "Iniciar sesión",
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(color: Colors.white),
              ),
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  setState(() => isSubmitted = true);

                  final response = await strapiService.login(
                    _usernameController.text,
                    _passwordController.text,
                  );

                  setState(() => isSubmitted = false);

                  if (response.statusCode == 200 ||
                      response.statusCode == 201) {
                    print('Login exitoso: ${response.body}');

                    _successResponse(context);

                    _storeUserData(response.body);

                    _redirectUser();
                  } else {
                    print(response.body);

                    _errorResponse(response.body['error']);
                  }
                } else {
                  print('Error al procesar el formulario');
                }
              },
            ),
          );
  }

  TextFormField _passwordTextField() {
    return TextFormField(
      obscureText: _obscurePassword,
      controller: _passwordController,
      validator: (value) => value!.length < 6 ? 'Contraseña incorrecta' : null,
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

  TextFormField _emailTextField() {
    return TextFormField(
      controller: _usernameController,
      // validator: (value) => !value!.contains('@') ? 'Email inválido' : null,
      validator: (value) =>
          value!.length < 11 ? 'Email o número de cédula incorrecto' : null,
      style: TextStyle(color: Theme.of(context).primaryColor),
      decoration: inputDecorationBorderGreen(
          icon: Icon(
            FontAwesomeIcons.user,
            color: Theme.of(context).primaryColor,
          ),
          hintText: 'Email o Número de cédula'),
    );
  }

  void _successResponse(BuildContext context) {
    final _snackBar = SnackBar(
      content: Text('Iniciando sesión como ${_usernameController.text}',
          style: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(color: Colors.white)),
      backgroundColor: Color(0xff54c500),
    );
    ScaffoldMessenger.of(context).showSnackBar(_snackBar);
  }

  void _errorResponse(String msj) {
    final _snackBar = SnackBar(
      content: Text(
        msj,
        style: TextStyle(color: Colors.white),
      ),
      backgroundColor: Theme.of(context).colorScheme.error,
    );
    ScaffoldMessenger.of(context).showSnackBar(_snackBar);
    // Scaffold.of(context).showSnackBar(_snackBar);
    // _scaffoldKey.currentState.showSnackBar(_snackBar);
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
      Navigator.pushReplacementNamed(context, MainView.id,
          arguments: _usernameController.text);
    });
  }
}
