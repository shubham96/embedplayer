import 'package:aurealembed/Screens/EpisodeEmbed/episode_embed_desktop.dart';
import 'package:aurealembed/Screens/EpisodeEmbed/episode_embed_mobile.dart';
import 'package:aurealembed/Screens/EpisodeEmbed/episode_embed_tablet.dart';
import 'package:aurealembed/Services/episode_provider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';

class EpisodeWidget extends StatelessWidget {
  static const String id = "/episode";
  int episodeId;

  EpisodeWidget({Key? key, required this.episodeId}) : super(key: key);




  Future getEpisodeData(episodeId, BuildContext context) async {

    //Change the episode Id from dynamic url navigation (Advance navigation module from filled stack)
    String url = "https://api.aureal.one/public/episode?episode_id=$episodeId";

    Dio dio = Dio();  //http object to enable requests
    CancelToken cancel = CancelToken(); //Token to cancel in case of navigation

    try{
      Response response = await dio.get(url, cancelToken: cancel);
      if(response.statusCode == 200){
        // print(response.data);
        await Provider.of<EpisodeProvider>(context, listen:  false).getPalette(response.data['episode']['image'] ?? response.data['episode']['podcast_image']).then((value) {
          Provider.of<EpisodeProvider>(context, listen:  false).currentlyPlaying = response.data;
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


  @override
  Widget build(BuildContext context) {
    return Scaffold(body: FutureBuilder(future: getEpisodeData(episodeId, context),builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
      if(snapshot.hasData){
        return ScreenTypeLayout(mobile: EpisodeEmbedMobile(episodeObject: snapshot.data,), tablet: EpisodeEmbedTablet(episodeObject: snapshot.data,), desktop:  EpisodeEmbedDesktop(episodeObject: snapshot.data,),);
        }else{
        return const CircularProgressIndicator();
      }
    }

    ),);
  }
}
