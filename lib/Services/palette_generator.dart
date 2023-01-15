import 'package:aurealembed/Services/podcast_provider.dart';
import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:provider/provider.dart';

Future<PaletteGenerator> updatePaletteGenerator (String url )async
{
  var paletteGenerator = await PaletteGenerator.fromImageProvider(Image.network(url, cacheWidth: 100,).image);

  return paletteGenerator;
}

Color calculateTextColor(Color background) {
  return background.computeLuminance() >= 0.5 ? Colors.black : Colors.white;
}