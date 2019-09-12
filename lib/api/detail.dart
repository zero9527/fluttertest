import './index.dart';

getFile(params) {
  return http('/api/file/getFile', params);
}