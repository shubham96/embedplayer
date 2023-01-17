
import 'dart:ui';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:aurealembed/Screens/PodcastEmbed/episode_card.dart';
import 'package:aurealembed/Services/episode_provider.dart';
import 'package:aurealembed/Services/palette_generator.dart';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:palette_generator/palette_generator.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:url_launcher/url_launcher_string.dart';

class EpisodeEmbedDesktop extends StatelessWidget {

  final episodeObject;


  EpisodeEmbedDesktop({Key? key, this.episodeObject, }) : super(key: key);

  // AudioPlayer player = AudioPlayer()..setReleaseMode(ReleaseMode.stop);


  RegExp htmlMatch = RegExp(r'(\w+)');

  @override
  Widget build(BuildContext context) {
    // return Padding(
    //   padding: const EdgeInsets.all(8.0),
    //   child: FutureBuilder<PaletteGenerator>(
    //     future: updatePaletteGenerator(episodeObject['episode']['image']?? episodeObject['episode']['podcast_image']), // async work
    //     builder: (BuildContext context, AsyncSnapshot<PaletteGenerator> snapshot) {
    //       switch (snapshot.connectionState) {
    //         case ConnectionState.waiting: return const Center(child:CircularProgressIndicator());
    //         default:
    //           if (snapshot.hasError){
    //             return Text('Error: ${snapshot.error}');
    //           }
    //
    //           else {
    //             return Container(
    //               // width: MediaQuery.of(context).size.width / 2,
    //
    //               decoration: BoxDecoration(
    //                 color: snapshot.data?.dominantColor?.color,
    //                 borderRadius: BorderRadius.circular(20),
    //               ),
    //               child: Padding(
    //                 padding: const EdgeInsets.all(20),
    //                 child: AspectRatio(
    //                   aspectRatio: 3/1,
    //                   child: Row(
    //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                     children: [
    //                       Expanded(
    //                         flex: 1,
    //                         child: AspectRatio(
    //                           aspectRatio: 1.0,
    //                           child: Container(
    //                             child: ClipRRect(
    //                               borderRadius: BorderRadius.circular(10),
    //                               child: FadeInImage(
    //                                 placeholder: const AssetImage('assets/images/placeholder.png'),
    //                                 image: Image.network(
    //                                   episodeObject['episode']['image'] ?? episodeObject['episode']['podcast_image'],
    //                                   gaplessPlayback: true,
    //                                 ).image,
    //                               ),
    //                             ),
    //                           ),
    //                         ),
    //                       ),
    //                       Expanded(
    //                         flex: 2,
    //                         child: Padding(
    //                           padding: const EdgeInsets.only(left: 10),
    //                           child: Column(
    //                             crossAxisAlignment: CrossAxisAlignment.start,
    //                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                             children: [
    //                               Row(
    //                                 mainAxisAlignment: MainAxisAlignment.end,
    //                                 children: [
    //                                   Container(decoration: const BoxDecoration(color: Color(0xff191919), shape: BoxShape.circle),child: Image.asset("assets/images/Favicon.png", width: 30,)),
    //                                 ],
    //                               ),
    //                               Padding(
    //                                 padding: const EdgeInsets.all(8.0),
    //                                 child: Column(crossAxisAlignment: CrossAxisAlignment.start,mainAxisSize: MainAxisSize.min, children: [Text("${episodeObject['episode']['name']}", style: TextStyle(
    //                                     fontSize: 20, color: snapshot.data?.dominantColor?.titleTextColor
    //                                 ),),
    //                                   const SizedBox(height: 10,),
    //                                   Text("${episodeObject['episode']['podcast_name']}", style: TextStyle(fontSize: 10, color: snapshot.data?.dominantColor?.bodyTextColor),),const SizedBox(height: 10,),
    //                                   Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(3),border: Border.all(color: Colors.white)), child: Padding(
    //                                     padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 10),
    //                                     child: Text("Follow", style: TextStyle(color: snapshot.data?.dominantColor?.titleTextColor, fontSize: 10),),
    //                                   ),)
    //                                 ],),
    //                               ),
    //                               PlaybackButtons(episodeObject: episodeObject, textColor: snapshot.data?.dominantColor?.titleTextColor ?? Colors.black),
    //                             ],
    //                           ),
    //                         ),
    //                       )
    //                     ],
    //                   ),
    //                 ),
    //               ),
    //             );
    //           }}},),
    // );

    return Consumer<EpisodeProvider>(builder: (context, value, child){
      return Container(
                        // width: MediaQuery.of(context).size.width / 2,

                        decoration: BoxDecoration(
                          // color: value.paletteGenerator?.dominantColor?.color,
                          gradient: LinearGradient(colors: [value.paletteGenerator!.dominantColor!.color, Color(0xff191919)], begin: Alignment.topLeft, end: Alignment.center),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: AspectRatio(
                            aspectRatio: 3/1,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: GestureDetector(
                                    onTap: () async {
                                      await launchUrlString("https://aureal.one/podcast/${value.currentlyPlaying['episode']['id']}");
                                    },
                                    child: AspectRatio(
                                      aspectRatio: 1.0,
                                      child: Container(
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(10),
                                          child: FadeInImage(
                                            placeholder: const AssetImage('assets/images/placeholder.png'),
                                            image: Image.network(
                                              episodeObject['episode']['image'] ?? episodeObject['episode']['podcast_image'],
                                              gaplessPlayback: true,
                                            ).image,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            GestureDetector(onTap: () async {
                                              await launchUrlString("https://aureal.one");
                                            },child: Container(decoration: const BoxDecoration(color: Color(0xff191919), shape: BoxShape.circle),child: Image.asset("assets/images/Favicon.png", width: 50,))),
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(crossAxisAlignment: CrossAxisAlignment.start,mainAxisSize: MainAxisSize.min, children: [GestureDetector(onTap: ()async{
                                            await launchUrlString("https://aureal.one/episode/${value.currentlyPlaying['episode']['id']}");
                                          },
                                            child: Text("${episodeObject['episode']['name']}", style: TextStyle(
                                                fontWeight: FontWeight.w800,fontSize: 30, color: value.isBlack == true ? Colors.black: Colors.white
                                            ),),
                                          ),
                                            const SizedBox(height: 10,),
                                            GestureDetector(onTap: ()async{
                                              await launchUrlString("https://aureal.one/podcast/${value.currentlyPlaying['episode']['podcast_id']}");
                                            },child: Text("${episodeObject['episode']['podcast_name']}", style: TextStyle(fontSize: 20, color: value.isBlack == true ? Colors.black: Colors.white),)),const SizedBox(height: 10,),
                                            Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(3),border: Border.all(color: Colors.white)), child: Padding(
                                              padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 10),
                                              child: Text("Follow", style: TextStyle(color: value.isBlack == true ? Colors.black: Colors.white, fontSize: 15),),
                                            ),)
                                          ],),
                                        ),
                                        PlaybackButtons(episodeObject: episodeObject, textColor: value.isBlack == true ? Colors.black: Colors.white),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
    },);
  }
}



class PlaybackButtons extends StatefulWidget {

  final episodeObject;

  final Color textColor;

  const PlaybackButtons({Key? key, @required this.episodeObject, required this.textColor}) : super(key: key);

  @override
  State<PlaybackButtons> createState() => _PlaybackButtonsState();
}

class _PlaybackButtonsState extends State<PlaybackButtons> {

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
    var episodeProvider = Provider.of<EpisodeProvider>(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        IconButton(onPressed: (){
player.seek(const Duration(seconds: -15));
        }, icon: const Icon(Icons.fast_rewind_rounded, color: Colors.white,)),
        player.builderRealtimePlayingInfos(builder: (context, infos){
          return Expanded(
            child: PositionSeekWidget(
              currentPosition: infos.currentPosition,
              duration: infos.duration,
              seekTo: (to) {
                player.seek(to);
              },
            ),
          );
        }),
        IconButton(onPressed: (){
          player.seek(const Duration(seconds: 15));
        }, icon: const Icon(Icons.fast_forward_rounded, color: Colors.white,)),
        IconButton(onPressed: (){
          showModalBottomSheet(backgroundColor: Colors.black.withOpacity(0.7),context: context, builder: (context){
            return ClipRRect(
              child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                  child: ScreenTypeLayout(mobile: BottomSheetMobile(url: "https://aureal.one/episode/${episodeProvider.currentlyPlaying['episode']['id']}",), tablet: BottomSheetTablet(url: "https://aureal.one/episode/${episodeProvider.currentlyPlaying['episode']['id']}"), desktop: BottomSheetDesktop(url: "https://aureal.one/episode/${episodeProvider.currentlyPlaying['episode']['id']}"),)
              ),
            );
          },);
        }, icon: const Icon(Icons.more_horiz_rounded, color: Colors.white,)),
        player.builderRealtimePlayingInfos(builder: (context, infos){
          // widget.player.open(Audio.network(widget.episodeObject['episode']['url']));
          if(infos.isPlaying){
            return IconButton(onPressed: (){
              player.pause();
            },icon: const Icon(Icons.pause_circle_filled, size: 30,color: Colors.white,),);
          }else{
            return IconButton(onPressed: (){
              player.play();
            }, icon: const Icon(Icons.play_circle_fill, size: 30, color: Colors.white,));
          }
        }),

      ],
    );
  }
}

class PositionSeekWidget extends StatefulWidget {

  final Duration currentPosition;
  final Duration duration;
  final Function(Duration) seekTo;

  const PositionSeekWidget({Key? key, required this.currentPosition,
    required this.duration,
    required this.seekTo,}) : super(key: key);

  @override
  State<PositionSeekWidget> createState() => _PositionSeekWidgetState();
}

class _PositionSeekWidgetState extends State<PositionSeekWidget> {

  late Duration _visibleValue;
  bool listenOnlyUserInterraction = false;
  double get percent => widget.duration.inMilliseconds == 0
      ? 0
      : _visibleValue.inMilliseconds / widget.duration.inMilliseconds;

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    _visibleValue = widget.currentPosition;
  }

  @override
  void didUpdateWidget(covariant PositionSeekWidget oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    if (!listenOnlyUserInterraction) {
      _visibleValue = widget.currentPosition;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SliderTheme(
      data: SliderTheme.of(context).copyWith(trackHeight: 0.5, thumbColor: Colors.transparent, thumbShape: SliderComponentShape.noThumb, trackShape: CustomTrackShape(), overlayShape: RoundSliderOverlayShape(overlayRadius: 5) ),
      child: Slider(min: 0,
        max: widget.duration.inMilliseconds.toDouble(),
        value: percent * widget.duration.inMilliseconds.toDouble(), onChanged: (newValue) {
            setState(() {
              final to = Duration(milliseconds: newValue.floor());
              _visibleValue = to;
            });
          },onChangeStart: (_) {
          setState(() {
            listenOnlyUserInterraction = true;
          });
        }, onChangeEnd: (newValue) {
          setState(() {
            listenOnlyUserInterraction = false;
            widget.seekTo(_visibleValue);
          });
        },),
    );
  }
}

class SliderCustomTrackShape
    extends RoundedRectSliderTrackShape {
  @override
  Rect getPreferredRect({
    required RenderBox parentBox,
    Offset offset = Offset.zero,
    required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final double? trackHeight = sliderTheme.trackHeight;
    final double trackLeft = offset.dx;
    final double trackTop =
        offset.dy + (parentBox.size.height - trackHeight!) / 2;
    final double trackWidth = parentBox.size.width;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }
}

class CustomTrackShape extends RoundedRectSliderTrackShape {
  @override
  Rect getPreferredRect({
    required RenderBox parentBox,
    Offset offset = Offset.zero,
    required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final double? trackHeight = sliderTheme.trackHeight;
    final double trackLeft = offset.dx;
    final double trackTop = offset.dy + (parentBox.size.height - trackHeight!) / 2;
    final double trackWidth = parentBox.size.width;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }
}



