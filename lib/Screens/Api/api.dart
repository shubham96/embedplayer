


import 'package:aurealembed/Services/podcast_provider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';

Future getEpisodes(int podcastId) async {
  Dio dio  = Dio();
  CancelToken cancel = CancelToken();

  String url = "https://api.aureal.one/public/episode?user_id=9b86a35f25157e68510591b5da29e022&pageSize=5&podcast_id=$podcastId&page=0}";
  if (kDebugMode) {
    print(url);
  }

  try{
    Response response = await dio.get(url, cancelToken: cancel);
    if(response.statusCode == 200){
      PodcastProvider().episodeList = response.data['episodes'];
      return response.data['episodes'];
    }
  }catch(e){
    if (kDebugMode) {
      print(e);
    }
  }

}

  Future getPodcastData({required int podcast_id, required BuildContext context}) async {
  String url = "https://api.aureal.one/public/podcast?podcast_id=$podcast_id";

  // Provider.of<CurrentlyPlaying>(context);

  Dio dio = Dio();
  CancelToken cancel = CancelToken();

  try{
    Response response = await dio.get(url, cancelToken: cancel);
    if(response.statusCode == 200){
      await Provider.of<PodcastProvider>(context, listen: false).getPalette(response.data['podcast']['image']).then((value) {
        Provider.of<PodcastProvider>(context, listen: false).podcastObject = response.data;
      });
      return response.data;
    }else{
      if (kDebugMode) {
        print(response.statusCode);
      }
    }
  }catch(e){
    if (kDebugMode) {
      print(e);
    }
  }
}

