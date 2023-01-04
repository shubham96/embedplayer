import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:aurealembed/Services/palette_generator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:palette_generator/palette_generator.dart';

import 'episode_embed_desktop.dart';

class EpisodeEmbedMobile extends StatelessWidget {

  final episodeObject;

  const EpisodeEmbedMobile({Key? key, this.episodeObject}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder<PaletteGenerator>(
          future: updatePaletteGenerator(episodeObject['episode']['image']?? episodeObject['episode']['podcast_image']), // async work
          builder: (BuildContext context, AsyncSnapshot<PaletteGenerator> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting: return const Center(child:CircularProgressIndicator());
              default:
                if (snapshot.hasError){
                  return Text('Error: ${snapshot.error}');
                }

                else {
                  return Container(

                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: snapshot.data?.dominantColor?.color,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: AspectRatio(
                        aspectRatio: 1/2,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(decoration: const BoxDecoration(color: Color(0xff191919), shape: BoxShape.circle),child: Image.asset("assets/images/Favicon.png", width: 30,)),
                              ],
                            ),
                            Expanded(
                              flex: 1,
                              child: AspectRatio(
                                aspectRatio: 1.0,
                                child: Container(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: FadeInImage(
                                      placeholder: const AssetImage('assets/placeholder.gif'),
                                      image: Image.network(
                                        episodeObject['episode']['image'] ?? episodeObject['episode']['podcast_image'],
                                        gaplessPlayback: true,
                                      ).image,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [

                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(crossAxisAlignment: CrossAxisAlignment.start,mainAxisSize: MainAxisSize.min, children: [Text("${episodeObject['episode']['name']}", style: TextStyle(
                                          fontSize: 20, color: snapshot.data?.dominantColor?.titleTextColor
                                      ),),
                                        const SizedBox(height: 10,),
                                        Text("${episodeObject['episode']['podcast_name']}", style: TextStyle(fontSize: 12, color: snapshot.data?.dominantColor?.bodyTextColor),),const SizedBox(height: 10,),
                                        Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(3),border: Border.all(color: Colors.white)), child: Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 10),
                                          child: Text("Follow", style: TextStyle(color: snapshot.data?.dominantColor?.titleTextColor, fontSize: 15),),
                                        ),)
                                      ],),
                                    ),
                                    PlaybackButtons(episodeObject: episodeObject, textColor: snapshot.data?.dominantColor?.titleTextColor ?? Colors.black),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                }}},),
      ),

    );
  }
}

class PlaybackMobile extends StatefulWidget {

  final episodeObject;

  final Color textColor;

  const PlaybackMobile({Key? key, required this.episodeObject, required this.textColor}) : super(key: key);

  @override
  State<PlaybackMobile> createState() => _PlaybackMobileState();
}

class _PlaybackMobileState extends State<PlaybackMobile> {

  late final AssetsAudioPlayer player;

  @override
  void initState() {
    // TODO: implement initState
    player = AssetsAudioPlayer.withId("0");
    openPlayer();

    super.initState();
  }

  void openPlayer() async {
    await player.open(Audio.network(widget.episodeObject['episode']['url']), autoStart: false);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        IconButton(onPressed: (){

        }, icon: const Icon(Icons.fast_rewind_rounded, color: Colors.white,)),
        // player.builderRealtimePlayingInfos(builder: (context, infos){
        //   return Expanded(
        //     child: PositionSeekWidget(
        //       currentPosition: infos.currentPosition,
        //       duration: infos.duration,
        //       seekTo: (to) {
        //         player.seek(to);
        //       },
        //     ),
        //   );
        // }),
        IconButton(onPressed: (){

        }, icon: const Icon(Icons.fast_forward_rounded, color: Colors.white,)),
        IconButton(onPressed: (){

        }, icon: const Icon(Icons.more_horiz_rounded, color: Colors.white,)),
        player.builderRealtimePlayingInfos(builder: (context, infos){
          // widget.player.open(Audio.network(widget.episodeObject['episode']['url']));
          if(infos.isPlaying){
            return IconButton(onPressed: (){
              player.pause();
            },icon: const Icon(FontAwesomeIcons.circlePause, color: Colors.white,),);
          }else{
            return IconButton(onPressed: (){
              player.play();
            }, icon: const Icon(FontAwesomeIcons.circlePlay, color: Colors.white,));
          }
        }),

      ],
    );
  }
}

