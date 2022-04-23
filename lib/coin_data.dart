import 'dart:convert';

import 'package:http/http.dart' as http;
import 'constants.dart';

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

class CoinData {
  String data;

  CoinData({this.data = ''});

  Future getCoinData(
      {String currencyName = 'AUD', String coinName = ''}) async {
    dynamic fiatRate;
    var data;

    print('fine before getting response');
    http.Response response = await http.get(Uri.parse(
        'https://rest.coinapi.io/v1/exchangerate/$coinName/$currencyName?apikey=4604238A-5C1D-40AC-9042-303D22FDC02E'));
    //'https://rest.coinapi.io/v1/exchangerate/BTC/$currencyName&apikey=$kApiKey'));
    print('fine before getting response');

    print(response.statusCode);
    if (response.statusCode == 200) {
      print('status ok');
      data = response.body;
      dynamic decodedData = jsonDecode(data);
      print('rate : ${decodedData['rate']}');
      return decodedData['rate'];
    } else {
      print(response.body);
      print('status not ok');
      return 0;
    }
  }
}
