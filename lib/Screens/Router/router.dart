import 'package:aurealembed/Screens/EpisodeEmbed/episode_embed.dart';
import 'package:aurealembed/Screens/Home/HomePage.dart';
import 'package:aurealembed/Screens/PodcastEmbed/podcast_embed.dart';
import 'package:aurealembed/Screens/Router/route_names.dart';
import 'package:aurealembed/Services/podcast_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  // print("${settings.name?.split(" / ")[0]} ${settings.name?.split(" / ")[1]} ${settings.name?.split(" / ")[2]}");
 // print(settings.name);
  switch (settings.name?.split("/")[1]) {
    case homeRoute:
      return _getPageRoute(Homepage(), settings);
    case episode:
      print(settings.name!.split("/").toList());
      try{
        return _getPageRoute(EpisodeWidget(episodeId: int.parse(settings.name!.split("/")[2])), settings);
      }catch(e){
        return _getPageRoute(Homepage(), settings);
      }
    case podcast:
      try{
        return _getPageRoute(PodcastWidget(podcast_id: int.parse(settings.name!.split("/")[2])), settings);
      }catch(e){
        return _getPageRoute(Homepage(), settings);
      }

    default:
      try{
        return _getPageRoute(EpisodeWidget(episodeId: int.parse(settings.name!.split("/")[1])), settings);
      }catch(e){
        return _getPageRoute(Homepage(), settings);
      }

  }
}


PageRoute _getPageRoute(Widget child, RouteSettings settings) {
  return _FadeRoute(child: child, routeName: settings.name ?? homeRoute);
}

class _FadeRoute extends PageRouteBuilder {
  final Widget child;
  final String routeName;
  _FadeRoute({required this.child, required this.routeName})
      : super(
    settings: RouteSettings(name: routeName),
    pageBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        ) =>
    child,
    transitionsBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        Widget child,
        ) =>
        FadeTransition(
          opacity: animation,
          child: child,
        ),
  );
}