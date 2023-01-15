import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:aurealembed/Screens/Api/api.dart';
import 'package:aurealembed/Services/palette_generator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';

class PodcastProvider extends ChangeNotifier{

  var _currentlyPlaying;

  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  set currentIndex(int newValue){
    _currentIndex = newValue;

    notifyListeners();
  }

  get currentlyPlaying => _currentlyPlaying;

  set currentlyPlaying(newValue){
    _currentlyPlaying = newValue;

    notifyListeners();
  }


  var _podcastObject;

  get podcastObject => _podcastObject;

  getPalette()async{
     await updatePaletteGenerator(_podcastObject['podcast']['image']).then((value) {
       _paletteGenerator = value;
       _isBlack = calculateTextColor(value.dominantColor!.color) == Colors.black ? true : false;
     });
  }



  set podcastObject(var newValue) {
    _podcastObject = newValue;
    _episodeList = getEpisodes(_podcastObject['podcast']['id']);
    getPalette();
    notifyListeners();
  }

  bool _isBlack = false;

  bool get isBlack => _isBlack;

  set isBlack(bool newValue){
    _isBlack = newValue;

    notifyListeners();
  }

  var _episodeList;

  get episodeList => _episodeList;

  set episodeList(var newValue){
    _episodeList = newValue;

    notifyListeners();
  }

  PaletteGenerator? _paletteGenerator;

  PaletteGenerator? get paletteGenerator => _paletteGenerator;

  set paletteGenerator(newValue){
    _paletteGenerator = newValue;

    notifyListeners();
  }


  final AssetsAudioPlayer player = AssetsAudioPlayer.withId("0");



}