import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncman_new/screens/auth/login.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiService {
  static final ApiService _instance = ApiService._internal();
  final Dio _dio;

  factory ApiService() {
    return _instance;
  }

  ApiService._internal()
      : _dio = Dio(
          BaseOptions(
            baseUrl: dotenv.get('API_URL', fallback: 'https://api.sortisoft.com/api/app'),
          ),
        ) {
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        final tenantId = dotenv.get('TENANT_ID', fallback: 'FERCOVEN_2024123180_db');

        options.headers['X-Tenant-ID'] = tenantId;
        options.headers['Content-Type'] = 'application/json';

        final SharedPreferences prefs = await SharedPreferences.getInstance();
        final String myToken = prefs.getString('authToken') ?? '';
        options.headers['Authorization'] = 'Bearer $myToken';

        return handler.next(options);
      },
      onError: (DioException e, handler) async {
        if (e.response?.statusCode == 401) {
          // Remove Token
          final prefs = await SharedPreferences.getInstance();
          await prefs.remove('authToken');
          await prefs.remove('name');
          await prefs.remove('reopened');

          // Redirect to LoginView
          _redirectToLogin();
        }
        return handler.next(e); // Continúa con el error
      },
    ));
  }

  void _redirectToLogin() {
    if (_navigatorKey?.currentContext != null) {
      Navigator.of(_navigatorKey!.currentContext!).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const LoginView()),
        (route) => false,
      );
    }
  }

  static GlobalKey<NavigatorState>? _navigatorKey;

  static void initializeNavigatorKey(GlobalKey<NavigatorState> navigatorKey) {
    _navigatorKey = navigatorKey;
  }

  // Generalized headers with optional token
  Map<String, dynamic> _buildHeaders({String? token}) {
    final headers = <String, dynamic>{};
    if (token != null) {
      headers['Content-Type'] = 'application/json';
      headers['Authorization'] = 'Bearer $token';
    }
    return headers;
  }

  // Get Method
  Future<Response?> getRequest(String endpoint,
      {Map<String, dynamic>? params, String? token}) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String myToken = prefs.getString('authToken') ?? '';
      final options = Options(headers: _buildHeaders(token: myToken));
      final response = await _dio.get(endpoint, queryParameters: params, options: options);
      return response;
    } catch (e) {
      return null;
    }
  }

  Future<Response?> getRequestNew(
    String endpoint, {
    Map<String, dynamic>? params,
  }) async {
    try {
      print('=== Making API request to $endpoint ===');
      print('Params: $params');
      
      final response = await _dio.get(
        endpoint,
        queryParameters: params,
        options: Options(
          validateStatus: (status) => true, // Accept all status codes
        ),
      );
      
      print('=== API Response Status: ${response.statusCode} ===');
      
      if (response.statusCode != 200) {
        print('=== Error response from API ===');
        print('Status code: ${response.statusCode}');
        print('Response data: ${response.data}');
        return response;
      }
      
      return response;
    } on DioException catch (e) {
      print('=== DioException in getRequestNew ===');
      print('Error type: ${e.type}');
      print('Error message: ${e.message}');
      print('Error response: ${e.response?.data}');
      return e.response;
    } catch (e, stackTrace) {
      print('=== Unexpected error in getRequestNew ===');
      print('Error: $e');
      print('Stack trace: $stackTrace');
      return null;
    }
  }

  // Post Method
  Future<Response?> postRequest(String endpoint,
      {Map<String, dynamic>? data, String? token}) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String myToken = prefs.getString('authToken') ?? '';

      final options = Options(
        headers: _buildHeaders(token: myToken),
        validateStatus: (status) => true, // Accept all status codes
      );

      final response = await _dio.post(
        endpoint,
        data: data, // Send raw data, let Dio handle the encoding
        options: options,
      );

      if (response.statusCode == 200 && response.data != null) {
        final newToken = response.data['token'];
        if (newToken != null && newToken.isNotEmpty) {
          await prefs.setString('authToken', newToken);
          _dio.options.headers['Authorization'] = 'Bearer $newToken';
        }
        return response;
      } else {
        return response; // Return the response even if it's an error
      }
    } catch (e) {
      if (e is DioException) {
        return e.response; // Return the error response if available
      }
      return null;
    }
  }

  // Put Method
  Future<Response?> putRequest(String endpoint, {Map<String, dynamic>? data, String? token}) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String myToken = prefs.getString('authToken') ?? '';
      final options = Options(headers: _buildHeaders(token: myToken));
      final response = await _dio.put(endpoint, data: data, options: options);
      return response;
    } catch (e) {
      return null;
    }
  }

  // Delete Method
  Future<Response?> deleteRequest(String endpoint, {String? token}) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String myToken = prefs.getString('authToken') ?? '';
      final options = Options(headers: _buildHeaders(token: myToken));
      final response = await _dio.delete(endpoint, options: options);
      return response;
    } catch (e) {
      return null;
    }
  }
}
