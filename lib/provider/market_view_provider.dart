import 'package:flutter/cupertino.dart';
import 'package:flutter_class_a/models/cryptoModels/AllCryptoModel.dart';
import 'package:flutter_class_a/network/api_provider.dart';
import 'package:flutter_class_a/network/response_model.dart';

class MarketViewProvider extends ChangeNotifier {
  ApiProvider apiProvider = ApiProvider();
  late var dataFuture;
  late ResponseModel state;
  var response;
  getCryptoData() async {
    state = ResponseModel.loading('is loading....');
    try {
      response = await apiProvider.getAllCryptoData();
      if (response.statusCode == 200) {
        dataFuture = AllCryptoModel.fromJson(response.data);
        state = ResponseModel.completed('done');
      } else {
        state = ResponseModel.error('somthing is wrong');
      }
      notifyListeners();
    } catch (e) {
      state = ResponseModel.error('check your connection...');
      notifyListeners();
      print(e.toString());
    }
  }
}
