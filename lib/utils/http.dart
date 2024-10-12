import 'package:dio/dio.dart';
import 'package:enjoy_plus_hm/utils/evntbus.dart';
import 'package:enjoy_plus_hm/utils/token.dart';

class NetworkService {
  // 1. 创建一个dio实例对象
  final _dio = Dio();

  // 2. 统一配置
  NetworkService() {
    _dio.options.baseUrl = 'https://live-api.itheima.net';
    _dio.options.connectTimeout = const Duration(seconds: 20);
    _dio.options.receiveTimeout = const Duration(seconds: 20);
    _dio.options.headers = {'Content-Type': 'application/json'};
    // 配置请求和响应拦截器
    _addInterceptors();
  }

  // 3. 添加拦截器
  void _addInterceptors() {
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        // 请求拦截器：添加公共请求参数、token 等
        // 3.1 拿到token
        final token = TokenManager().getToken() ?? '';
        // 3.2 添加token到请求头
        if (token.isNotEmpty) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        return handler.next(options);
      },
      onResponse: (response, handler) {
        // 响应拦截器：统一处理成功响应
        return handler.next(response);
      },
      onError: (DioException error, handler) {
        // 响应拦截器：统一处理错误响应
        return handler.next(error);
      },
    ));
  }

  /// get请求
  Future<dynamic> get(String url, {Map<String, dynamic>? params}) async {
    try {
      final res = await _dio.get(url, queryParameters: params);
      return handleResponse(res);
    } catch (e) {
      return handleError(e);
    }
  }

  /// post请求
  Future<dynamic> post(String url, {dynamic data}) async {
    try {
      final res = await _dio.post(url, data: data);
      return handleResponse(res);
    } catch (e) {
      return handleError(e);
    }
  }

  /// put请求
  Future<dynamic> put(String url, {Map<String, dynamic>? data}) async {
    try {
      final res = await _dio.put(url, data: data);
      return handleResponse(res);
    } catch (e) {
      return handleError(e);
    }
  }

  /// delete请求
  Future<dynamic> delete(String url, {Map<String, dynamic>? data}) async {
    try {
      final res = await _dio.delete(url, data: data);
      return handleResponse(res);
    } catch (e) {
      return handleError(e);
    }
  }

  /// 成功结果的处理
  dynamic handleResponse(Response response) {
    if (response.statusCode! >= 200 && response.statusCode! < 300) {
      return response.data;
    } else {
      throw Exception('请求失败，状态码：${response.statusCode}');
    }
  }

  /// 错误结果的处理
  dynamic handleError(error) async {
    if (error is DioException) {
      if (error.type == DioExceptionType.connectionTimeout ||
          error.type == DioExceptionType.receiveTimeout) {
        throw Exception('网络连接超时');
      } else if (error.type == DioExceptionType.badResponse) {
        if (error.response?.statusCode == 401) {
          // 清除token
          await TokenManager().removeToken();
          // 通知跳转到登录页
          eventBus.fire(LogoutEvent());
        } else {
          throw Exception('响应错误，状态码：${error.response?.statusCode}');
        }
      } else {
        throw Exception('网络请求错误：$error');
      }
    } else {
      throw Exception('未知错误：$error');
    }
  }
}

final http = NetworkService();
