import 'dart:ui';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:aurealembed/Services/podcast_provider.dart';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:linkable/linkable.dart';
import 'package:provider/provider.dart';
import 'package:html/parser.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:url_launcher/url_launcher_string.dart';


class EpisodeCard extends StatelessWidget {

  final int index;
  final AsyncSnapshot snapshot;

  EpisodeCard({Key? key, required this.index, required this.snapshot}) : super(key: key);

  RegExp htmlMatch = RegExp(r'(\w+)');

  @override
  Widget build(BuildContext context) {
    return Consumer<PodcastProvider>(builder: (BuildContext context, value, Widget? child){
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: ListTile(
            // TODO: add color when the element is playing
            onTap: (){
              value.player.open(Audio.network((snapshot.data as List)[index]['url'], metas: Metas(title: (snapshot.data as List)[index]['name'], artist: (snapshot.data as List)[index]['author'], album: (snapshot.data as List)[index]['podcast_name'], image: MetasImage.network((snapshot.data as List)[index]['image'] ?? (snapshot.data as List)[index]['podcast_image']))),);
            },
            leading: SizedBox(
              height: double.infinity,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: FadeInImage(
                  placeholder: const AssetImage('assets/images/placeholder.png'),
                  image: Image.network(
                    (snapshot.data as List)[index]['image'] ?? value.podcastObject['podcast']['image'],
                    cacheWidth: 100,
                    gaplessPlayback: true,
                  ).image,
                ),
              ),
            ),

            title: Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Text("${(snapshot.data as List)[index]['name']}", style: TextStyle(color: value.isBlack == true ? Colors.black : Colors.white, fontWeight: FontWeight.bold),),
            ),

            subtitle: (snapshot.data as List)[index]['summary'] == null? const Text("") :htmlMatch.hasMatch(
                "${(snapshot.data as List)[index]['summary']}") ? Linkable(text: parse((snapshot.data as List)[index]['summary'])
                            .body!
                            .text,textColor: value.isBlack == true ? Colors.black : Colors.white,maxLines: 2,style: TextStyle(color: value.isBlack == true ? Colors.black : Colors.white, fontWeight: FontWeight.w200),) : Text("${(snapshot.data as List)[index]['summary']}", maxLines: 2, overflow: TextOverflow.ellipsis,style: TextStyle(color: value.isBlack == true ? Colors.black : Colors.white)),
            trailing: IconButton(icon: Icon(Icons.more_vert_rounded, color: value.isBlack == true ? Colors.black : Colors.white,), onPressed: () {
      showModalBottomSheet(backgroundColor: Colors.black.withOpacity(0.7),context: context, builder: (context){
      return ClipRRect(
      child: BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
      child: ScreenTypeLayout(mobile: BottomSheetMobile(url: "https://aureal.one/episode/${(snapshot.data as List)[index]['id']}",), tablet: BottomSheetTablet(url: "https://aureal.one/episode/${(snapshot.data as List)[index]['id']}"), desktop: BottomSheetDesktop(url: "https://aureal.one/episode/${(snapshot.data as List)[index]['id']}"),)
      ),
      );
      },);
      }),
        ),
      ));
    });
  }
}

class BottomSheetMobile extends StatelessWidget {

  final String url;

  BottomSheetMobile({Key? key, required this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: [
          Expanded(flex: 1, child: SizedBox(),),
      Expanded(flex: 2,child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children:  [
          Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),border: Border.all(color: Colors.white)), child: ListTile(onTap: () async{
            await launchUrlString(url);
          }
          ,leading: Icon(Icons.play_circle_fill, color: Colors.white,),title: Text("Play on Aureal", style: TextStyle(color: Colors.white),),)),
          Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),border: Border.all(color: Colors.white)),child: ListTile(onTap: () {
            FlutterClipboard.controlC(url);
          },leading: Icon(Icons.link, color: Colors.white,),title: Text("Copy Link", style: TextStyle(color: Colors.white)),)),
          Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),border: Border.all(color: Colors.white)),child: ListTile(onTap: () async{
            await launchUrlString(url);
          },leading: Icon(Icons.person_add, color: Colors.white,),title: Text("Follow on Aureal", style: TextStyle(color: Colors.white)),))
        ],
      )),
          Expanded(flex: 1,child: SizedBox())
        ],
      ),
    );
  }
}

class BottomSheetDesktop extends StatelessWidget {

  final String url;

  BottomSheetDesktop({Key? key,required this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: [
          Expanded(flex: 1, child: const SizedBox(),),
          Expanded(flex: 1,child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children:  [
              Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),border: Border.all(color: Colors.white)), child: ListTile(onTap: () async{
                await launchUrlString(url);
              }
                ,leading: Icon(Icons.play_circle_fill, color: Colors.white,),title: Text("Play on Aureal", style: TextStyle(color: Colors.white),),)),
              Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),border: Border.all(color: Colors.white)),child: ListTile(onTap: () {
                FlutterClipboard.controlC(url);
              },leading: Icon(Icons.link, color: Colors.white,),title: Text("Copy Link", style: TextStyle(color: Colors.white)),)),
              Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),border: Border.all(color: Colors.white)),child: ListTile(onTap: () async{
                await launchUrlString(url);
              },leading: Icon(Icons.person_add, color: Colors.white,),title: Text("Follow on Aureal", style: TextStyle(color: Colors.white)),))
            ],
          )),
          Expanded(flex: 1,child: const SizedBox())
        ],
      ),
    );
  }
}

class BottomSheetTablet extends StatelessWidget {

  final String url;

  BottomSheetTablet({Key? key,required this.url}) : super(key: key);



  @override
  Widget build(BuildContext context) {

    return Container(
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: [
          Expanded(flex: 1, child: SizedBox(),),
          Expanded(flex: 1,child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children:  [
              Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),border: Border.all(color: Colors.white)), child: ListTile(onTap: () async{
                await launchUrlString(url);
              }
                ,leading: Icon(Icons.play_circle_fill, color: Colors.white,),title: Text("Play on Aureal", style: const TextStyle(color: Colors.white),),)),
              Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),border: Border.all(color: Colors.white)),child: ListTile(onTap: () {
                FlutterClipboard.controlC(url);
              },leading: Icon(Icons.link, color: Colors.white,),title: Text("Copy Link", style: TextStyle(color: Colors.white)),)),
              Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),border: Border.all(color: Colors.white)),child: ListTile(onTap: () async{
                await launchUrlString(url);
              },leading: Icon(Icons.person_add, color: Colors.white,),title: Text("Follow on Aureal", style: TextStyle(color: Colors.white)),))],
          )),
          Expanded(flex: 1,child: SizedBox())
        ],
      ),
    );
  }
}



