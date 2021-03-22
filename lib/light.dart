import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/cupertino.dart';

class Pockets extends ChangeNotifier {
  bool active = false;

  void onPowerSwitch() {
    if(active == false)
      active = true;
    else
      active = false;
    notifyListeners();
  }

}