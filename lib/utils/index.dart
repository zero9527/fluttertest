import '../api/index.dart';

// 报错上传
void logUtil({String apiUrl, params, e}) async {
  if (apiUrl == "/api/log/logUpload") return;
  var logRes = await new HttpUtil().post('/api/log/logUpload', {
    'apiUrl': apiUrl,
    'params': params,
    'e': e
  });
  print('logRes: $logRes');
}
