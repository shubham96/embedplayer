import 'dart:ui';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:aurealembed/Screens/PodcastEmbed/episode_card.dart';
import 'package:aurealembed/Screens/PodcastEmbed/podcast_embed_tablet.dart';
import 'package:aurealembed/Services/podcast_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:linkable/linkable.dart';
import 'package:provider/provider.dart';
import 'package:html/parser.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:url_launcher/url_launcher_string.dart';

class PodcastEmbedMobile extends StatelessWidget {
  PodcastEmbedMobile({Key? key}) : super(key: key);

  RegExp htmlMatch = RegExp(r'(\w+)');

  @override
  Widget build(BuildContext context) {
    try{
      return Consumer<PodcastProvider>(builder: (BuildContext context, value, Widget? child) {
        if(value != null){
          return Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [value.paletteGenerator!.dominantColor!.color, const Color(0xff191919)], begin: Alignment.topCenter, end: Alignment.bottomCenter)
            ),
            child: Column(
              children: [
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: AspectRatio(
                            aspectRatio: 1,
                            child: Container(
                              width: MediaQuery.of(context).size.width / 5,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: FadeInImage(
                                  placeholder: const AssetImage('assets/images/placeholder.png'),
                                  image: Image.network(
                                    value.podcastObject['podcast']['image'],
                                    cacheWidth: 100,
                                    gaplessPlayback: true,
                                  ).image,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 30,),
                        Expanded(flex: 3, child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text("${value.podcastObject["podcast"]["name"]}", style: TextStyle(fontSize: 20, color: value.isBlack == true ? Colors.black : Colors.white, fontWeight: FontWeight.bold),),
                            Text("${value.podcastObject['podcast']['author']}", style: TextStyle(fontWeight: FontWeight.w400, fontSize: 15, color: value.isBlack == true ? Colors.black : Colors.white),),
                            const SizedBox(height: 20,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                GestureDetector(
                                  onTap: ()async{
                                    await launchUrlString("https://aureal.one/podcast/${value.podcastObject['id']}");
                                  },
                                  child: Container(decoration: BoxDecoration( border: Border.all(color: value.isBlack == true ? Colors.black : Colors.white)),child:  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                                    child: Text("Follow", style: TextStyle(color: value.isBlack == true ? Colors.black : Colors.white, fontSize: 15),),
                                  )),
                                ),
                                IconButton(onPressed: (){
                                  showModalBottomSheet(backgroundColor: Colors.black.withOpacity(0.7),context: context, builder: (context){
                                    return ClipRRect(
                                      child: BackdropFilter(
                                          filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                                          child: ScreenTypeLayout(mobile: BottomSheetMobile(url: "https://aureal.one/podcast/${value.podcastObject['id']}",), tablet: BottomSheetTablet(url: "https://aureal.one/podcast/${value.podcastObject['id']}"), desktop: BottomSheetDesktop(url: "https://aureal.one/podcast/${value.podcastObject['id']}"),)
                                      ),
                                    );
                                  },);
                                }, icon: Icon(Icons.more_vert_rounded, color: value.isBlack == true ? Colors.black : Colors.white))
                              ],
                            ),
                            // PlayBackOptions(),
                            const SizedBox(height: 20,),
                          ],
                        ), ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20,),
                Expanded(flex: 1,child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xff191919).withOpacity(0.7),
                    // gradient: LinearGradient(
                    //   colors: [value.paletteGenerator!.dominantColor!.color.withOpacity(0.7), const Color(0xff191919)], begin: Alignment.topCenter, end: Alignment.center
                    // )
                  ),
                  child: FutureBuilder(future: value.episodeList,builder: (context, snapshot){
                    if(snapshot.hasData){
                      return ListView.builder(itemBuilder: (context, int index){
                        // var currentIndex = index;
                        // bool isActive = (value.episodeList as List).indexOf(value.currentlyPlaying) == index;
                        return EpisodeCard(index: index, snapshot: snapshot,);

                      }, itemCount: (snapshot.data as List).length, shrinkWrap: true,);
                    }else{
                      return Container(); //TODO: Create a skeleton for loading
                    }

                  },),
                )),
                FutureBuilder(future: value.episodeList,builder: (context, snapshot){
                  if(snapshot.hasData){
                    return PlayBackOptions(episodeList: snapshot.data,);
                  }else{
                    return ListTile(title: Text(""),);
                  }
                })
              ],
            ),
          );
        }else{
          return const CircularProgressIndicator();
        }

      });
    }catch(e){
      return const CircularProgressIndicator();
    }

  }
}
