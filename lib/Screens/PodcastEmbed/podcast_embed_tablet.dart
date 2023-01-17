import 'dart:ui';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:aurealembed/Screens/EpisodeEmbed/episode_embed_desktop.dart';
import 'package:aurealembed/Screens/PodcastEmbed/episode_card.dart';
import 'package:aurealembed/Services/podcast_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:url_launcher/url_launcher_string.dart';

class PodcastEmbedTablet extends StatelessWidget {
  PodcastEmbedTablet({Key? key}) : super(key: key);


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
                            Text("${value.podcastObject["podcast"]["name"]}", style: TextStyle(fontSize: 40, color: value.isBlack == true ? Colors.black : Colors.white, fontWeight: FontWeight.w800),),
                            Text("${value.podcastObject['podcast']['author']}", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20, color: value.isBlack == true ? Colors.black : Colors.white),),
                            const SizedBox(height: 20,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                GestureDetector(
                                  onTap: ()async{
                                    await launchUrlString("https://aureal.one/podcast/${value.podcastObject['id']}");
                                  },
                                  child: Container(decoration: BoxDecoration( border: Border.all(color: value.isBlack == true ? Colors.black : Colors.white)),child: Padding(
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
                                }, icon: Icon(Icons.more_vert_rounded, color: value.isBlack == true ? Colors.black : Colors.white,))
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
                Expanded(flex: 2,child: Container(
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
                        try{
                          return EpisodeCard(index: index, snapshot: snapshot,);
                        }catch(e){
                          return Container();
                        }
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
      return CircularProgressIndicator();
    }

  }
}


class PlayBackOptions extends StatefulWidget {

  final episodeList;

  const PlayBackOptions({Key? key, this.episodeList}) : super(key: key);

  @override
  State<PlayBackOptions> createState() => _PlayBackOptionsState();
}

class _PlayBackOptionsState extends State<PlayBackOptions> {
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var provider = Provider.of<PodcastProvider>(context, listen: false);
    provider.player.open(Audio.network((widget.episodeList as List)[0]['url'], metas: Metas(title: (widget.episodeList as List)[0]['name'], artist: (widget.episodeList as List)[0]['author'], album: (widget.episodeList as List)[0]['podcast_name'], image: MetasImage.network((widget.episodeList as List)[0]['image'] ?? (widget.episodeList as List)[0]['podcast_image'])),), autoStart: false).then((value) {
      provider.currentlyPlaying = (widget.episodeList as List)[0];
      provider.currentIndex = 0;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    var podcastProvider = Provider.of<PodcastProvider>(context);
    return podcastProvider.player.builderRealtimePlayingInfos(builder: (context, infos){
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: PositionSeekWidget(currentPosition: infos.currentPosition, duration: infos.duration, seekTo: (to) {
              podcastProvider.player.seek(to);
            },),
          ),
          ListTile(
            leading: SizedBox(
              height: double.infinity,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: FadeInImage(
                  placeholder: const AssetImage('assets/images/placeholder.png'),
                  image: Image.network(
                    infos.current!.audio.audio.metas.image!.path,
                    cacheWidth: 100,
                    gaplessPlayback: true,
                  ).image,
                ),
              ),
            ),
            horizontalTitleGap: 10,
            title: Text("${infos.current?.audio.audio.metas.title}", maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(fontWeight: FontWeight.bold,color: podcastProvider.isBlack == true ? Colors.black : Colors.white),),
            subtitle: Text("${infos.current?.audio.duration.toString().split(".")[0]}", style: TextStyle(color: podcastProvider.isBlack == true ? Colors.black : Colors.white),),
            trailing: Row(mainAxisSize: MainAxisSize.min,children: [IconButton(onPressed: ()async{
              if(podcastProvider.currentIndex != 0){
                print("Coming here");
                await podcastProvider.player.open(Audio.network((widget.episodeList as List)[podcastProvider.currentIndex -1]['url'], metas: Metas(title: (widget.episodeList as List)[podcastProvider.currentIndex -1]['name'], artist: (widget.episodeList as List)[podcastProvider.currentIndex -1]['author'], album: (widget.episodeList as List)[podcastProvider.currentIndex -1]['podcast_name'], image: MetasImage.network((widget.episodeList as List)[podcastProvider.currentIndex -1]['image'] ?? (widget.episodeList as List)[podcastProvider.currentIndex -1]['podcast_image'])),), autoStart: true).then((value) {
                  podcastProvider.currentlyPlaying = (widget.episodeList as List)[podcastProvider.currentIndex -1];
                  podcastProvider.currentIndex = podcastProvider.currentIndex -1;
                });
              }
            }, icon:  Icon(Icons.skip_previous, color: podcastProvider.isBlack == true ? Colors.black : Colors.white,)),


              infos.isPlaying ? IconButton(onPressed: () => podcastProvider.player.pause(), icon: Icon(Icons.pause_circle_filled, size: 25,color: podcastProvider.isBlack == true ? Colors.black : Colors.white,)) : IconButton(onPressed: () => podcastProvider.player.play(), icon: Icon(Icons.play_circle_fill,size: 25 ,color: podcastProvider.isBlack == true ? Colors.black : Colors.white,)),


              IconButton(onPressed: (){
              print("coming here");
              if(podcastProvider.currentIndex != (widget.episodeList as List).length - 1){
                print("Coming here too");
                podcastProvider.player.open(Audio.network((widget.episodeList as List)[podcastProvider.currentIndex + 1]['url'], metas: Metas(title: (widget.episodeList as List)[podcastProvider.currentIndex + 1]['name'], artist: (widget.episodeList as List)[podcastProvider.currentIndex + 1]['author'], album: (widget.episodeList as List)[podcastProvider.currentIndex + 1]['podcast_name'], image: MetasImage.network((widget.episodeList as List)[podcastProvider.currentIndex + 1]['image'] ?? (widget.episodeList as List)[podcastProvider.currentIndex + 1]['podcast_image'])),), autoStart: true).then((value) async{
                  podcastProvider.currentlyPlaying = (widget.episodeList as List)[podcastProvider.currentIndex + 1];
                  podcastProvider.currentIndex = podcastProvider.currentIndex + 1;
                });
              }
            }, icon: Icon(Icons.skip_next, color: podcastProvider.isBlack == true ? Colors.black : Colors.white,)),
            ],),
          ),
        ],
      );
    });
    // return ListTile(
    //   leading: podcastProvider.player.builderRealtimePlayingInfos(builder: (context, infos){
    //     if(infos.isPlaying){
    //       return IconButton(onPressed: () => podcastProvider.player.pause(), icon: Icon(FontAwesomeIcons.circlePause, color: podcastProvider.isBlack == true ? Colors.black : Colors.white,));
    //     }else{
    //       return IconButton(onPressed: () => podcastProvider.player.play(), icon: Icon(FontAwesomeIcons.circlePlay, color: podcastProvider.isBlack == true ? Colors.black : Colors.white,));
    //     }
    //   }),
    //
    //
    // );
  }
}

