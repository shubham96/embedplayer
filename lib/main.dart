import 'package:aurealembed/Screens/EpisodeEmbed/episode_embed.dart';
import 'package:aurealembed/Screens/Home/HomePage.dart';
import 'package:aurealembed/Screens/PodcastEmbed/podcast_embed_desktop.dart';
import 'package:aurealembed/Screens/Router/route_names.dart';
import 'package:aurealembed/Screens/Router/router.dart';
import 'package:aurealembed/Services/podcast_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import 'Screens/PodcastEmbed/podcast_embed.dart';

Future<void> main() async {
  await SentryFlutter.init(
        (options) {
      options.dsn = 'https://0fcf5ad9c4334ce2aa4cc4afc61a535d@o4504508313698304.ingest.sentry.io/4504508314681345';
      options.tracesSampleRate = 1.0;
    },
    appRunner: () => runApp(MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => PodcastProvider(),
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        // initialRoute: homeRoute,
        // routes: {
        //   homeRoute : (context) => Homepage(),
        //   episode: (context) => EpisodeWidget(episodeId: 2081482,),
        //   podcast: (context) => PodcastWidget(),
        // },
        onGenerateRoute: generateRoute,

        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.blue,
        ),
        // home: const EpisodeWidget(),
      ),
    );

  }
}

class EmbedPlayer extends StatefulWidget {
  const EmbedPlayer({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<EmbedPlayer> createState() => _EmbedPlayerState();
}

class _EmbedPlayerState extends State<EmbedPlayer> {


  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 500,
      decoration: const BoxDecoration(
        color: Colors.grey
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(),
            Row(),
          ],
        ),
      ),
    );
  }
}
