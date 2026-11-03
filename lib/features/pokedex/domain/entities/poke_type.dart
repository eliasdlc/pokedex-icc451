class PokeType {
  const PokeType({
    required this.id,
    required this.slug,
    required this.nameEs,
    required this.nameEn,
  });

  final int id;
  final String slug;
  final String nameEs;
  final String nameEn;

  String localizedName(String languageCode) =>
      languageCode == 'es' ? nameEs : nameEn;

  @override
  bool operator ==(Object other) => other is PokeType && other.id == id;
  @override
  int get hashCode => id.hashCode;
}

class Generation {
  const Generation({
    required this.id,
    required this.slug,
    required this.region,
  });
  final int id;
  final String slug;
  final String region;

  String get roman => slug.split('-').last.toUpperCase();

  String get regionName => region.isEmpty
      ? region
      : '${region[0].toUpperCase()}${region.substring(1)}';
}

class Ability {
  const Ability({
    required this.id,
    required this.slug,
    required this.nameEs,
    required this.nameEn,
  });
  final int id;
  final String slug;
  final String nameEs;
  final String nameEn;

  String localizedName(String languageCode) =>
      languageCode == 'es' ? nameEs : nameEn;
}
