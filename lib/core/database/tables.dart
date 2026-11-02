import 'package:drift/drift.dart';

@DataClassName('PokemonRow')
@TableIndex(name: 'idx_pokemon_name', columns: {#nameEs, #nameEn})
@TableIndex(name: 'idx_pokemon_generation', columns: {#generationId})
@TableIndex(name: 'idx_pokemon_total', columns: {#statTotal})
@TableIndex(name: 'idx_pokemon_species', columns: {#speciesId})
class Pokemon extends Table {
  IntColumn get id => integer()();
  TextColumn get name => text()();
  TextColumn get nameEs => text()();
  TextColumn get nameEn => text()();
  TextColumn get nameJa => text().nullable()();
  IntColumn get speciesId => integer().nullable()();
  BoolColumn get isDefault => boolean().withDefault(const Constant(true))();
  TextColumn get formNameEs => text().nullable()();
  TextColumn get formNameEn => text().nullable()();
  IntColumn get generationId => integer()();
  IntColumn get evolutionChainId => integer().nullable()();
  IntColumn get hp => integer()();
  IntColumn get attack => integer()();
  IntColumn get defense => integer()();
  IntColumn get specialAttack => integer()();
  IntColumn get specialDefense => integer()();
  IntColumn get speed => integer()();
  IntColumn get statTotal => integer()();
  TextColumn get spriteUrl => text().nullable()();
  TextColumn get artworkUrl => text().nullable()();
  TextColumn get shinyArtworkUrl => text().nullable()();
  TextColumn get spriteFile => text().nullable()();
  TextColumn get artworkFile => text().nullable()();
  BoolColumn get hasDetail => boolean().withDefault(const Constant(false))();
  IntColumn get height => integer().nullable()();
  IntColumn get weight => integer().nullable()();
  TextColumn get flavorEs => text().nullable()();
  TextColumn get flavorEn => text().nullable()();
  TextColumn get eggGroups => text().nullable()();
  IntColumn get captureRate => integer().nullable()();
  BoolColumn get isLegendary => boolean().withDefault(const Constant(false))();
  BoolColumn get isMythical => boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('PokeTypeRow')
class PokeTypes extends Table {
  IntColumn get id => integer()();
  TextColumn get name => text()();
  TextColumn get nameEs => text()();
  TextColumn get nameEn => text()();
  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('PokemonTypeRow')
@TableIndex(name: 'idx_pokemon_types_type', columns: {#typeId})
class PokemonTypes extends Table {
  IntColumn get pokemonId => integer()();
  IntColumn get typeId => integer()();
  IntColumn get slot => integer()();
  @override
  Set<Column> get primaryKey => {pokemonId, slot};
}

@DataClassName('TypeEfficacyRow')
class TypeEfficacy extends Table {
  IntColumn get attackTypeId => integer()();
  IntColumn get targetTypeId => integer()();
  IntColumn get factor => integer()();
  @override
  Set<Column> get primaryKey => {attackTypeId, targetTypeId};
}

@DataClassName('VersionGroupRow')
class VersionGroups extends Table {
  IntColumn get id => integer()();
  TextColumn get name => text()();
  IntColumn get generationId => integer()();
  IntColumn get sortOrder => integer()();
  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('GenerationRow')
class Generations extends Table {
  IntColumn get id => integer()();
  TextColumn get name => text()();
  TextColumn get regionName => text()();
  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('AbilityRow')
class Abilities extends Table {
  IntColumn get id => integer()();
  TextColumn get name => text()();
  TextColumn get nameEs => text()();
  TextColumn get nameEn => text()();
  TextColumn get effectEs => text().nullable()();
  TextColumn get effectEn => text().nullable()();
  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('PokemonAbilityRow')
@TableIndex(name: 'idx_pokemon_abilities_ability', columns: {#abilityId})
class PokemonAbilities extends Table {
  IntColumn get pokemonId => integer()();
  IntColumn get abilityId => integer()();
  BoolColumn get isHidden => boolean()();
  @override
  Set<Column> get primaryKey => {pokemonId, abilityId};
}

@DataClassName('MoveRow')
class Moves extends Table {
  IntColumn get id => integer()();
  TextColumn get name => text()();
  IntColumn get power => integer().nullable()();
  IntColumn get accuracy => integer().nullable()();
  IntColumn get pp => integer().nullable()();
  IntColumn get typeId => integer()();

  /// 1 estado, 2 físico, 3 especial.
  IntColumn get damageClassId => integer()();
  @override
  Set<Column> get primaryKey => {id};
}

/* Qué aprende un Pokémon, en qué versión, por qué método y a qué nivel.
La llave incluye versión y método, porque el mismo movimiento
se aprende distinto en cada juego. */
@DataClassName('PokemonMoveRow')
@TableIndex(
  name: 'idx_pokemon_moves_version',
  columns: {#pokemonId, #versionGroupId},
)
class PokemonMoves extends Table {
  IntColumn get pokemonId => integer()();
  IntColumn get moveId => integer()();
  IntColumn get versionGroupId => integer()();

  /// 1 nivel, 2 huevo, 3 tutor, 4 (MT).
  IntColumn get methodId => integer()();
  IntColumn get level => integer()();
  @override
  Set<Column> get primaryKey => {
    pokemonId,
    moveId,
    versionGroupId,
    methodId,
    level,
  };
}

/* Un nodo de la cadena evolutiva. Cada especie apunta a la que la precede,
lo que permite armar árboles con ramas.*/
@DataClassName('EvolutionRow')
@TableIndex(name: 'idx_evolutions_chain', columns: {#chainId})
class Evolutions extends Table {
  IntColumn get speciesId => integer()();
  IntColumn get chainId => integer()();
  IntColumn get fromSpeciesId => integer().nullable()();
  TextColumn get name => text()();
  TextColumn get trigger => text().nullable()();
  IntColumn get minLevel => integer().nullable()();
  TextColumn get item => text().nullable()();
  IntColumn get minHappiness => integer().nullable()();
  TextColumn get timeOfDay => text().nullable()();
  @override
  Set<Column> get primaryKey => {speciesId};
}

// ---- Datos del usuario que viven solo en local. ----

@DataClassName('FavoriteRow')
class Favorites extends Table {
  IntColumn get pokemonId => integer()();
  DateTimeColumn get addedAt => dateTime()();
  @override
  Set<Column> get primaryKey => {pokemonId};
}

@DataClassName('TriviaScoreRow')
class TriviaScores extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get score => integer()();
  IntColumn get correct => integer()();
  IntColumn get total => integer()();
  IntColumn get bestStreak => integer()();
  IntColumn get durationMs => integer()();
  DateTimeColumn get playedAt => dateTime()();
}

@DataClassName('AchievementRow')
class Achievements extends Table {
  TextColumn get id => text()();
  DateTimeColumn get unlockedAt => dateTime()();
  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('BattleRecordRow')
class BattleRecords extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get playerId => integer()();
  IntColumn get rivalId => integer()();
  BoolColumn get won => boolean()();
  IntColumn get turns => integer()();
  DateTimeColumn get playedAt => dateTime()();
}

// ---- Metadatos de sincronización y ajustes. ----

@DataClassName('SyncMetaRow')
class SyncMeta extends Table {
  TextColumn get resource => text()();
  DateTimeColumn get lastSyncedAt => dateTime().nullable()();
  TextColumn get contentHash => text().nullable()();

  TextColumn get status => text().withDefault(const Constant('ok'))();
  IntColumn get attempts => integer().withDefault(const Constant(0))();
  TextColumn get lastError => text().nullable()();
  @override
  Set<Column> get primaryKey => {resource};
}

@DataClassName('SettingRow')
class AppSettings extends Table {
  TextColumn get key => text()();
  TextColumn get value => text()();
  @override
  Set<Column> get primaryKey => {key};
}
