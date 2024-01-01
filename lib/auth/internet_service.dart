
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class InternetServise extends ChangeNotifier{
  bool _hasInternet= false;
  bool get hasInternet => _hasInternet;

  set hasInternet(bool value) {
    _hasInternet = value;
    notifyListeners();
  }
  internetProvider(){
    checkInternetConnection();
  }

  Future checkInternetConnection()async{
    var result = await Connectivity().checkConnectivity();
    if(result == ConnectivityResult.none){
      hasInternet=false;
    }else{
      hasInternet=true;
    }
    notifyListeners();
  }
}