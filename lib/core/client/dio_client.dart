import 'package:dio/dio.dart';
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
  }) {
    if (logger != null) {
      _instance._dio.interceptors.add(
        LoggingInterceptor(
          logger: logger,
        ),
      );
    }
    return _instance;
  }

  bool isSuccess(int? statusCode) => statusCode == 200 || statusCode == 201;

  Future<Response> _request({
    required String method,
    required String url,
    dynamic data,
    String? token,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParams,
    ResponseType responseType = ResponseType.json,
    bool dynamicUrl = false,
  }) async {
    headers ??= {};
    if (token != null) headers['Authorization'] = 'Bearer $token';

    try {
      final Response response = await _dio.request(
        dynamicUrl ? url : UrlConstant.baseUrl + url,
        data: data,
        options: Options(
          method: method,
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

  Future<Response> get({
    required String url,
    String? token,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParams,
    ResponseType responseType = ResponseType.json,
    bool dynamicUrl = false,
  }) =>
      _request(
        method: 'GET',
        url: url,
        token: token,
        headers: headers,
        queryParams: queryParams,
        responseType: responseType,
        dynamicUrl: dynamicUrl,
      );

  Future<Response> post({
    required String url,
    dynamic data,
    String? token,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParams,
  }) =>
      _request(
        method: 'POST',
        url: url,
        data: data,
        token: token,
        headers: headers,
        queryParams: queryParams,
      );

  Future<Response> patch({
    required String url,
    dynamic data,
    String? token,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParams,
  }) =>
      _request(
        method: 'PATCH',
        url: url,
        data: data,
        token: token,
        headers: headers,
        queryParams: queryParams,
      );

  Future<Response> put({
    required String url,
    dynamic data,
    String? token,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParams,
  }) =>
      _request(
        method: 'PUT',
        url: url,
        data: data,
        token: token,
        headers: headers,
        queryParams: queryParams,
      );

  Future<Response> delete({
    required String url,
    dynamic data,
    String? token,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParams,
  }) =>
      _request(
        method: 'DELETE',
        url: url,
        data: data,
        token: token,
        headers: headers,
        queryParams: queryParams,
      );

  Future<Response> refreshToken({
    required String email,
    required String password,
  }) =>
      _request(
        method: 'POST',
        url: UrlConstant.login,
        data: {'email': email, 'password': password, 'mode': 'json'},
      );
}

class LoggingInterceptor extends Interceptor {
  final Logger logger;

  LoggingInterceptor({required this.logger});

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (kDebugMode) {
      logger.d(
        "Request: ${options.method} ${options.path}\nHeaders: ${options.headers}\nQuery Parameters: ${options.queryParameters}\nBody: ${options.data}",
      );
    }
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    if (kDebugMode) {
      logger.d(
        "Response: ${response.requestOptions.path}\nStatus Code: ${response.statusCode}\nData: ${isXmlString(response.data) ? 'XML' : response.data}",
      );
      // if (response.statusCode == 401) {
      //   await _handleTokenExpired(response, handler);
      //   // return;
      // }
    }
    super.onResponse(response, handler);
  }

  Future<void> _handleTokenExpired(
      Response response, ResponseInterceptorHandler handler) async {
    SharedPrefClient sharedPrefClient = SharedPrefClient.instance;
    DioClient dioClient = DioClient._instance;
    String email =
        await sharedPrefClient.getByKey(key: SharedPrefKey.authEmail) ?? '';
    String password =
        await sharedPrefClient.getByKey(key: SharedPrefKey.authPassword) ?? '';
    Response responseRefreshToken =
        await dioClient.refreshToken(email: email, password: password);

    if (responseRefreshToken.statusCode == 200) {
      String accessToken = responseRefreshToken.data['data']['access_token'];
      await sharedPrefClient.saveKey(
          key: SharedPrefKey.accessToken, data: accessToken);

      final clonedRequest = await dioClient._dio.request(
        response.requestOptions.path,
        options: Options(
          headers: {'Authorization': 'Bearer $accessToken'},
          contentType: 'application/json',
          responseType: ResponseType.json,
        ),
        data: response.requestOptions.data,
        queryParameters: response.requestOptions.queryParameters,
      );

      handler.resolve(clonedRequest);
    }
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (kDebugMode) {
      logger.e("Error: ${err.type} ${err.message}");
    }
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
