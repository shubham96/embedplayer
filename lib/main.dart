import 'package:aurealembed/Screens/EpisodeEmbed/episode_embed.dart';
import 'package:aurealembed/Screens/Home/HomePage.dart';
import 'package:aurealembed/Screens/PodcastEmbed/podcast_embed_desktop.dart';
import 'package:aurealembed/Screens/Router/route_names.dart';
import 'package:aurealembed/Screens/Router/router.dart';
import 'package:aurealembed/Services/podcast_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:url_strategy/url_strategy.dart';

import 'Screens/PodcastEmbed/podcast_embed.dart';
import 'Services/episode_provider.dart';

Future<void> main() async {
  setPathUrlStrategy();
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
      create: (context) => EpisodeProvider(),
      child: ChangeNotifierProvider(
        create: (context) => PodcastProvider(),
        child: MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,

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
            fontFamily: "Metropolis"
          ),
          // home: const EpisodeWidget(),
        ),
      ),
    );

  }
}

