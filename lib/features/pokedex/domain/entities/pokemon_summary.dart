import 'poke_type.dart';

class BaseStats {
  const BaseStats({
    required this.hp,
    required this.attack,
    required this.defense,
    required this.specialAttack,
    required this.specialDefense,
    required this.speed,
  });

  final int hp;
  final int attack;
  final int defense;
  final int specialAttack;
  final int specialDefense;
  final int speed;

  int get total =>
      hp + attack + defense + specialAttack + specialDefense + speed;

  /// El valor base más alto de la serie principal es 255 (Blissey, HP).
  static const maxBaseStat = 255;

  List<(StatKind, int)> get entries => [
    (StatKind.hp, hp),
    (StatKind.attack, attack),
    (StatKind.defense, defense),
    (StatKind.specialAttack, specialAttack),
    (StatKind.specialDefense, specialDefense),
    (StatKind.speed, speed),
  ];
}

enum StatKind { hp, attack, defense, specialAttack, specialDefense, speed }

/// Lo mínimo para pintar una tarjeta del catálogo.
class PokemonSummary {
  const PokemonSummary({
    required this.id,
    required this.slug,
    required this.nameEs,
    required this.nameEn,
    required this.generationId,
    required this.types,
    required this.stats,
    required this.spriteUrl,
    required this.artworkUrl,
    required this.spriteFile,
    required this.artworkFile,
    required this.isFavorite,
    this.nameJa,
  });

  /// Número nacional de la Pokédex.
  final int id;
  final String slug;
  final String nameEs;
  final String nameEn;

  /// Nombre en japonés (katakana) para la cabecera del detalle; null hasta
  /// que la sincronización lo llena.
  final String? nameJa;
  final int generationId;
  final List<PokeType> types;
  final BaseStats stats;
  final String? spriteUrl;
  final String? artworkUrl;
  final String? spriteFile;
  final String? artworkFile;
  final bool isFavorite;

  String localizedName(String languageCode) =>
      languageCode == 'es' ? nameEs : nameEn;

  String get nationalNumber => '#${id.toString().padLeft(4, '0')}';

  /// Hay alguna imagen guardada en el dispositivo.
  bool get hasLocalImage => spriteFile != null || artworkFile != null;
}
