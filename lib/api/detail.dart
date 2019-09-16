import './index.dart';

getFile(params) {
  return new HttpUtil().get('/api/file/getFile', params);
}

uploadFile(params) {
  return new HttpUtil().post('/api/file/uploadFile', params);
}
