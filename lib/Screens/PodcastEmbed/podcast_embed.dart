import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:aurealembed/Screens/Api/api.dart';
import 'package:aurealembed/Screens/PodcastEmbed/podcast_embed_desktop.dart';
import 'package:aurealembed/Screens/PodcastEmbed/podcast_embed_mobile.dart';
import 'package:aurealembed/Screens/PodcastEmbed/podcast_embed_tablet.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

class PodcastWidget extends StatelessWidget {



  final int podcast_id;

  PodcastWidget({Key? key, required this.podcast_id}) : super(key: key);

  final AssetsAudioPlayer player = AssetsAudioPlayer.withId("0");

  @override
  Widget build(BuildContext context) {
    try{
      return Scaffold(
        body: FutureBuilder(
          future: getPodcastData(podcast_id: podcast_id, context: context), builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if(snapshot.hasData){
            if (kDebugMode) {
              print(snapshot.data);
            }
            return ScreenTypeLayout(mobile: PodcastEmbedMobile(), tablet: PodcastEmbedTablet(), desktop: PodcastEmbedDesktop(),);
          }else{
            return const CircularProgressIndicator();
          }
        },

        ),
      );
    }catch(e){
      return CircularProgressIndicator();
    }

  }
}
