import 'package:dio/dio.dart';

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
      onRequest: (options, handler) async {
        // 请求拦截器：添加公共请求参数、token 等
        // todo
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
}
