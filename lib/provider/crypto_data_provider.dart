import 'package:flutter/cupertino.dart';
import 'package:flutter_class_a/models/cryptoModels/AllCryptoModel.dart';
import 'package:flutter_class_a/network/api_provider.dart';
import 'package:flutter_class_a/network/response_model.dart';

class CryptoDataProvider extends ChangeNotifier {
  ApiProvider apiProvider = ApiProvider();
  late AllCryptoModel dataFuture;
  late ResponseModel state;
  var response;

  getTopMarketCapData() async {
    state = ResponseModel.loading('is loading....');

    try {
      response = await apiProvider.getTopMarketCapDataFromUrl();

      if (response.statusCode == 200) {
        dataFuture = AllCryptoModel.fromJson(response.data);
        state = ResponseModel.completed('done');
      } else {
        state = ResponseModel.error('somthing is wrong....');
      }
      notifyListeners();
    } catch (e) {
      state = ResponseModel.error('check your connection....');
      notifyListeners();
    }
  }
}
