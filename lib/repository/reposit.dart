import 'package:http/http.dart' as http;

class Repository{
  String urldasarnya = "http://blog-api.premieraesthetics.id/api";

  ambilData(String alamatApi)async{
  return await  http.get(urldasarnya+ '/'+ alamatApi, );
  }

}