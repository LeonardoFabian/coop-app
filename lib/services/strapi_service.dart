import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:coopmt_app/features/core/database.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class StrapiService {
  static String baseURL =
      dotenv.env['STRAPI_BASE_URL'] ?? 'http://10.0.2.2:1337';
  final DatabaseHelper databaseHelper = DatabaseHelper();

  final _servicesStreamController =
      StreamController<List<Map<String, dynamic>>>.broadcast();
  Stream<List<Map<String, dynamic>>> get servicesStream =>
      _servicesStreamController.stream;

  Future<void> fetchAndCacheServices() async {
    try {
      final response = await http
          .get(Uri.parse('$baseURL/api/services'))
          .timeout(const Duration(seconds: 5));

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        // final services = responseData['data'] as List<dynamic>;
        final services = responseData['data'];

        final db = await databaseHelper.database;
        await db.transaction((txn) async {
          for (var service in services) {
            await txn.insert(
              'services',
              {
                "id": service['id'],
                "title": service['attributes']['title'],
                "slug": service['attributes']['slug'],
                "featuredImage": service['attributes']['featuredImage'],
                "price": service['attributes']['price'],
                "timeToComplete": service['attributes']['timeToComplete'],
                "order": service['attributes']['order'],
                "category": service['attributes']['category'],
                "description": service['attributes']['description'],
                "summary": service['attributes']['summary'],
                "isUpdated": 0,
              },
              conflictAlgorithm: ConflictAlgorithm.replace,
            );
          }
        });
      }
    } catch (e) {
      print('Error fetching services: $e');
    } finally {
      await _updateServicesStream();
    }
  }

  Future<List<Map<String, dynamic>>> getLocalServices() async {
    try {
      final db = await databaseHelper.database;
      final services = await db.query('services');
      return services;
    } catch (e) {
      throw Exception(e);
    }
  }

/**
 * Intenta actualizar el backend de Strapi cuando se crea un nuevo servicio, 
 * asegurando la sincronización entre la base de datos local y remota.
 */
  Future<void> createLocalService(Map<String, dynamic> service) async {
    final db = await databaseHelper.database;
    final id = await db.insert(
      'services',
      service,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    service['id'] = id;
    await uploadServiceToBackend(service);
    await _updateServicesStream();
  }

  Future<void> updateLocalService(Map<String, dynamic> service) async {
    final db = await databaseHelper.database;
    final updateData = {
      'title': service['title'],
      'slug': service['slug'],
      'featuredImage': service['featuredImage'],
      'price': service['price'],
      'timeToComplete': service['timeToComplete'],
      'order': service['order'],
      'category': service['category'],
      'description': service['description'],
      'summary': service['summary'],
      'updatedAt': DateTime.now().toIso8601String()
    };
    await db.update(
      'services',
      updateData,
      where: 'id = ?',
      whereArgs: [service['id']],
    );
    await updateServiceOnBackend({...service, ...updateData});
    await _updateServicesStream();
  }

  Future<void> deleteLocalService(int id) async {
    final db = await databaseHelper.database;
    await db.delete(
      'services',
      where: 'id = ?',
      whereArgs: [id],
    );
    await _updateServicesStream();
  }

  Future<void> _updateServicesStream() async {
    final services = await getLocalServices();
    _servicesStreamController.add(services);
  }

/**
 * Se invoca cuando se crea un nuevo servicio localmente y es necesario sincronizarlo con 
 * la base de datos remota, lo que garantiza un flujo de datos fluido.
 */
  Future<void> uploadServiceToBackend(Map<String, dynamic> service,
      {bool isSync = false}) async {
    try {
      final response = await http
          .post(
            Uri.parse('$baseURL/api/services'),
            headers: {'Content-Type': 'application/json'},
            body: json.encode({
              'data': {
                'title': service['title'],
                'slug': service['slug'],
                'featuredImage': service['featuredImage'],
                'price': service['price'],
                'timeToComplete': service['timeToComplete'],
                'order': service['order'],
                'category': service['category'],
                'description': service['description'],
                'summary': service['summary'],
              }
            }),
          )
          .timeout(const Duration(seconds: 5));

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseData = json.decode(response.body);
        final backendId = responseData['data']['id'];

        final db = await databaseHelper.database;
        await db.update(
          'services',
          {
            'id': backendId, // Actualiza el ID en la base de datos local
            'updatedAt': DateTime.now().toIso8601String()
          },
          where: 'id = ?',
          whereArgs: [service['id']],
        );
        service['id'] = backendId;
      } else {
        throw Exception('Failed to upload service to backend');
      }
    } catch (e) {
      print('Error uploading service to backend: $e');
      throw e;
    }
  }

  Future<void> updateServiceOnBackend(Map<String, dynamic> service) async {
    try {
      final response = await http
          .put(
            Uri.parse('$baseURL/api/services/${service['id']}'),
            headers: {'Content-Type': 'application/json'},
            body: json.encode({
              'data': {
                'title': service['title'],
                'slug': service['slug'],
                'featuredImage': service['featuredImage'],
                'price': service['price'],
                'timeToComplete': service['timeToComplete'],
                'order': service['order'],
                'category': service['category'],
                'description': service['description'],
                'summary': service['summary'],
              }
            }),
          )
          .timeout(const Duration(seconds: 5));

      if (response.statusCode == 200) {
        final db = await databaseHelper.database;
        await db.update('services', {'isUpdated': 0},
            where: 'id = ?', whereArgs: [service['id']]);
      } else {
        throw Exception('Failed to update service on backend.');
      }
    } catch (e) {
      print('Error updating service on backend: $e');
      throw e;
    }
  }

  Future<RegisterResponse> registerUser(
      String username, String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseURL/api/auth/local/register'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'documentId': username,
          'username': username, // TODO: utilizar el documentId como username
          'email': email,
          'password': password
        }),
      );

      final responseBody = json.decode(response.body);
      return RegisterResponse(
          statusCode: response.statusCode, body: responseBody);

      // if (response.statusCode == 200 || response.statusCode == 201) {
      //   print('User registered successfully');
      //   print(response.body);
      //   return 'success';
      // } else {
      //   final Map<String, dynamic> responseBody = json.decode(response.body);
      //   String errorMessage = responseBody['error']['message'];
      //   print('Failed to register user: $errorMessage');
      //   return 'error';
      // }
    } catch (e) {
      // print('Error registering user: $e');
      // return 'error';
      return RegisterResponse(
          statusCode: 500, body: {'message': 'Error registering user: $e'});
    }
  }

  Future<RegisterResponse> login(String username, String password) async {
    try {
      final response = await http.post(Uri.parse('$baseURL/api/auth/local'),
          body: {'identifier': username, 'password': password});

      final responseBody = json.decode(response.body);
      return RegisterResponse(
          statusCode: response.statusCode, body: responseBody);
    } catch (e) {
      return RegisterResponse(
          statusCode: 500, body: {'message': 'Error logging in: $e'});
    }
  }
}

class RegisterResponse {
  final int statusCode;
  final Map<String, dynamic> body;

  RegisterResponse({required this.statusCode, required this.body});
}

// class StrapiConfig {
//   // static const String baseURL = 'http://10.0.2.2:1337';
//   static const String baseURL = 'http://10.0.2.2:1337';
//   // static const String baseURL = 'http://localhost:1337';

//   // Endpoints
//   static const String login = '/auth/local';
//   static const String register = '/auth/local/register';
//   static const String getUser = 'users/me';

//   static const String getCategories = '/categories';
//   static const String getTaxonomies = '/taxonomies';
//   static const String getServices = '/services';
//   static const String getProducts = '/products';
//   static const String getCourses = '/courses';
//   static const String getPosts = '/posts';
//   static const String getSlides = '/slides';
//   static const String getSuppliers = '/suppliers';
// }
