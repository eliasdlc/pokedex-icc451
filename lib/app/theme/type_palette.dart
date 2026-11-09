import 'package:flutter/material.dart';

const _typeColors = <String, Color>{
  'water': Color(0xFF5090D5),
  'dragon': Color(0xFF0B6DC3),
  'electric': Color(0xFFF5D23D),
  'fairy': Color(0xFFEB8FE7),
  'ghost': Color(0xFF5269AD),
  'fire': Color(0xFFFF9D55),
  'ice': Color(0xFF73CEBF),
  'grass': Color(0xFF63BC5A),
  'bug': Color(0xFF90C12F),
  'fighting': Color(0xFFCE416A),
  'normal': Color(0xFF919BA3),
  'dark': Color(0xFF595463),
  'steel': Color(0xFF5B8EA4),
  'rock': Color(0xFFC5B88C),
  'psychic': Color(0xFFFA737A),
  'ground': Color(0xFFD97845),
  'poison': Color(0xFFB667CF),
  'flying': Color(0xFF88AAE3),
};

const _darkInk = Color(0xFF111118);

Color typeColor(String slug) => _typeColors[slug] ?? const Color(0xFF8A8A8A);

Color inkOn(Color background) {
  double contrast(Color a, Color b) {
    final l1 = a.computeLuminance();
    final l2 = b.computeLuminance();
    final hi = l1 > l2 ? l1 : l2;
    final lo = l1 > l2 ? l2 : l1;
    return (hi + 0.05) / (lo + 0.05);
  }

  return contrast(background, _darkInk) >= contrast(background, Colors.white)
      ? _darkInk
      : Colors.white;
}

Color onType(String slug) => inkOn(typeColor(slug));

List<String> get allTypeSlugs => _typeColors.keys.toList(growable: false);
