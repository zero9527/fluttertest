import '../api/index.dart';

// 日志上传
void logUtil({String apiUrl, params, e}) async {
  var logRes = await new HttpUtil().post('/api/log/logUpload', {
    'apiUrl': apiUrl,
    'params': params,
    'e': e
  });
  print('logRes: $logRes');
}
