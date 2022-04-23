import 'dart:convert';

import 'package:http/http.dart' as http;
import 'constants.dart';

class FetchData {
  String data;

  FetchData({this.data = ''});

  Future fetchCurrentExchangeRates({String currencyName = 'USD'}) async {
    dynamic fiatRate;
    var data;

    print('fine before getting response');
    http.Response response = await http.get(Uri.parse(
        'https://rest.coinapi.io/v1/exchangerate/BTC/USD?apikey=4604238A-5C1D-40AC-9042-303D22FDC02E'));
    //'https://rest.coinapi.io/v1/exchangerate/BTC/$currencyName&apikey=$kApiKey'));
    print('fine before getting response');
    if (response.statusCode == 200) {
      print('status ok');
      data = response.body;
      dynamic decodedData = jsonDecode(data);
      print('rate : ${decodedData['rate']}');
      return decodedData['rate'];
    } else {
      print('status not ok');
      return 0;
    }
  }
}
