import '../../../../core/database/app_database.dart';
import '../../domain/entities/poke_type.dart';
import '../../domain/entities/pokemon_detail.dart';
import '../../domain/entities/pokemon_summary.dart';
import '../local/pokedex_local_data_source.dart';

// Filas de Drift -> entidades de dominio. Hacia arriba solo suben entidades.

PokeType typeFromRow(PokeTypeRow row) => PokeType(
  id: row.id,
  slug: row.name,
  nameEs: row.nameEs,
  nameEn: row.nameEn,
);

/// Tipo desconocido (la tabla estática aún no llegó): se muestra el id.
PokeType unknownType(int id) =>
    PokeType(id: id, slug: 'unknown', nameEs: 'Tipo $id', nameEn: 'Type $id');

BaseStats statsFromRow(PokemonRow p) => BaseStats(
  hp: p.hp,
  attack: p.attack,
  defense: p.defense,
  specialAttack: p.specialAttack,
  specialDefense: p.specialDefense,
  speed: p.speed,
);

PokemonSummary summaryFromRow(CatalogRow row, Map<int, PokeType> types) {
  final p = row.pokemon;
  return PokemonSummary(
    id: p.id,
    slug: p.name,
    nameEs: p.nameEs,
    nameEn: p.nameEn,
    nameJa: p.nameJa,
    generationId: p.generationId,
    types: [for (final id in row.typeIds) types[id] ?? unknownType(id)],
    stats: statsFromRow(p),
    spriteUrl: p.spriteUrl,
    artworkUrl: p.artworkUrl,
    spriteFile: p.spriteFile,
    artworkFile: p.artworkFile,
    isFavorite: row.isFavorite,
  );
}

DamageClass damageClassFromId(int id) => switch (id) {
  2 => DamageClass.physical,
  3 => DamageClass.special,
  _ => DamageClass.status,
};

/// Arma el árbol a partir de la lista plana "cada especie apunta a su
/// predecesora".
EvolutionNode? buildEvolutionTree(List<EvolutionRow> rows) {
  if (rows.isEmpty) return null;
  final byParent = <int?, List<EvolutionRow>>{};
  for (final r in rows) {
    byParent.putIfAbsent(r.fromSpeciesId, () => []).add(r);
  }
  final ids = {for (final r in rows) r.speciesId};
  final root = rows.firstWhere(
    (r) => r.fromSpeciesId == null || !ids.contains(r.fromSpeciesId),
  );

  EvolutionNode build(EvolutionRow row) => EvolutionNode(
    speciesId: row.speciesId,
    slug: row.name,
    condition: row.fromSpeciesId == null
        ? null
        : EvolutionCondition(
            trigger: row.trigger ?? 'other',
            minLevel: row.minLevel,
            item: row.item,
            minHappiness: row.minHappiness,
            timeOfDay: row.timeOfDay,
          ),
    children: [
      for (final c in byParent[row.speciesId] ?? <EvolutionRow>[]) build(c),
    ],
  );

  return build(root);
}
