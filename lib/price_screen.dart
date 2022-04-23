import 'package:flutter/material.dart';
import 'coin_data.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = currenciesList[0];
  var bitValue = '';
  var ethValue = '';
  var ltcValue = '';
  CoinData fetchData = CoinData(data: '');
  @override
  void initState() {
    super.initState();
    valueInTextWidget();
  }

  DropdownButton<String> androidDropDownButton() {
    List<DropdownMenuItem<String>> dropDownItems = [];
    for (String currency in currenciesList) {
      dropDownItems.add(DropdownMenuItem(
        child: Center(
            child: Text(
          currency,
          style: TextStyle(
            color: Colors.white,
          ),
        )),
        value: currency,
      ));
    }
    return DropdownButton<String>(
        value: selectedCurrency,
        items: getDropDownItems(),
        onChanged: (value) {
          setState(() {
            selectedCurrency = value!;
            print(value);
            valueInTextWidget();
          });
        });
  }

  CupertinoPicker iOSPicker() {
    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      children: getDropDownItems(),
      onSelectedItemChanged: (selectedIndex) {
        setState(() {
          selectedCurrency = currenciesList[selectedIndex];
          valueInTextWidget();
        });
        print(
            'Selected index $selectedIndex \n Selected currency $selectedCurrency');
      },
      itemExtent: 32.0,
    );
  }

  List<DropdownMenuItem<String>> getDropDownItems() {
    List<DropdownMenuItem<String>> dropDownItems = [];
    for (String currency in currenciesList) {
      dropDownItems.add(DropdownMenuItem(
        child: Center(
            child: Text(
          currency,
          style: TextStyle(
            color: Colors.white,
          ),
        )),
        value: currency,
      ));
    }
    return dropDownItems;
  }

  Widget getPicker() {
    if (Platform.isIOS) {
      return iOSPicker();
    } else {
      return androidDropDownButton();
    }
  }

  // dynamic valueInWidget() async {
  //   var data = await fetchData.fetchCurrentExchangeRates(currencyName: 'USD');
  //   print('value in object is ready : $data');
  //   return data;
  // }

  // Widget valueWidget() {
  //   print('in widget ${valueInWidget()}');
  //   return Text(
  //     '1 BTC = ${valueInWidget()} USD',
  //     textAlign: TextAlign.center,
  //     style: TextStyle(
  //       fontSize: 20.0,
  //       color: Colors.white,
  //     ),
  //   );
  // }

  Future valueInTextWidget() async {
    try {
      var bitdata = await fetchData.getCoinData(
          currencyName: selectedCurrency, coinName: 'BTC');
      var ethdata = await fetchData.getCoinData(
          currencyName: selectedCurrency, coinName: 'ETH');
      var ltcdata = await fetchData.getCoinData(
          currencyName: selectedCurrency, coinName: 'LTC');
      print('value fetched');
      setState(() {
        bitValue = bitdata.toStringAsFixed(0);
        ethValue = ethdata.toStringAsFixed(0);
        ltcValue = ltcdata.toStringAsFixed(0);
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Crypto_Card(
              cryptName: cryptoList[0],
              cryptValue: bitValue,
              selectedCurrency: selectedCurrency),
          Crypto_Card(
              cryptName: cryptoList[1],
              cryptValue: ethValue,
              selectedCurrency: selectedCurrency),
          Crypto_Card(
              cryptName: cryptoList[2],
              cryptValue: ltcValue,
              selectedCurrency: selectedCurrency),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: const EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Center(
              child: iOSPicker(),
            ),
          ),
        ],
      ),
    );
  }
}

class Crypto_Card extends StatelessWidget {
  const Crypto_Card({
    Key? key,
    required this.cryptValue,
    required this.selectedCurrency,
    required this.cryptName,
  }) : super(key: key);

  final String cryptValue;
  final String selectedCurrency;
  final String cryptName;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
      child: Card(
        color: Colors.lightBlueAccent,
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
          child: Text(
            '1 $cryptName = $cryptValue $selectedCurrency',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          ), //valueWidget(),
        ),
      ),
    );
  }
}


//  DropdownButton<String>(
//                 value: selectedCurrency,
//                 items: getDropDownItems(),
//                 onChanged: (value) {
//                   setState(() {
//                     selectedCurrency = value!;
//                     print(value);
//                   });
//                 });