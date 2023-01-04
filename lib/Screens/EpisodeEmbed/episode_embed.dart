import 'package:aurealembed/Screens/EpisodeEmbed/episode_embed_desktop.dart';
import 'package:aurealembed/Screens/EpisodeEmbed/episode_embed_mobile.dart';
import 'package:aurealembed/Screens/EpisodeEmbed/episode_embed_tablet.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:responsive_builder/responsive_builder.dart';

class EpisodeWidget extends StatelessWidget {
  const EpisodeWidget({Key? key}) : super(key: key);




  Future getEpisodeData() async {

    //Change the episode Id from dynamic url navigation (Advance navigation module from filled stack)
    String url = "https://api.aureal.one/public/episode?episode_id=2081482";

    Dio dio = Dio();  //http object to enable requests
    CancelToken cancel = CancelToken(); //Token to cancel in case of navigation

    try{
      Response response = await dio.get(url, cancelToken: cancel);
      if(response.statusCode == 200){
        // print(response.data);
        return response.data;
      }else{
        print(response.statusCode);
      }

    }catch(e){
      print(e);
    }




  }


  @override
  Widget build(BuildContext context) {
    return FutureBuilder(future: getEpisodeData(),builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) { return ScreenTypeLayout(mobile: EpisodeEmbedMobile(episodeObject: snapshot.data,), tablet: EpisodeEmbedTablet(episodeObject: snapshot.data,), desktop:  EpisodeEmbedDesktop(episodeObject: snapshot.data,),); },
    );
  }
}
