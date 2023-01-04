import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';

Future<PaletteGenerator> updatePaletteGenerator (String url )async
{
  var paletteGenerator = await PaletteGenerator.fromImageProvider(Image.network(url, cacheWidth: 100,).image);
  return paletteGenerator;
}