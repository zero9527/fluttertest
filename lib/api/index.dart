import 'package:dio/dio.dart';
import '../utils/index.dart' show logUtil;

Dio dio = new Dio();

String errText = '请求失败！请确认请求地址、请求方式、参数等正确后再试试！';

class HttpUtil {
  HttpUtil() {
    dio.options.baseUrl = 'http://192.168.0.5:2333';
    dio.options.connectTimeout = 5000;
    // dio.options.receiveTimeout = 5000;

    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (RequestOptions options){
        final path = options.path;
        print('apiUrl: $path');
        // Do something before request is sent
        return options; //continue
        // If you want to resolve the request with some custom data，
        // you can return a `Response` object or return `dio.resolve(data)`.
        // If you want to reject the request with a error message,
        // you can return a `DioError` object or return `dio.reject(errMsg)`
      },
      onResponse: (Response response) {
        // Do something with response data
        return response; // continue
      },
      onError: (DioError e) {
        // Do something with response error
        return e;//continue
      }
    ));
  }

  // methods: 'get'
  get(String apiUrl, [params]) async {
    try {
      Response res = await dio.get(apiUrl, queryParameters: params);
      return statusCodeCheck(res);
    } catch (e) {
      logPrint(apiUrl: apiUrl, method: 'GET', e: e);
      logUtil(apiUrl: apiUrl, params: params);
      return errText;
    }
  }
  
  // methods: 'post'
  post(String apiUrl, [params]) async {
    try {
      Response res = await dio.post(apiUrl, data: params);
      return statusCodeCheck(res);
    } catch (e) {
      logPrint(apiUrl: apiUrl, method: 'POST', e: e);
      logUtil(apiUrl: apiUrl, params: params);
      return errText;
    }
  }

  // methods: 'put'
  put(String apiUrl, [params]) async {
    try {
      Response res = await dio.put(apiUrl, data: params);
      return statusCodeCheck(res);
    } catch (e) {
      logPrint(apiUrl: apiUrl, method: 'PUT', e: e);
      logUtil(apiUrl: apiUrl, params: params, e: e);
      return errText;
    }
  }

  // methods: 'delete'
  delete(String apiUrl, [params]) async {
    try {
      Response res = await dio.delete(apiUrl, data: params);
      return statusCodeCheck(res);
    } catch (e) {
      logPrint(apiUrl: apiUrl, method: 'DELETE', e: e);
      logUtil(apiUrl: apiUrl, params: params);
      return errText;
    }
  }

  // methods: 'download'
  download(String apiUrl, savePath, [params]) async {
    try {
      Response res = await dio.download(apiUrl, savePath, data: params);
      return statusCodeCheck(res);
    } catch (e) {
      logPrint(apiUrl: apiUrl, method: 'DOWNLOAD', e: e);
      logUtil(apiUrl: apiUrl, params: params);
      return errText;
    }
  }

  statusCodeCheck(res) {
    if (res.statusCode == 200) {
      return res.data;
    } else {
      print('res: [$res]');
    }
  }

  void logPrint({ e, apiUrl, method }) {
    print('[$apiUrl], [$method], $e');
  }
}
