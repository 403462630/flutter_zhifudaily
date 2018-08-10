
import 'package:dio/dio.dart';

/// 参考okhttp的HttpLoggingInterceptor输出log
/// 先简单实现，以后有时间在完善代码
class LogInterceptor {

  const LogInterceptor();

  onSend(Options options) {
    String requestStartMessage = "--> "
        + options.method
        + ' ' + options.baseUrl + options.path;
    print(requestStartMessage);
    print("Content-Type: " + options.contentType.value);

    Map headers = options.headers;
    for (var key in headers.keys) {
      print(key + ": " + headers[key]);
    }
    if (options.data != null) {
      print("" + options.data.toString());
    }

    return options;
  }

  onError(DioError e) {
    print(e);
    return e;
  }

  onSuccess(Response e) {
    print("<-- " + e.statusCode.toString() + ' ' + e.request.baseUrl + e.request.path);
    print(e.data);
    return e;
  }
}