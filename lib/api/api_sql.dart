// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:coopmt_app/helpers/get_ip_address.dart';
// import 'package:coopmt_app/services/strapi_service.dart';

// class ApiConnect {
//   ///Funcion para dar de alta a los usuarios
//   Future<void> registerUser(
//       String username, String email, String password) async {
//     username = '55555555555';
//     email = 'almapuello@gmail.com';
//     password = '123456';

//     var localhostIpAddress = getIpAddress();
//     var url = 'http://${localhostIpAddress}/auth/local/register';
//     var response = await http.post(Uri.parse(url),
//         body: {'username': username, 'email': email, 'password': password});
//     print('${response.statusCode}');
//   }
// }

///Funcion para dar de alta a los usuarios
// Future<void> registerUser(
//     String username, String email, String password) async {
  // username = '55555555555';
  // email = 'almapuello@gmail.com';
  // password = '123456';

//   final Map<String, dynamic> requestBody = {
//     'username': username,
//     'email': email,
//     'password': password
//   };

//   final response = await http.post(
//     Uri.parse('${StrapiConfig.baseURL}${StrapiConfig.register}'),
//     headers: {
//       'Content-Type': 'application/json',
//     },
//     body: jsonEncode(requestBody),
//   );

//   if (response.statusCode == 200) {
//     final user = jsonDecode(response.body);
//     print('Registro exitoso: ${user}');
//   } else {
//     print('Error en el registro del usuario: ${response.statusCode}');
//   }
// }
