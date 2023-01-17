import 'package:aurealembed/Services/palette_generator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:provider/provider.dart';

class EpisodeProvider extends ChangeNotifier{

  bool _isBlack = false;

  bool get isBlack => _isBlack;

  set isBlack(bool newValue){
    _isBlack = newValue;

    notifyListeners();
  }

  PaletteGenerator? _paletteGenerator;

  PaletteGenerator? get paletteGenerator => _paletteGenerator;

  set paletteGenerator(newValue){
    _paletteGenerator = newValue;

    notifyListeners();
  }


  Future<void> getPalette(String image)async{
    await updatePaletteGenerator(image).then((value) {
      _paletteGenerator = value;
      _isBlack = calculateTextColor(value.dominantColor!.color) == Colors.black ? true : false;
    });
  }

  var _currentlyPlaying;

  get currentlyPlaying => _currentlyPlaying;

  set currentlyPlaying(newValue){
    _currentlyPlaying = newValue;

    notifyListeners();
  }

}