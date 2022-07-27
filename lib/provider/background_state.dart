import 'package:bloc_provider_exemple/provider/background.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BackgroundStateProvider extends ChangeNotifier {
  Background background = Background(isActived: false);

  changeBackground(Color color) {
    // FFFF44 (amarelo)
    // FFDDDD (rosa/pêssego)
    // 255, 170, 228, 255 (blue)
    // 255, 255, 170, 234 (rosa chiclete)
    background.backgroundColor = color;
    notifyListeners();
  }
}
