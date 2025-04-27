import 'package:dio/dio.dart';
import 'package:my_template/core/logging/log.dart';
import 'package:my_template/shared/services/network/network_exceptions.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'rest_api.g.dart';

@Riverpod(keepAlive: false)
RestApi restApi(RestApiRef ref, String baseUrl) => RestApi(baseUrl);

class RestApi {
  RestApi(this._baseUrl) {
    _dio.options.baseUrl = _baseUrl;
    Log.info(this, "RestApi initialized with base URL: $_baseUrl");
  }

  final Dio _dio = Dio();
  final String _baseUrl;

  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    Log.info(this, "GET request: $path");
    Log.trace(this, "Query parameters: $queryParameters");
    try {
      final response =
          await _dio.get<T>(path, queryParameters: queryParameters);
      Log.info(this, "GET request successful: $path");
      Log.trace(this, "Response: ${response.data}");
      return response;
    } on DioError catch (e) {
      Log.error(this, "GET request failed: $path", error: e);
      throw _handleDioException(e);
    } catch (e) {
      Log.error(this, "Unexpected error in GET request: $path", error: e);
      throw Exception('An unexpected error occurred: $e');
    }
  }

  Future<Response<T>> post<T>(String path, dynamic data) async {
    Log.info(this, "POST request: $path");
    Log.debug(this, "Request data: $data");
    try {
      final response = await _dio.post<T>(path, data: data);
      Log.info(this, "POST request successful: $path");
      Log.debug(this, "Response: ${response.data}");
      return response;
    } on DioError catch (e) {
      Log.error(this, "POST request failed: $path", error: e);
      throw _handleDioException(e);
    } catch (e) {
      Log.error(this, "Unexpected error in POST request: $path", error: e);
      throw Exception('An unexpected error occurred: $e');
    }
  }

  Future<Response<T>> put<T>(String path, dynamic data) async {
    Log.info(this, "PUT request: $path");
    Log.debug(this, "Request data: $data");
    try {
      final response = await _dio.put<T>(path, data: data);
      Log.info(this, "PUT request successful: $path");
      Log.debug(this, "Response: ${response.data}");
      return response;
    } on DioError catch (e) {
      Log.error(this, "PUT request failed: $path", error: e);
      throw _handleDioException(e);
    } catch (e) {
      Log.error(this, "Unexpected error in PUT request: $path", error: e);
      throw Exception('An unexpected error occurred: $e');
    }
  }

  Future<Response<T>> delete<T>(String path) async {
    Log.info(this, "DELETE request: $path");
    try {
      final response = await _dio.delete<T>(path);
      Log.info(this, "DELETE request successful: $path");
      Log.debug(this, "Response: ${response.data}");
      return response;
    } on DioError catch (e) {
      Log.error(this, "DELETE request failed: $path", error: e);
      throw _handleDioException(e);
    } catch (e) {
      Log.error(this, "Unexpected error in DELETE request: $path", error: e);
      throw Exception('An unexpected error occurred: $e');
    }
  }

  Future<Response<T>> patch<T>(String path, dynamic data) async {
    Log.info(this, "PATCH request: $path");
    Log.debug(this, "Request data: $data");
    try {
      final response = await _dio.patch<T>(path, data: data);
      Log.info(this, "PATCH request successful: $path");
      Log.debug(this, "Response: ${response.data}");
      return response;
    } on DioError catch (e) {
      Log.error(this, "PATCH request failed: $path", error: e);
      throw _handleDioException(e);
    } catch (e) {
      Log.error(this, "Unexpected error in PATCH request: $path", error: e);
      throw Exception('An unexpected error occurred: $e');
    }
  }

  Exception _handleDioException(DioError e) {
    Log.error(this, "Handling DioError", error: e);
    switch (e.type) {
      case DioErrorType.connectTimeout:
      case DioErrorType.sendTimeout:
      case DioErrorType.receiveTimeout:
        return TimeoutException('Connection timed out');
      case DioErrorType.response:
        return HttpException(
          'Server responded with error ${e.response?.statusCode}',
        );
      case DioErrorType.cancel:
        return CancelException('Request was cancelled');
      case DioErrorType.other:
        return NetworkException('A network error occurred: ${e.message}');
    }
  }
}
