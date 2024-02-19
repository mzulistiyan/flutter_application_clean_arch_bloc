import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';
import 'package:xml/xml.dart';
import '../../common/common.dart';
import '../../core/core.dart';

class DioClient {
  DioClient._();

  final Dio _dio = Dio(
    BaseOptions(
      validateStatus: (_) => true,
    ),
  );

  static final DioClient _instance = DioClient._();

  factory DioClient({
    Logger? logger,
    SharedPrefClient? sharedPrefClient,
    CookieJar? cookieJar,
  }) {
    if (logger != null) {
      _instance._dio.interceptors.add(
        LoggingInterceptor(
          logger: logger,
        ),
      );
      _instance._dio.interceptors.add(CookieManager(cookieJar ?? CookieJar()));
    }

    return _instance;
  }

  bool isSuccess(int? statusCode) => statusCode == 200 || statusCode == 201;

  /// get
  Future<Response> get({
    required String url,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParams,
    ResponseType responseType = ResponseType.json,
    bool dynamicUrl = false,
  }) async {
    headers ??= {};
    SecureStorageClient storageClient = SecureStorageClient.instance;

    String token = await storageClient.getByKey(SharedPrefKey.accessToken) ?? '';

    headers['Cookie'] = 'token=$token';

    try {
      final Response response = await _dio.get(
        dynamicUrl ? url : UrlConstant.baseUrl + url,
        options: Options(
          headers: headers,
          contentType: 'application/json',
          responseType: responseType,
        ),
        queryParameters: queryParams,
      );

      return response;
    } catch (e) {
      rethrow;
    }
  }

  /// post
  Future<Response> post({
    required String url,
    dynamic data,
    String? token,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParams,
  }) async {
    headers ??= {};

    SecureStorageClient storageClient = SecureStorageClient.instance;

    String token = await storageClient.getByKey(SharedPrefKey.accessToken) ?? '';

    headers['Cookie'] = 'token=$token';

    try {
      final Response response = await _dio.post(
        UrlConstant.baseUrl + url,
        data: data,
        options: Options(
          headers: headers,
          contentType: 'application/json',
          responseType: ResponseType.json,
        ),
        queryParameters: queryParams,
      );

      return response;
    } catch (e) {
      rethrow;
    }
  }

  /// patch
  Future<Response> patch({
    required String url,
    dynamic data,
    String? token,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParams,
  }) async {
    headers ??= {};

    if (token != null) headers['Authorization'] = 'Bearer $token';

    try {
      final Response response = await _dio.patch(
        UrlConstant.baseUrl + url,
        data: data,
        options: Options(
          headers: headers,
          contentType: 'application/json',
          responseType: ResponseType.json,
        ),
        queryParameters: queryParams,
      );

      return response;
    } catch (e) {
      rethrow;
    }
  }

  /// put
  Future<Response> put({
    required String url,
    dynamic data,
    String? token,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParams,
  }) async {
    headers ??= {};

    if (token != null) headers['Authorization'] = 'Bearer $token';

    try {
      final Response response = await _dio.put(
        UrlConstant.baseUrl + url,
        data: data,
        options: Options(
          headers: headers,
          contentType: 'application/json',
          responseType: ResponseType.json,
        ),
        queryParameters: queryParams,
      );

      return response;
    } catch (e) {
      rethrow;
    }
  }

  /// delete
  Future<Response> delete({
    required String url,
    dynamic data,
    String? token,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParams,
  }) async {
    headers ??= {};

    if (token != null) headers['Authorization'] = 'Bearer $token';

    try {
      final Response response = await _dio.delete(
        UrlConstant.baseUrl + url,
        data: data,
        options: Options(
          headers: headers,
          contentType: 'application/json',
          responseType: ResponseType.json,
        ),
        queryParameters: queryParams,
      );

      return response;
    } catch (e) {
      rethrow;
    }
  }

  //Special case for login with cookie
  Future<ResponseDataSignIn> signIn({required String url, dynamic data}) async {
    SecureStorageClient storageClient = SecureStorageClient.instance;
    try {
      final Response response = await _dio.post(
        UrlConstant.baseUrl + url,
        data: data,
        options: Options(
          contentType: 'application/json',
          responseType: ResponseType.json,
        ),
      );

      // Ini Ekstrak cookie dari response
      final String? cookies = response.headers.map['set-cookie']?.first;
      if (cookies != null) {
        // Ini Ekstrak token dari cookie
        final RegExp regExp = RegExp(r'token=([^;]+)');
        final match = regExp.firstMatch(cookies);
        final String? token = match?.group(1);

        if (token != null) {
          // Mengembalikan token
          await storageClient.saveKey(SharedPrefKey.accessToken, token);
          return ResponseDataSignIn(token: token, response: response);
        } else {
          throw Exception('Token tidak ditemukan dalam cookie');
        }
      } else {
        throw Exception('Cookie tidak ditemukan dalam response');
      }
    } catch (e) {
      rethrow;
    }
  }

  /// refresh token
  Future<Response> refreshToken({
    required String email,
    required String password,
  }) async {
    try {
      final Response response = await _dio.post(
        UrlConstant.baseUrl + UrlConstant.login,
        data: {
          'email': email,
          'password': password,
          'mode': 'json',
        },
      );

      return response;
    } catch (e) {
      rethrow;
    }
  }
}

class LoggingInterceptor extends Interceptor {
  final Logger logger;

  LoggingInterceptor({
    required this.logger,
  });

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (kDebugMode) {
      // Log request details
      logger.d(
        "Request: ${options.method} ${options.path}\nHeaders: ${options.headers}\nQuery Parameters: ${options.queryParameters}\nBody: ${options.data}",
      );
    }
    // Continue with request
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    if (kDebugMode) {
      // Log response details
      logger.d("Response: ${response.requestOptions.path}\nStatus Code: ${response.statusCode}\nData: ${isXmlString(response.data) ? 'XML' : response.data}");
      if (response.statusCode == 401 && response.data['errors'][0]['extensions']['code'] == 'TOKEN_EXPIRED') {
        SharedPrefClient sharedPrefClient = SharedPrefClient.instance;
        DioClient dioClient = DioClient._instance;
        String email = await sharedPrefClient.getByKey(
              key: SharedPrefKey.authEmail,
            ) ??
            '';
        String password = await sharedPrefClient.getByKey(
              key: SharedPrefKey.authPassword,
            ) ??
            '';
        Response responseRefreshToken = await dioClient.refreshToken(email: email, password: password);

        if (responseRefreshToken.statusCode == 200) {
          String accessToken = responseRefreshToken.data['data']['access_token'];

          // save access token to local storage
          await sharedPrefClient.saveKey(
            key: SharedPrefKey.accessToken,
            data: accessToken,
          );

          final clonedRequest = await dioClient._dio.request(
            response.requestOptions.path,
            options: Options(
              headers: {
                'Authorization': 'Bearer $accessToken',
              },
              contentType: 'application/json',
              responseType: ResponseType.json,
            ),
            data: response.requestOptions.data,
            queryParameters: response.requestOptions.queryParameters,
          );

          return handler.resolve(clonedRequest);
        }
      }
    }
    // Continue with response
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (kDebugMode) {
      // Log error details
      logger.e("Error: ${err.type} ${err.message}");
    }
    // Continue with error handling
    super.onError(err, handler);
  }

  bool isXmlString(dynamic input) {
    if (input.runtimeType == String) {
      try {
        XmlDocument.parse(input);
        return true;
      } on XmlException {
        return false;
      }
    }
    return false;
  }
}

class ResponseDataSignIn {
  final String? token;
  final Response response;

  ResponseDataSignIn({this.token, required this.response});
}
