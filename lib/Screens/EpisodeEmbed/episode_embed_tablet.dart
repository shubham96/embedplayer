import 'package:aurealembed/Services/episode_provider.dart';
import 'package:aurealembed/Services/palette_generator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:provider/provider.dart';

import 'episode_embed_desktop.dart';

class EpisodeEmbedTablet extends StatelessWidget {
  final episodeObject;

  const EpisodeEmbedTablet({Key? key, this.episodeObject}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                            Container(decoration: const BoxDecoration(color: Color(0xff191919), shape: BoxShape.circle),child: Image.asset("assets/images/Favicon.png", width: 30,)),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(crossAxisAlignment: CrossAxisAlignment.start,mainAxisSize: MainAxisSize.min, children: [Text("${episodeObject['episode']['name']}", style: TextStyle(
                              fontSize: 20, color: value.isBlack == true ? Colors.black : Colors.white
                          ),),
                            const SizedBox(height: 10,),
                            Text("${episodeObject['episode']['podcast_name']}", style: TextStyle(fontSize: 15, color: value.isBlack == true ? Colors.black : Colors.white),),const SizedBox(height: 10,),
                            Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(3),border: Border.all(color: Colors.white)), child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 10),
                              child: Text("Follow", style: TextStyle(color: value.isBlack == true ? Colors.black : Colors.white, fontSize: 10),),
                            ),)
                          ],),
                        ),
                        PlaybackButtons(episodeObject: episodeObject, textColor: value.isBlack == true ? Colors.black : Colors.white),
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
