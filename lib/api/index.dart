import 'dart:io';

http(String apiUrl, params) async {
  var url = new Uri.http('example.com', apiUrl, params);
  var httpClient = new HttpClient();
  var req = await httpClient.getUrl(url);
  var res = await req.close();
  return res;
  // var resBody = await res.transform(UTF8.decoder).join();
  // return JSON.decode(resBody);
}
