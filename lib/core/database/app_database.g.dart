// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $PokemonTable extends Pokemon with TableInfo<$PokemonTable, PokemonRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PokemonTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameEsMeta = const VerificationMeta('nameEs');
  @override
  late final GeneratedColumn<String> nameEs = GeneratedColumn<String>(
    'name_es',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameEnMeta = const VerificationMeta('nameEn');
  @override
  late final GeneratedColumn<String> nameEn = GeneratedColumn<String>(
    'name_en',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameJaMeta = const VerificationMeta('nameJa');
  @override
  late final GeneratedColumn<String> nameJa = GeneratedColumn<String>(
    'name_ja',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _speciesIdMeta = const VerificationMeta(
    'speciesId',
  );
  @override
  late final GeneratedColumn<int> speciesId = GeneratedColumn<int>(
    'species_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isDefaultMeta = const VerificationMeta(
    'isDefault',
  );
  @override
  late final GeneratedColumn<bool> isDefault = GeneratedColumn<bool>(
    'is_default',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_default" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _formNameEsMeta = const VerificationMeta(
    'formNameEs',
  );
  @override
  late final GeneratedColumn<String> formNameEs = GeneratedColumn<String>(
    'form_name_es',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _formNameEnMeta = const VerificationMeta(
    'formNameEn',
  );
  @override
  late final GeneratedColumn<String> formNameEn = GeneratedColumn<String>(
    'form_name_en',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _generationIdMeta = const VerificationMeta(
    'generationId',
  );
  @override
  late final GeneratedColumn<int> generationId = GeneratedColumn<int>(
    'generation_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _evolutionChainIdMeta = const VerificationMeta(
    'evolutionChainId',
  );
  @override
  late final GeneratedColumn<int> evolutionChainId = GeneratedColumn<int>(
    'evolution_chain_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _hpMeta = const VerificationMeta('hp');
  @override
  late final GeneratedColumn<int> hp = GeneratedColumn<int>(
    'hp',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _attackMeta = const VerificationMeta('attack');
  @override
  late final GeneratedColumn<int> attack = GeneratedColumn<int>(
    'attack',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _defenseMeta = const VerificationMeta(
    'defense',
  );
  @override
  late final GeneratedColumn<int> defense = GeneratedColumn<int>(
    'defense',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _specialAttackMeta = const VerificationMeta(
    'specialAttack',
  );
  @override
  late final GeneratedColumn<int> specialAttack = GeneratedColumn<int>(
    'special_attack',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _specialDefenseMeta = const VerificationMeta(
    'specialDefense',
  );
  @override
  late final GeneratedColumn<int> specialDefense = GeneratedColumn<int>(
    'special_defense',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _speedMeta = const VerificationMeta('speed');
  @override
  late final GeneratedColumn<int> speed = GeneratedColumn<int>(
    'speed',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _statTotalMeta = const VerificationMeta(
    'statTotal',
  );
  @override
  late final GeneratedColumn<int> statTotal = GeneratedColumn<int>(
    'stat_total',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _spriteUrlMeta = const VerificationMeta(
    'spriteUrl',
  );
  @override
  late final GeneratedColumn<String> spriteUrl = GeneratedColumn<String>(
    'sprite_url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _artworkUrlMeta = const VerificationMeta(
    'artworkUrl',
  );
  @override
  late final GeneratedColumn<String> artworkUrl = GeneratedColumn<String>(
    'artwork_url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _shinyArtworkUrlMeta = const VerificationMeta(
    'shinyArtworkUrl',
  );
  @override
  late final GeneratedColumn<String> shinyArtworkUrl = GeneratedColumn<String>(
    'shiny_artwork_url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _spriteFileMeta = const VerificationMeta(
    'spriteFile',
  );
  @override
  late final GeneratedColumn<String> spriteFile = GeneratedColumn<String>(
    'sprite_file',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _artworkFileMeta = const VerificationMeta(
    'artworkFile',
  );
  @override
  late final GeneratedColumn<String> artworkFile = GeneratedColumn<String>(
    'artwork_file',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _hasDetailMeta = const VerificationMeta(
    'hasDetail',
  );
  @override
  late final GeneratedColumn<bool> hasDetail = GeneratedColumn<bool>(
    'has_detail',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("has_detail" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _heightMeta = const VerificationMeta('height');
  @override
  late final GeneratedColumn<int> height = GeneratedColumn<int>(
    'height',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _weightMeta = const VerificationMeta('weight');
  @override
  late final GeneratedColumn<int> weight = GeneratedColumn<int>(
    'weight',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _flavorEsMeta = const VerificationMeta(
    'flavorEs',
  );
  @override
  late final GeneratedColumn<String> flavorEs = GeneratedColumn<String>(
    'flavor_es',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _flavorEnMeta = const VerificationMeta(
    'flavorEn',
  );
  @override
  late final GeneratedColumn<String> flavorEn = GeneratedColumn<String>(
    'flavor_en',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _eggGroupsMeta = const VerificationMeta(
    'eggGroups',
  );
  @override
  late final GeneratedColumn<String> eggGroups = GeneratedColumn<String>(
    'egg_groups',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _captureRateMeta = const VerificationMeta(
    'captureRate',
  );
  @override
  late final GeneratedColumn<int> captureRate = GeneratedColumn<int>(
    'capture_rate',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isLegendaryMeta = const VerificationMeta(
    'isLegendary',
  );
  @override
  late final GeneratedColumn<bool> isLegendary = GeneratedColumn<bool>(
    'is_legendary',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_legendary" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _isMythicalMeta = const VerificationMeta(
    'isMythical',
  );
  @override
  late final GeneratedColumn<bool> isMythical = GeneratedColumn<bool>(
    'is_mythical',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_mythical" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    nameEs,
    nameEn,
    nameJa,
    speciesId,
    isDefault,
    formNameEs,
    formNameEn,
    generationId,
    evolutionChainId,
    hp,
    attack,
    defense,
    specialAttack,
    specialDefense,
    speed,
    statTotal,
    spriteUrl,
    artworkUrl,
    shinyArtworkUrl,
    spriteFile,
    artworkFile,
    hasDetail,
    height,
    weight,
    flavorEs,
    flavorEn,
    eggGroups,
    captureRate,
    isLegendary,
    isMythical,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'pokemon';
  @override
  VerificationContext validateIntegrity(
    Insertable<PokemonRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('name_es')) {
      context.handle(
        _nameEsMeta,
        nameEs.isAcceptableOrUnknown(data['name_es']!, _nameEsMeta),
      );
    } else if (isInserting) {
      context.missing(_nameEsMeta);
    }
    if (data.containsKey('name_en')) {
      context.handle(
        _nameEnMeta,
        nameEn.isAcceptableOrUnknown(data['name_en']!, _nameEnMeta),
      );
    } else if (isInserting) {
      context.missing(_nameEnMeta);
    }
    if (data.containsKey('name_ja')) {
      context.handle(
        _nameJaMeta,
        nameJa.isAcceptableOrUnknown(data['name_ja']!, _nameJaMeta),
      );
    }
    if (data.containsKey('species_id')) {
      context.handle(
        _speciesIdMeta,
        speciesId.isAcceptableOrUnknown(data['species_id']!, _speciesIdMeta),
      );
    }
    if (data.containsKey('is_default')) {
      context.handle(
        _isDefaultMeta,
        isDefault.isAcceptableOrUnknown(data['is_default']!, _isDefaultMeta),
      );
    }
    if (data.containsKey('form_name_es')) {
      context.handle(
        _formNameEsMeta,
        formNameEs.isAcceptableOrUnknown(
          data['form_name_es']!,
          _formNameEsMeta,
        ),
      );
    }
    if (data.containsKey('form_name_en')) {
      context.handle(
        _formNameEnMeta,
        formNameEn.isAcceptableOrUnknown(
          data['form_name_en']!,
          _formNameEnMeta,
        ),
      );
    }
    if (data.containsKey('generation_id')) {
      context.handle(
        _generationIdMeta,
        generationId.isAcceptableOrUnknown(
          data['generation_id']!,
          _generationIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_generationIdMeta);
    }
    if (data.containsKey('evolution_chain_id')) {
      context.handle(
        _evolutionChainIdMeta,
        evolutionChainId.isAcceptableOrUnknown(
          data['evolution_chain_id']!,
          _evolutionChainIdMeta,
        ),
      );
    }
    if (data.containsKey('hp')) {
      context.handle(_hpMeta, hp.isAcceptableOrUnknown(data['hp']!, _hpMeta));
    } else if (isInserting) {
      context.missing(_hpMeta);
    }
    if (data.containsKey('attack')) {
      context.handle(
        _attackMeta,
        attack.isAcceptableOrUnknown(data['attack']!, _attackMeta),
      );
    } else if (isInserting) {
      context.missing(_attackMeta);
    }
    if (data.containsKey('defense')) {
      context.handle(
        _defenseMeta,
        defense.isAcceptableOrUnknown(data['defense']!, _defenseMeta),
      );
    } else if (isInserting) {
      context.missing(_defenseMeta);
    }
    if (data.containsKey('special_attack')) {
      context.handle(
        _specialAttackMeta,
        specialAttack.isAcceptableOrUnknown(
          data['special_attack']!,
          _specialAttackMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_specialAttackMeta);
    }
    if (data.containsKey('special_defense')) {
      context.handle(
        _specialDefenseMeta,
        specialDefense.isAcceptableOrUnknown(
          data['special_defense']!,
          _specialDefenseMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_specialDefenseMeta);
    }
    if (data.containsKey('speed')) {
      context.handle(
        _speedMeta,
        speed.isAcceptableOrUnknown(data['speed']!, _speedMeta),
      );
    } else if (isInserting) {
      context.missing(_speedMeta);
    }
    if (data.containsKey('stat_total')) {
      context.handle(
        _statTotalMeta,
        statTotal.isAcceptableOrUnknown(data['stat_total']!, _statTotalMeta),
      );
    } else if (isInserting) {
      context.missing(_statTotalMeta);
    }
    if (data.containsKey('sprite_url')) {
      context.handle(
        _spriteUrlMeta,
        spriteUrl.isAcceptableOrUnknown(data['sprite_url']!, _spriteUrlMeta),
      );
    }
    if (data.containsKey('artwork_url')) {
      context.handle(
        _artworkUrlMeta,
        artworkUrl.isAcceptableOrUnknown(data['artwork_url']!, _artworkUrlMeta),
      );
    }
    if (data.containsKey('shiny_artwork_url')) {
      context.handle(
        _shinyArtworkUrlMeta,
        shinyArtworkUrl.isAcceptableOrUnknown(
          data['shiny_artwork_url']!,
          _shinyArtworkUrlMeta,
        ),
      );
    }
    if (data.containsKey('sprite_file')) {
      context.handle(
        _spriteFileMeta,
        spriteFile.isAcceptableOrUnknown(data['sprite_file']!, _spriteFileMeta),
      );
    }
    if (data.containsKey('artwork_file')) {
      context.handle(
        _artworkFileMeta,
        artworkFile.isAcceptableOrUnknown(
          data['artwork_file']!,
          _artworkFileMeta,
        ),
      );
    }
    if (data.containsKey('has_detail')) {
      context.handle(
        _hasDetailMeta,
        hasDetail.isAcceptableOrUnknown(data['has_detail']!, _hasDetailMeta),
      );
    }
    if (data.containsKey('height')) {
      context.handle(
        _heightMeta,
        height.isAcceptableOrUnknown(data['height']!, _heightMeta),
      );
    }
    if (data.containsKey('weight')) {
      context.handle(
        _weightMeta,
        weight.isAcceptableOrUnknown(data['weight']!, _weightMeta),
      );
    }
    if (data.containsKey('flavor_es')) {
      context.handle(
        _flavorEsMeta,
        flavorEs.isAcceptableOrUnknown(data['flavor_es']!, _flavorEsMeta),
      );
    }
    if (data.containsKey('flavor_en')) {
      context.handle(
        _flavorEnMeta,
        flavorEn.isAcceptableOrUnknown(data['flavor_en']!, _flavorEnMeta),
      );
    }
    if (data.containsKey('egg_groups')) {
      context.handle(
        _eggGroupsMeta,
        eggGroups.isAcceptableOrUnknown(data['egg_groups']!, _eggGroupsMeta),
      );
    }
    if (data.containsKey('capture_rate')) {
      context.handle(
        _captureRateMeta,
        captureRate.isAcceptableOrUnknown(
          data['capture_rate']!,
          _captureRateMeta,
        ),
      );
    }
    if (data.containsKey('is_legendary')) {
      context.handle(
        _isLegendaryMeta,
        isLegendary.isAcceptableOrUnknown(
          data['is_legendary']!,
          _isLegendaryMeta,
        ),
      );
    }
    if (data.containsKey('is_mythical')) {
      context.handle(
        _isMythicalMeta,
        isMythical.isAcceptableOrUnknown(data['is_mythical']!, _isMythicalMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PokemonRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PokemonRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      nameEs: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name_es'],
      )!,
      nameEn: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name_en'],
      )!,
      nameJa: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name_ja'],
      ),
      speciesId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}species_id'],
      ),
      isDefault: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_default'],
      )!,
      formNameEs: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}form_name_es'],
      ),
      formNameEn: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}form_name_en'],
      ),
      generationId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}generation_id'],
      )!,
      evolutionChainId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}evolution_chain_id'],
      ),
      hp: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}hp'],
      )!,
      attack: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}attack'],
      )!,
      defense: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}defense'],
      )!,
      specialAttack: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}special_attack'],
      )!,
      specialDefense: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}special_defense'],
      )!,
      speed: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}speed'],
      )!,
      statTotal: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}stat_total'],
      )!,
      spriteUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sprite_url'],
      ),
      artworkUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}artwork_url'],
      ),
      shinyArtworkUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}shiny_artwork_url'],
      ),
      spriteFile: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sprite_file'],
      ),
      artworkFile: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}artwork_file'],
      ),
      hasDetail: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}has_detail'],
      )!,
      height: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}height'],
      ),
      weight: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}weight'],
      ),
      flavorEs: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}flavor_es'],
      ),
      flavorEn: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}flavor_en'],
      ),
      eggGroups: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}egg_groups'],
      ),
      captureRate: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}capture_rate'],
      ),
      isLegendary: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_legendary'],
      )!,
      isMythical: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_mythical'],
      )!,
    );
  }

  @override
  $PokemonTable createAlias(String alias) {
    return $PokemonTable(attachedDatabase, alias);
  }
}

class PokemonRow extends DataClass implements Insertable<PokemonRow> {
  final int id;
  final String name;
  final String nameEs;
  final String nameEn;
  final String? nameJa;
  final int? speciesId;
  final bool isDefault;
  final String? formNameEs;
  final String? formNameEn;
  final int generationId;
  final int? evolutionChainId;
  final int hp;
  final int attack;
  final int defense;
  final int specialAttack;
  final int specialDefense;
  final int speed;
  final int statTotal;
  final String? spriteUrl;
  final String? artworkUrl;
  final String? shinyArtworkUrl;
  final String? spriteFile;
  final String? artworkFile;
  final bool hasDetail;
  final int? height;
  final int? weight;
  final String? flavorEs;
  final String? flavorEn;
  final String? eggGroups;
  final int? captureRate;
  final bool isLegendary;
  final bool isMythical;
  const PokemonRow({
    required this.id,
    required this.name,
    required this.nameEs,
    required this.nameEn,
    this.nameJa,
    this.speciesId,
    required this.isDefault,
    this.formNameEs,
    this.formNameEn,
    required this.generationId,
    this.evolutionChainId,
    required this.hp,
    required this.attack,
    required this.defense,
    required this.specialAttack,
    required this.specialDefense,
    required this.speed,
    required this.statTotal,
    this.spriteUrl,
    this.artworkUrl,
    this.shinyArtworkUrl,
    this.spriteFile,
    this.artworkFile,
    required this.hasDetail,
    this.height,
    this.weight,
    this.flavorEs,
    this.flavorEn,
    this.eggGroups,
    this.captureRate,
    required this.isLegendary,
    required this.isMythical,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['name_es'] = Variable<String>(nameEs);
    map['name_en'] = Variable<String>(nameEn);
    if (!nullToAbsent || nameJa != null) {
      map['name_ja'] = Variable<String>(nameJa);
    }
    if (!nullToAbsent || speciesId != null) {
      map['species_id'] = Variable<int>(speciesId);
    }
    map['is_default'] = Variable<bool>(isDefault);
    if (!nullToAbsent || formNameEs != null) {
      map['form_name_es'] = Variable<String>(formNameEs);
    }
    if (!nullToAbsent || formNameEn != null) {
      map['form_name_en'] = Variable<String>(formNameEn);
    }
    map['generation_id'] = Variable<int>(generationId);
    if (!nullToAbsent || evolutionChainId != null) {
      map['evolution_chain_id'] = Variable<int>(evolutionChainId);
    }
    map['hp'] = Variable<int>(hp);
    map['attack'] = Variable<int>(attack);
    map['defense'] = Variable<int>(defense);
    map['special_attack'] = Variable<int>(specialAttack);
    map['special_defense'] = Variable<int>(specialDefense);
    map['speed'] = Variable<int>(speed);
    map['stat_total'] = Variable<int>(statTotal);
    if (!nullToAbsent || spriteUrl != null) {
      map['sprite_url'] = Variable<String>(spriteUrl);
    }
    if (!nullToAbsent || artworkUrl != null) {
      map['artwork_url'] = Variable<String>(artworkUrl);
    }
    if (!nullToAbsent || shinyArtworkUrl != null) {
      map['shiny_artwork_url'] = Variable<String>(shinyArtworkUrl);
    }
    if (!nullToAbsent || spriteFile != null) {
      map['sprite_file'] = Variable<String>(spriteFile);
    }
    if (!nullToAbsent || artworkFile != null) {
      map['artwork_file'] = Variable<String>(artworkFile);
    }
    map['has_detail'] = Variable<bool>(hasDetail);
    if (!nullToAbsent || height != null) {
      map['height'] = Variable<int>(height);
    }
    if (!nullToAbsent || weight != null) {
      map['weight'] = Variable<int>(weight);
    }
    if (!nullToAbsent || flavorEs != null) {
      map['flavor_es'] = Variable<String>(flavorEs);
    }
    if (!nullToAbsent || flavorEn != null) {
      map['flavor_en'] = Variable<String>(flavorEn);
    }
    if (!nullToAbsent || eggGroups != null) {
      map['egg_groups'] = Variable<String>(eggGroups);
    }
    if (!nullToAbsent || captureRate != null) {
      map['capture_rate'] = Variable<int>(captureRate);
    }
    map['is_legendary'] = Variable<bool>(isLegendary);
    map['is_mythical'] = Variable<bool>(isMythical);
    return map;
  }

  PokemonCompanion toCompanion(bool nullToAbsent) {
    return PokemonCompanion(
      id: Value(id),
      name: Value(name),
      nameEs: Value(nameEs),
      nameEn: Value(nameEn),
      nameJa: nameJa == null && nullToAbsent
          ? const Value.absent()
          : Value(nameJa),
      speciesId: speciesId == null && nullToAbsent
          ? const Value.absent()
          : Value(speciesId),
      isDefault: Value(isDefault),
      formNameEs: formNameEs == null && nullToAbsent
          ? const Value.absent()
          : Value(formNameEs),
      formNameEn: formNameEn == null && nullToAbsent
          ? const Value.absent()
          : Value(formNameEn),
      generationId: Value(generationId),
      evolutionChainId: evolutionChainId == null && nullToAbsent
          ? const Value.absent()
          : Value(evolutionChainId),
      hp: Value(hp),
      attack: Value(attack),
      defense: Value(defense),
      specialAttack: Value(specialAttack),
      specialDefense: Value(specialDefense),
      speed: Value(speed),
      statTotal: Value(statTotal),
      spriteUrl: spriteUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(spriteUrl),
      artworkUrl: artworkUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(artworkUrl),
      shinyArtworkUrl: shinyArtworkUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(shinyArtworkUrl),
      spriteFile: spriteFile == null && nullToAbsent
          ? const Value.absent()
          : Value(spriteFile),
      artworkFile: artworkFile == null && nullToAbsent
          ? const Value.absent()
          : Value(artworkFile),
      hasDetail: Value(hasDetail),
      height: height == null && nullToAbsent
          ? const Value.absent()
          : Value(height),
      weight: weight == null && nullToAbsent
          ? const Value.absent()
          : Value(weight),
      flavorEs: flavorEs == null && nullToAbsent
          ? const Value.absent()
          : Value(flavorEs),
      flavorEn: flavorEn == null && nullToAbsent
          ? const Value.absent()
          : Value(flavorEn),
      eggGroups: eggGroups == null && nullToAbsent
          ? const Value.absent()
          : Value(eggGroups),
      captureRate: captureRate == null && nullToAbsent
          ? const Value.absent()
          : Value(captureRate),
      isLegendary: Value(isLegendary),
      isMythical: Value(isMythical),
    );
  }

  factory PokemonRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PokemonRow(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      nameEs: serializer.fromJson<String>(json['nameEs']),
      nameEn: serializer.fromJson<String>(json['nameEn']),
      nameJa: serializer.fromJson<String?>(json['nameJa']),
      speciesId: serializer.fromJson<int?>(json['speciesId']),
      isDefault: serializer.fromJson<bool>(json['isDefault']),
      formNameEs: serializer.fromJson<String?>(json['formNameEs']),
      formNameEn: serializer.fromJson<String?>(json['formNameEn']),
      generationId: serializer.fromJson<int>(json['generationId']),
      evolutionChainId: serializer.fromJson<int?>(json['evolutionChainId']),
      hp: serializer.fromJson<int>(json['hp']),
      attack: serializer.fromJson<int>(json['attack']),
      defense: serializer.fromJson<int>(json['defense']),
      specialAttack: serializer.fromJson<int>(json['specialAttack']),
      specialDefense: serializer.fromJson<int>(json['specialDefense']),
      speed: serializer.fromJson<int>(json['speed']),
      statTotal: serializer.fromJson<int>(json['statTotal']),
      spriteUrl: serializer.fromJson<String?>(json['spriteUrl']),
      artworkUrl: serializer.fromJson<String?>(json['artworkUrl']),
      shinyArtworkUrl: serializer.fromJson<String?>(json['shinyArtworkUrl']),
      spriteFile: serializer.fromJson<String?>(json['spriteFile']),
      artworkFile: serializer.fromJson<String?>(json['artworkFile']),
      hasDetail: serializer.fromJson<bool>(json['hasDetail']),
      height: serializer.fromJson<int?>(json['height']),
      weight: serializer.fromJson<int?>(json['weight']),
      flavorEs: serializer.fromJson<String?>(json['flavorEs']),
      flavorEn: serializer.fromJson<String?>(json['flavorEn']),
      eggGroups: serializer.fromJson<String?>(json['eggGroups']),
      captureRate: serializer.fromJson<int?>(json['captureRate']),
      isLegendary: serializer.fromJson<bool>(json['isLegendary']),
      isMythical: serializer.fromJson<bool>(json['isMythical']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'nameEs': serializer.toJson<String>(nameEs),
      'nameEn': serializer.toJson<String>(nameEn),
      'nameJa': serializer.toJson<String?>(nameJa),
      'speciesId': serializer.toJson<int?>(speciesId),
      'isDefault': serializer.toJson<bool>(isDefault),
      'formNameEs': serializer.toJson<String?>(formNameEs),
      'formNameEn': serializer.toJson<String?>(formNameEn),
      'generationId': serializer.toJson<int>(generationId),
      'evolutionChainId': serializer.toJson<int?>(evolutionChainId),
      'hp': serializer.toJson<int>(hp),
      'attack': serializer.toJson<int>(attack),
      'defense': serializer.toJson<int>(defense),
      'specialAttack': serializer.toJson<int>(specialAttack),
      'specialDefense': serializer.toJson<int>(specialDefense),
      'speed': serializer.toJson<int>(speed),
      'statTotal': serializer.toJson<int>(statTotal),
      'spriteUrl': serializer.toJson<String?>(spriteUrl),
      'artworkUrl': serializer.toJson<String?>(artworkUrl),
      'shinyArtworkUrl': serializer.toJson<String?>(shinyArtworkUrl),
      'spriteFile': serializer.toJson<String?>(spriteFile),
      'artworkFile': serializer.toJson<String?>(artworkFile),
      'hasDetail': serializer.toJson<bool>(hasDetail),
      'height': serializer.toJson<int?>(height),
      'weight': serializer.toJson<int?>(weight),
      'flavorEs': serializer.toJson<String?>(flavorEs),
      'flavorEn': serializer.toJson<String?>(flavorEn),
      'eggGroups': serializer.toJson<String?>(eggGroups),
      'captureRate': serializer.toJson<int?>(captureRate),
      'isLegendary': serializer.toJson<bool>(isLegendary),
      'isMythical': serializer.toJson<bool>(isMythical),
    };
  }

  PokemonRow copyWith({
    int? id,
    String? name,
    String? nameEs,
    String? nameEn,
    Value<String?> nameJa = const Value.absent(),
    Value<int?> speciesId = const Value.absent(),
    bool? isDefault,
    Value<String?> formNameEs = const Value.absent(),
    Value<String?> formNameEn = const Value.absent(),
    int? generationId,
    Value<int?> evolutionChainId = const Value.absent(),
    int? hp,
    int? attack,
    int? defense,
    int? specialAttack,
    int? specialDefense,
    int? speed,
    int? statTotal,
    Value<String?> spriteUrl = const Value.absent(),
    Value<String?> artworkUrl = const Value.absent(),
    Value<String?> shinyArtworkUrl = const Value.absent(),
    Value<String?> spriteFile = const Value.absent(),
    Value<String?> artworkFile = const Value.absent(),
    bool? hasDetail,
    Value<int?> height = const Value.absent(),
    Value<int?> weight = const Value.absent(),
    Value<String?> flavorEs = const Value.absent(),
    Value<String?> flavorEn = const Value.absent(),
    Value<String?> eggGroups = const Value.absent(),
    Value<int?> captureRate = const Value.absent(),
    bool? isLegendary,
    bool? isMythical,
  }) => PokemonRow(
    id: id ?? this.id,
    name: name ?? this.name,
    nameEs: nameEs ?? this.nameEs,
    nameEn: nameEn ?? this.nameEn,
    nameJa: nameJa.present ? nameJa.value : this.nameJa,
    speciesId: speciesId.present ? speciesId.value : this.speciesId,
    isDefault: isDefault ?? this.isDefault,
    formNameEs: formNameEs.present ? formNameEs.value : this.formNameEs,
    formNameEn: formNameEn.present ? formNameEn.value : this.formNameEn,
    generationId: generationId ?? this.generationId,
    evolutionChainId: evolutionChainId.present
        ? evolutionChainId.value
        : this.evolutionChainId,
    hp: hp ?? this.hp,
    attack: attack ?? this.attack,
    defense: defense ?? this.defense,
    specialAttack: specialAttack ?? this.specialAttack,
    specialDefense: specialDefense ?? this.specialDefense,
    speed: speed ?? this.speed,
    statTotal: statTotal ?? this.statTotal,
    spriteUrl: spriteUrl.present ? spriteUrl.value : this.spriteUrl,
    artworkUrl: artworkUrl.present ? artworkUrl.value : this.artworkUrl,
    shinyArtworkUrl: shinyArtworkUrl.present
        ? shinyArtworkUrl.value
        : this.shinyArtworkUrl,
    spriteFile: spriteFile.present ? spriteFile.value : this.spriteFile,
    artworkFile: artworkFile.present ? artworkFile.value : this.artworkFile,
    hasDetail: hasDetail ?? this.hasDetail,
    height: height.present ? height.value : this.height,
    weight: weight.present ? weight.value : this.weight,
    flavorEs: flavorEs.present ? flavorEs.value : this.flavorEs,
    flavorEn: flavorEn.present ? flavorEn.value : this.flavorEn,
    eggGroups: eggGroups.present ? eggGroups.value : this.eggGroups,
    captureRate: captureRate.present ? captureRate.value : this.captureRate,
    isLegendary: isLegendary ?? this.isLegendary,
    isMythical: isMythical ?? this.isMythical,
  );
  PokemonRow copyWithCompanion(PokemonCompanion data) {
    return PokemonRow(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      nameEs: data.nameEs.present ? data.nameEs.value : this.nameEs,
      nameEn: data.nameEn.present ? data.nameEn.value : this.nameEn,
      nameJa: data.nameJa.present ? data.nameJa.value : this.nameJa,
      speciesId: data.speciesId.present ? data.speciesId.value : this.speciesId,
      isDefault: data.isDefault.present ? data.isDefault.value : this.isDefault,
      formNameEs: data.formNameEs.present
          ? data.formNameEs.value
          : this.formNameEs,
      formNameEn: data.formNameEn.present
          ? data.formNameEn.value
          : this.formNameEn,
      generationId: data.generationId.present
          ? data.generationId.value
          : this.generationId,
      evolutionChainId: data.evolutionChainId.present
          ? data.evolutionChainId.value
          : this.evolutionChainId,
      hp: data.hp.present ? data.hp.value : this.hp,
      attack: data.attack.present ? data.attack.value : this.attack,
      defense: data.defense.present ? data.defense.value : this.defense,
      specialAttack: data.specialAttack.present
          ? data.specialAttack.value
          : this.specialAttack,
      specialDefense: data.specialDefense.present
          ? data.specialDefense.value
          : this.specialDefense,
      speed: data.speed.present ? data.speed.value : this.speed,
      statTotal: data.statTotal.present ? data.statTotal.value : this.statTotal,
      spriteUrl: data.spriteUrl.present ? data.spriteUrl.value : this.spriteUrl,
      artworkUrl: data.artworkUrl.present
          ? data.artworkUrl.value
          : this.artworkUrl,
      shinyArtworkUrl: data.shinyArtworkUrl.present
          ? data.shinyArtworkUrl.value
          : this.shinyArtworkUrl,
      spriteFile: data.spriteFile.present
          ? data.spriteFile.value
          : this.spriteFile,
      artworkFile: data.artworkFile.present
          ? data.artworkFile.value
          : this.artworkFile,
      hasDetail: data.hasDetail.present ? data.hasDetail.value : this.hasDetail,
      height: data.height.present ? data.height.value : this.height,
      weight: data.weight.present ? data.weight.value : this.weight,
      flavorEs: data.flavorEs.present ? data.flavorEs.value : this.flavorEs,
      flavorEn: data.flavorEn.present ? data.flavorEn.value : this.flavorEn,
      eggGroups: data.eggGroups.present ? data.eggGroups.value : this.eggGroups,
      captureRate: data.captureRate.present
          ? data.captureRate.value
          : this.captureRate,
      isLegendary: data.isLegendary.present
          ? data.isLegendary.value
          : this.isLegendary,
      isMythical: data.isMythical.present
          ? data.isMythical.value
          : this.isMythical,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PokemonRow(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('nameEs: $nameEs, ')
          ..write('nameEn: $nameEn, ')
          ..write('nameJa: $nameJa, ')
          ..write('speciesId: $speciesId, ')
          ..write('isDefault: $isDefault, ')
          ..write('formNameEs: $formNameEs, ')
          ..write('formNameEn: $formNameEn, ')
          ..write('generationId: $generationId, ')
          ..write('evolutionChainId: $evolutionChainId, ')
          ..write('hp: $hp, ')
          ..write('attack: $attack, ')
          ..write('defense: $defense, ')
          ..write('specialAttack: $specialAttack, ')
          ..write('specialDefense: $specialDefense, ')
          ..write('speed: $speed, ')
          ..write('statTotal: $statTotal, ')
          ..write('spriteUrl: $spriteUrl, ')
          ..write('artworkUrl: $artworkUrl, ')
          ..write('shinyArtworkUrl: $shinyArtworkUrl, ')
          ..write('spriteFile: $spriteFile, ')
          ..write('artworkFile: $artworkFile, ')
          ..write('hasDetail: $hasDetail, ')
          ..write('height: $height, ')
          ..write('weight: $weight, ')
          ..write('flavorEs: $flavorEs, ')
          ..write('flavorEn: $flavorEn, ')
          ..write('eggGroups: $eggGroups, ')
          ..write('captureRate: $captureRate, ')
          ..write('isLegendary: $isLegendary, ')
          ..write('isMythical: $isMythical')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
    id,
    name,
    nameEs,
    nameEn,
    nameJa,
    speciesId,
    isDefault,
    formNameEs,
    formNameEn,
    generationId,
    evolutionChainId,
    hp,
    attack,
    defense,
    specialAttack,
    specialDefense,
    speed,
    statTotal,
    spriteUrl,
    artworkUrl,
    shinyArtworkUrl,
    spriteFile,
    artworkFile,
    hasDetail,
    height,
    weight,
    flavorEs,
    flavorEn,
    eggGroups,
    captureRate,
    isLegendary,
    isMythical,
  ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PokemonRow &&
          other.id == this.id &&
          other.name == this.name &&
          other.nameEs == this.nameEs &&
          other.nameEn == this.nameEn &&
          other.nameJa == this.nameJa &&
          other.speciesId == this.speciesId &&
          other.isDefault == this.isDefault &&
          other.formNameEs == this.formNameEs &&
          other.formNameEn == this.formNameEn &&
          other.generationId == this.generationId &&
          other.evolutionChainId == this.evolutionChainId &&
          other.hp == this.hp &&
          other.attack == this.attack &&
          other.defense == this.defense &&
          other.specialAttack == this.specialAttack &&
          other.specialDefense == this.specialDefense &&
          other.speed == this.speed &&
          other.statTotal == this.statTotal &&
          other.spriteUrl == this.spriteUrl &&
          other.artworkUrl == this.artworkUrl &&
          other.shinyArtworkUrl == this.shinyArtworkUrl &&
          other.spriteFile == this.spriteFile &&
          other.artworkFile == this.artworkFile &&
          other.hasDetail == this.hasDetail &&
          other.height == this.height &&
          other.weight == this.weight &&
          other.flavorEs == this.flavorEs &&
          other.flavorEn == this.flavorEn &&
          other.eggGroups == this.eggGroups &&
          other.captureRate == this.captureRate &&
          other.isLegendary == this.isLegendary &&
          other.isMythical == this.isMythical);
}

class PokemonCompanion extends UpdateCompanion<PokemonRow> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> nameEs;
  final Value<String> nameEn;
  final Value<String?> nameJa;
  final Value<int?> speciesId;
  final Value<bool> isDefault;
  final Value<String?> formNameEs;
  final Value<String?> formNameEn;
  final Value<int> generationId;
  final Value<int?> evolutionChainId;
  final Value<int> hp;
  final Value<int> attack;
  final Value<int> defense;
  final Value<int> specialAttack;
  final Value<int> specialDefense;
  final Value<int> speed;
  final Value<int> statTotal;
  final Value<String?> spriteUrl;
  final Value<String?> artworkUrl;
  final Value<String?> shinyArtworkUrl;
  final Value<String?> spriteFile;
  final Value<String?> artworkFile;
  final Value<bool> hasDetail;
  final Value<int?> height;
  final Value<int?> weight;
  final Value<String?> flavorEs;
  final Value<String?> flavorEn;
  final Value<String?> eggGroups;
  final Value<int?> captureRate;
  final Value<bool> isLegendary;
  final Value<bool> isMythical;
  const PokemonCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.nameEs = const Value.absent(),
    this.nameEn = const Value.absent(),
    this.nameJa = const Value.absent(),
    this.speciesId = const Value.absent(),
    this.isDefault = const Value.absent(),
    this.formNameEs = const Value.absent(),
    this.formNameEn = const Value.absent(),
    this.generationId = const Value.absent(),
    this.evolutionChainId = const Value.absent(),
    this.hp = const Value.absent(),
    this.attack = const Value.absent(),
    this.defense = const Value.absent(),
    this.specialAttack = const Value.absent(),
    this.specialDefense = const Value.absent(),
    this.speed = const Value.absent(),
    this.statTotal = const Value.absent(),
    this.spriteUrl = const Value.absent(),
    this.artworkUrl = const Value.absent(),
    this.shinyArtworkUrl = const Value.absent(),
    this.spriteFile = const Value.absent(),
    this.artworkFile = const Value.absent(),
    this.hasDetail = const Value.absent(),
    this.height = const Value.absent(),
    this.weight = const Value.absent(),
    this.flavorEs = const Value.absent(),
    this.flavorEn = const Value.absent(),
    this.eggGroups = const Value.absent(),
    this.captureRate = const Value.absent(),
    this.isLegendary = const Value.absent(),
    this.isMythical = const Value.absent(),
  });
  PokemonCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String nameEs,
    required String nameEn,
    this.nameJa = const Value.absent(),
    this.speciesId = const Value.absent(),
    this.isDefault = const Value.absent(),
    this.formNameEs = const Value.absent(),
    this.formNameEn = const Value.absent(),
    required int generationId,
    this.evolutionChainId = const Value.absent(),
    required int hp,
    required int attack,
    required int defense,
    required int specialAttack,
    required int specialDefense,
    required int speed,
    required int statTotal,
    this.spriteUrl = const Value.absent(),
    this.artworkUrl = const Value.absent(),
    this.shinyArtworkUrl = const Value.absent(),
    this.spriteFile = const Value.absent(),
    this.artworkFile = const Value.absent(),
    this.hasDetail = const Value.absent(),
    this.height = const Value.absent(),
    this.weight = const Value.absent(),
    this.flavorEs = const Value.absent(),
    this.flavorEn = const Value.absent(),
    this.eggGroups = const Value.absent(),
    this.captureRate = const Value.absent(),
    this.isLegendary = const Value.absent(),
    this.isMythical = const Value.absent(),
  }) : name = Value(name),
       nameEs = Value(nameEs),
       nameEn = Value(nameEn),
       generationId = Value(generationId),
       hp = Value(hp),
       attack = Value(attack),
       defense = Value(defense),
       specialAttack = Value(specialAttack),
       specialDefense = Value(specialDefense),
       speed = Value(speed),
       statTotal = Value(statTotal);
  static Insertable<PokemonRow> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? nameEs,
    Expression<String>? nameEn,
    Expression<String>? nameJa,
    Expression<int>? speciesId,
    Expression<bool>? isDefault,
    Expression<String>? formNameEs,
    Expression<String>? formNameEn,
    Expression<int>? generationId,
    Expression<int>? evolutionChainId,
    Expression<int>? hp,
    Expression<int>? attack,
    Expression<int>? defense,
    Expression<int>? specialAttack,
    Expression<int>? specialDefense,
    Expression<int>? speed,
    Expression<int>? statTotal,
    Expression<String>? spriteUrl,
    Expression<String>? artworkUrl,
    Expression<String>? shinyArtworkUrl,
    Expression<String>? spriteFile,
    Expression<String>? artworkFile,
    Expression<bool>? hasDetail,
    Expression<int>? height,
    Expression<int>? weight,
    Expression<String>? flavorEs,
    Expression<String>? flavorEn,
    Expression<String>? eggGroups,
    Expression<int>? captureRate,
    Expression<bool>? isLegendary,
    Expression<bool>? isMythical,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (nameEs != null) 'name_es': nameEs,
      if (nameEn != null) 'name_en': nameEn,
      if (nameJa != null) 'name_ja': nameJa,
      if (speciesId != null) 'species_id': speciesId,
      if (isDefault != null) 'is_default': isDefault,
      if (formNameEs != null) 'form_name_es': formNameEs,
      if (formNameEn != null) 'form_name_en': formNameEn,
      if (generationId != null) 'generation_id': generationId,
      if (evolutionChainId != null) 'evolution_chain_id': evolutionChainId,
      if (hp != null) 'hp': hp,
      if (attack != null) 'attack': attack,
      if (defense != null) 'defense': defense,
      if (specialAttack != null) 'special_attack': specialAttack,
      if (specialDefense != null) 'special_defense': specialDefense,
      if (speed != null) 'speed': speed,
      if (statTotal != null) 'stat_total': statTotal,
      if (spriteUrl != null) 'sprite_url': spriteUrl,
      if (artworkUrl != null) 'artwork_url': artworkUrl,
      if (shinyArtworkUrl != null) 'shiny_artwork_url': shinyArtworkUrl,
      if (spriteFile != null) 'sprite_file': spriteFile,
      if (artworkFile != null) 'artwork_file': artworkFile,
      if (hasDetail != null) 'has_detail': hasDetail,
      if (height != null) 'height': height,
      if (weight != null) 'weight': weight,
      if (flavorEs != null) 'flavor_es': flavorEs,
      if (flavorEn != null) 'flavor_en': flavorEn,
      if (eggGroups != null) 'egg_groups': eggGroups,
      if (captureRate != null) 'capture_rate': captureRate,
      if (isLegendary != null) 'is_legendary': isLegendary,
      if (isMythical != null) 'is_mythical': isMythical,
    });
  }

  PokemonCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String>? nameEs,
    Value<String>? nameEn,
    Value<String?>? nameJa,
    Value<int?>? speciesId,
    Value<bool>? isDefault,
    Value<String?>? formNameEs,
    Value<String?>? formNameEn,
    Value<int>? generationId,
    Value<int?>? evolutionChainId,
    Value<int>? hp,
    Value<int>? attack,
    Value<int>? defense,
    Value<int>? specialAttack,
    Value<int>? specialDefense,
    Value<int>? speed,
    Value<int>? statTotal,
    Value<String?>? spriteUrl,
    Value<String?>? artworkUrl,
    Value<String?>? shinyArtworkUrl,
    Value<String?>? spriteFile,
    Value<String?>? artworkFile,
    Value<bool>? hasDetail,
    Value<int?>? height,
    Value<int?>? weight,
    Value<String?>? flavorEs,
    Value<String?>? flavorEn,
    Value<String?>? eggGroups,
    Value<int?>? captureRate,
    Value<bool>? isLegendary,
    Value<bool>? isMythical,
  }) {
    return PokemonCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      nameEs: nameEs ?? this.nameEs,
      nameEn: nameEn ?? this.nameEn,
      nameJa: nameJa ?? this.nameJa,
      speciesId: speciesId ?? this.speciesId,
      isDefault: isDefault ?? this.isDefault,
      formNameEs: formNameEs ?? this.formNameEs,
      formNameEn: formNameEn ?? this.formNameEn,
      generationId: generationId ?? this.generationId,
      evolutionChainId: evolutionChainId ?? this.evolutionChainId,
      hp: hp ?? this.hp,
      attack: attack ?? this.attack,
      defense: defense ?? this.defense,
      specialAttack: specialAttack ?? this.specialAttack,
      specialDefense: specialDefense ?? this.specialDefense,
      speed: speed ?? this.speed,
      statTotal: statTotal ?? this.statTotal,
      spriteUrl: spriteUrl ?? this.spriteUrl,
      artworkUrl: artworkUrl ?? this.artworkUrl,
      shinyArtworkUrl: shinyArtworkUrl ?? this.shinyArtworkUrl,
      spriteFile: spriteFile ?? this.spriteFile,
      artworkFile: artworkFile ?? this.artworkFile,
      hasDetail: hasDetail ?? this.hasDetail,
      height: height ?? this.height,
      weight: weight ?? this.weight,
      flavorEs: flavorEs ?? this.flavorEs,
      flavorEn: flavorEn ?? this.flavorEn,
      eggGroups: eggGroups ?? this.eggGroups,
      captureRate: captureRate ?? this.captureRate,
      isLegendary: isLegendary ?? this.isLegendary,
      isMythical: isMythical ?? this.isMythical,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (nameEs.present) {
      map['name_es'] = Variable<String>(nameEs.value);
    }
    if (nameEn.present) {
      map['name_en'] = Variable<String>(nameEn.value);
    }
    if (nameJa.present) {
      map['name_ja'] = Variable<String>(nameJa.value);
    }
    if (speciesId.present) {
      map['species_id'] = Variable<int>(speciesId.value);
    }
    if (isDefault.present) {
      map['is_default'] = Variable<bool>(isDefault.value);
    }
    if (formNameEs.present) {
      map['form_name_es'] = Variable<String>(formNameEs.value);
    }
    if (formNameEn.present) {
      map['form_name_en'] = Variable<String>(formNameEn.value);
    }
    if (generationId.present) {
      map['generation_id'] = Variable<int>(generationId.value);
    }
    if (evolutionChainId.present) {
      map['evolution_chain_id'] = Variable<int>(evolutionChainId.value);
    }
    if (hp.present) {
      map['hp'] = Variable<int>(hp.value);
    }
    if (attack.present) {
      map['attack'] = Variable<int>(attack.value);
    }
    if (defense.present) {
      map['defense'] = Variable<int>(defense.value);
    }
    if (specialAttack.present) {
      map['special_attack'] = Variable<int>(specialAttack.value);
    }
    if (specialDefense.present) {
      map['special_defense'] = Variable<int>(specialDefense.value);
    }
    if (speed.present) {
      map['speed'] = Variable<int>(speed.value);
    }
    if (statTotal.present) {
      map['stat_total'] = Variable<int>(statTotal.value);
    }
    if (spriteUrl.present) {
      map['sprite_url'] = Variable<String>(spriteUrl.value);
    }
    if (artworkUrl.present) {
      map['artwork_url'] = Variable<String>(artworkUrl.value);
    }
    if (shinyArtworkUrl.present) {
      map['shiny_artwork_url'] = Variable<String>(shinyArtworkUrl.value);
    }
    if (spriteFile.present) {
      map['sprite_file'] = Variable<String>(spriteFile.value);
    }
    if (artworkFile.present) {
      map['artwork_file'] = Variable<String>(artworkFile.value);
    }
    if (hasDetail.present) {
      map['has_detail'] = Variable<bool>(hasDetail.value);
    }
    if (height.present) {
      map['height'] = Variable<int>(height.value);
    }
    if (weight.present) {
      map['weight'] = Variable<int>(weight.value);
    }
    if (flavorEs.present) {
      map['flavor_es'] = Variable<String>(flavorEs.value);
    }
    if (flavorEn.present) {
      map['flavor_en'] = Variable<String>(flavorEn.value);
    }
    if (eggGroups.present) {
      map['egg_groups'] = Variable<String>(eggGroups.value);
    }
    if (captureRate.present) {
      map['capture_rate'] = Variable<int>(captureRate.value);
    }
    if (isLegendary.present) {
      map['is_legendary'] = Variable<bool>(isLegendary.value);
    }
    if (isMythical.present) {
      map['is_mythical'] = Variable<bool>(isMythical.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PokemonCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('nameEs: $nameEs, ')
          ..write('nameEn: $nameEn, ')
          ..write('nameJa: $nameJa, ')
          ..write('speciesId: $speciesId, ')
          ..write('isDefault: $isDefault, ')
          ..write('formNameEs: $formNameEs, ')
          ..write('formNameEn: $formNameEn, ')
          ..write('generationId: $generationId, ')
          ..write('evolutionChainId: $evolutionChainId, ')
          ..write('hp: $hp, ')
          ..write('attack: $attack, ')
          ..write('defense: $defense, ')
          ..write('specialAttack: $specialAttack, ')
          ..write('specialDefense: $specialDefense, ')
          ..write('speed: $speed, ')
          ..write('statTotal: $statTotal, ')
          ..write('spriteUrl: $spriteUrl, ')
          ..write('artworkUrl: $artworkUrl, ')
          ..write('shinyArtworkUrl: $shinyArtworkUrl, ')
          ..write('spriteFile: $spriteFile, ')
          ..write('artworkFile: $artworkFile, ')
          ..write('hasDetail: $hasDetail, ')
          ..write('height: $height, ')
          ..write('weight: $weight, ')
          ..write('flavorEs: $flavorEs, ')
          ..write('flavorEn: $flavorEn, ')
          ..write('eggGroups: $eggGroups, ')
          ..write('captureRate: $captureRate, ')
          ..write('isLegendary: $isLegendary, ')
          ..write('isMythical: $isMythical')
          ..write(')'))
        .toString();
  }
}

class $PokeTypesTable extends PokeTypes
    with TableInfo<$PokeTypesTable, PokeTypeRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PokeTypesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameEsMeta = const VerificationMeta('nameEs');
  @override
  late final GeneratedColumn<String> nameEs = GeneratedColumn<String>(
    'name_es',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameEnMeta = const VerificationMeta('nameEn');
  @override
  late final GeneratedColumn<String> nameEn = GeneratedColumn<String>(
    'name_en',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, name, nameEs, nameEn];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'poke_types';
  @override
  VerificationContext validateIntegrity(
    Insertable<PokeTypeRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('name_es')) {
      context.handle(
        _nameEsMeta,
        nameEs.isAcceptableOrUnknown(data['name_es']!, _nameEsMeta),
      );
    } else if (isInserting) {
      context.missing(_nameEsMeta);
    }
    if (data.containsKey('name_en')) {
      context.handle(
        _nameEnMeta,
        nameEn.isAcceptableOrUnknown(data['name_en']!, _nameEnMeta),
      );
    } else if (isInserting) {
      context.missing(_nameEnMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PokeTypeRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PokeTypeRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      nameEs: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name_es'],
      )!,
      nameEn: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name_en'],
      )!,
    );
  }

  @override
  $PokeTypesTable createAlias(String alias) {
    return $PokeTypesTable(attachedDatabase, alias);
  }
}

class PokeTypeRow extends DataClass implements Insertable<PokeTypeRow> {
  final int id;
  final String name;
  final String nameEs;
  final String nameEn;
  const PokeTypeRow({
    required this.id,
    required this.name,
    required this.nameEs,
    required this.nameEn,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['name_es'] = Variable<String>(nameEs);
    map['name_en'] = Variable<String>(nameEn);
    return map;
  }

  PokeTypesCompanion toCompanion(bool nullToAbsent) {
    return PokeTypesCompanion(
      id: Value(id),
      name: Value(name),
      nameEs: Value(nameEs),
      nameEn: Value(nameEn),
    );
  }

  factory PokeTypeRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PokeTypeRow(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      nameEs: serializer.fromJson<String>(json['nameEs']),
      nameEn: serializer.fromJson<String>(json['nameEn']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'nameEs': serializer.toJson<String>(nameEs),
      'nameEn': serializer.toJson<String>(nameEn),
    };
  }

  PokeTypeRow copyWith({
    int? id,
    String? name,
    String? nameEs,
    String? nameEn,
  }) => PokeTypeRow(
    id: id ?? this.id,
    name: name ?? this.name,
    nameEs: nameEs ?? this.nameEs,
    nameEn: nameEn ?? this.nameEn,
  );
  PokeTypeRow copyWithCompanion(PokeTypesCompanion data) {
    return PokeTypeRow(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      nameEs: data.nameEs.present ? data.nameEs.value : this.nameEs,
      nameEn: data.nameEn.present ? data.nameEn.value : this.nameEn,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PokeTypeRow(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('nameEs: $nameEs, ')
          ..write('nameEn: $nameEn')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, nameEs, nameEn);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PokeTypeRow &&
          other.id == this.id &&
          other.name == this.name &&
          other.nameEs == this.nameEs &&
          other.nameEn == this.nameEn);
}

class PokeTypesCompanion extends UpdateCompanion<PokeTypeRow> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> nameEs;
  final Value<String> nameEn;
  const PokeTypesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.nameEs = const Value.absent(),
    this.nameEn = const Value.absent(),
  });
  PokeTypesCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String nameEs,
    required String nameEn,
  }) : name = Value(name),
       nameEs = Value(nameEs),
       nameEn = Value(nameEn);
  static Insertable<PokeTypeRow> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? nameEs,
    Expression<String>? nameEn,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (nameEs != null) 'name_es': nameEs,
      if (nameEn != null) 'name_en': nameEn,
    });
  }

  PokeTypesCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String>? nameEs,
    Value<String>? nameEn,
  }) {
    return PokeTypesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      nameEs: nameEs ?? this.nameEs,
      nameEn: nameEn ?? this.nameEn,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (nameEs.present) {
      map['name_es'] = Variable<String>(nameEs.value);
    }
    if (nameEn.present) {
      map['name_en'] = Variable<String>(nameEn.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PokeTypesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('nameEs: $nameEs, ')
          ..write('nameEn: $nameEn')
          ..write(')'))
        .toString();
  }
}

class $PokemonTypesTable extends PokemonTypes
    with TableInfo<$PokemonTypesTable, PokemonTypeRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PokemonTypesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _pokemonIdMeta = const VerificationMeta(
    'pokemonId',
  );
  @override
  late final GeneratedColumn<int> pokemonId = GeneratedColumn<int>(
    'pokemon_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _typeIdMeta = const VerificationMeta('typeId');
  @override
  late final GeneratedColumn<int> typeId = GeneratedColumn<int>(
    'type_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _slotMeta = const VerificationMeta('slot');
  @override
  late final GeneratedColumn<int> slot = GeneratedColumn<int>(
    'slot',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [pokemonId, typeId, slot];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'pokemon_types';
  @override
  VerificationContext validateIntegrity(
    Insertable<PokemonTypeRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('pokemon_id')) {
      context.handle(
        _pokemonIdMeta,
        pokemonId.isAcceptableOrUnknown(data['pokemon_id']!, _pokemonIdMeta),
      );
    } else if (isInserting) {
      context.missing(_pokemonIdMeta);
    }
    if (data.containsKey('type_id')) {
      context.handle(
        _typeIdMeta,
        typeId.isAcceptableOrUnknown(data['type_id']!, _typeIdMeta),
      );
    } else if (isInserting) {
      context.missing(_typeIdMeta);
    }
    if (data.containsKey('slot')) {
      context.handle(
        _slotMeta,
        slot.isAcceptableOrUnknown(data['slot']!, _slotMeta),
      );
    } else if (isInserting) {
      context.missing(_slotMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {pokemonId, slot};
  @override
  PokemonTypeRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PokemonTypeRow(
      pokemonId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}pokemon_id'],
      )!,
      typeId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}type_id'],
      )!,
      slot: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}slot'],
      )!,
    );
  }

  @override
  $PokemonTypesTable createAlias(String alias) {
    return $PokemonTypesTable(attachedDatabase, alias);
  }
}

class PokemonTypeRow extends DataClass implements Insertable<PokemonTypeRow> {
  final int pokemonId;
  final int typeId;
  final int slot;
  const PokemonTypeRow({
    required this.pokemonId,
    required this.typeId,
    required this.slot,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['pokemon_id'] = Variable<int>(pokemonId);
    map['type_id'] = Variable<int>(typeId);
    map['slot'] = Variable<int>(slot);
    return map;
  }

  PokemonTypesCompanion toCompanion(bool nullToAbsent) {
    return PokemonTypesCompanion(
      pokemonId: Value(pokemonId),
      typeId: Value(typeId),
      slot: Value(slot),
    );
  }

  factory PokemonTypeRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PokemonTypeRow(
      pokemonId: serializer.fromJson<int>(json['pokemonId']),
      typeId: serializer.fromJson<int>(json['typeId']),
      slot: serializer.fromJson<int>(json['slot']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'pokemonId': serializer.toJson<int>(pokemonId),
      'typeId': serializer.toJson<int>(typeId),
      'slot': serializer.toJson<int>(slot),
    };
  }

  PokemonTypeRow copyWith({int? pokemonId, int? typeId, int? slot}) =>
      PokemonTypeRow(
        pokemonId: pokemonId ?? this.pokemonId,
        typeId: typeId ?? this.typeId,
        slot: slot ?? this.slot,
      );
  PokemonTypeRow copyWithCompanion(PokemonTypesCompanion data) {
    return PokemonTypeRow(
      pokemonId: data.pokemonId.present ? data.pokemonId.value : this.pokemonId,
      typeId: data.typeId.present ? data.typeId.value : this.typeId,
      slot: data.slot.present ? data.slot.value : this.slot,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PokemonTypeRow(')
          ..write('pokemonId: $pokemonId, ')
          ..write('typeId: $typeId, ')
          ..write('slot: $slot')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(pokemonId, typeId, slot);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PokemonTypeRow &&
          other.pokemonId == this.pokemonId &&
          other.typeId == this.typeId &&
          other.slot == this.slot);
}

class PokemonTypesCompanion extends UpdateCompanion<PokemonTypeRow> {
  final Value<int> pokemonId;
  final Value<int> typeId;
  final Value<int> slot;
  final Value<int> rowid;
  const PokemonTypesCompanion({
    this.pokemonId = const Value.absent(),
    this.typeId = const Value.absent(),
    this.slot = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PokemonTypesCompanion.insert({
    required int pokemonId,
    required int typeId,
    required int slot,
    this.rowid = const Value.absent(),
  }) : pokemonId = Value(pokemonId),
       typeId = Value(typeId),
       slot = Value(slot);
  static Insertable<PokemonTypeRow> custom({
    Expression<int>? pokemonId,
    Expression<int>? typeId,
    Expression<int>? slot,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (pokemonId != null) 'pokemon_id': pokemonId,
      if (typeId != null) 'type_id': typeId,
      if (slot != null) 'slot': slot,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PokemonTypesCompanion copyWith({
    Value<int>? pokemonId,
    Value<int>? typeId,
    Value<int>? slot,
    Value<int>? rowid,
  }) {
    return PokemonTypesCompanion(
      pokemonId: pokemonId ?? this.pokemonId,
      typeId: typeId ?? this.typeId,
      slot: slot ?? this.slot,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (pokemonId.present) {
      map['pokemon_id'] = Variable<int>(pokemonId.value);
    }
    if (typeId.present) {
      map['type_id'] = Variable<int>(typeId.value);
    }
    if (slot.present) {
      map['slot'] = Variable<int>(slot.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PokemonTypesCompanion(')
          ..write('pokemonId: $pokemonId, ')
          ..write('typeId: $typeId, ')
          ..write('slot: $slot, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $TypeEfficacyTable extends TypeEfficacy
    with TableInfo<$TypeEfficacyTable, TypeEfficacyRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TypeEfficacyTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _attackTypeIdMeta = const VerificationMeta(
    'attackTypeId',
  );
  @override
  late final GeneratedColumn<int> attackTypeId = GeneratedColumn<int>(
    'attack_type_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _targetTypeIdMeta = const VerificationMeta(
    'targetTypeId',
  );
  @override
  late final GeneratedColumn<int> targetTypeId = GeneratedColumn<int>(
    'target_type_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _factorMeta = const VerificationMeta('factor');
  @override
  late final GeneratedColumn<int> factor = GeneratedColumn<int>(
    'factor',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [attackTypeId, targetTypeId, factor];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'type_efficacy';
  @override
  VerificationContext validateIntegrity(
    Insertable<TypeEfficacyRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('attack_type_id')) {
      context.handle(
        _attackTypeIdMeta,
        attackTypeId.isAcceptableOrUnknown(
          data['attack_type_id']!,
          _attackTypeIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_attackTypeIdMeta);
    }
    if (data.containsKey('target_type_id')) {
      context.handle(
        _targetTypeIdMeta,
        targetTypeId.isAcceptableOrUnknown(
          data['target_type_id']!,
          _targetTypeIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_targetTypeIdMeta);
    }
    if (data.containsKey('factor')) {
      context.handle(
        _factorMeta,
        factor.isAcceptableOrUnknown(data['factor']!, _factorMeta),
      );
    } else if (isInserting) {
      context.missing(_factorMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {attackTypeId, targetTypeId};
  @override
  TypeEfficacyRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TypeEfficacyRow(
      attackTypeId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}attack_type_id'],
      )!,
      targetTypeId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}target_type_id'],
      )!,
      factor: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}factor'],
      )!,
    );
  }

  @override
  $TypeEfficacyTable createAlias(String alias) {
    return $TypeEfficacyTable(attachedDatabase, alias);
  }
}

class TypeEfficacyRow extends DataClass implements Insertable<TypeEfficacyRow> {
  final int attackTypeId;
  final int targetTypeId;
  final int factor;
  const TypeEfficacyRow({
    required this.attackTypeId,
    required this.targetTypeId,
    required this.factor,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['attack_type_id'] = Variable<int>(attackTypeId);
    map['target_type_id'] = Variable<int>(targetTypeId);
    map['factor'] = Variable<int>(factor);
    return map;
  }

  TypeEfficacyCompanion toCompanion(bool nullToAbsent) {
    return TypeEfficacyCompanion(
      attackTypeId: Value(attackTypeId),
      targetTypeId: Value(targetTypeId),
      factor: Value(factor),
    );
  }

  factory TypeEfficacyRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TypeEfficacyRow(
      attackTypeId: serializer.fromJson<int>(json['attackTypeId']),
      targetTypeId: serializer.fromJson<int>(json['targetTypeId']),
      factor: serializer.fromJson<int>(json['factor']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'attackTypeId': serializer.toJson<int>(attackTypeId),
      'targetTypeId': serializer.toJson<int>(targetTypeId),
      'factor': serializer.toJson<int>(factor),
    };
  }

  TypeEfficacyRow copyWith({
    int? attackTypeId,
    int? targetTypeId,
    int? factor,
  }) => TypeEfficacyRow(
    attackTypeId: attackTypeId ?? this.attackTypeId,
    targetTypeId: targetTypeId ?? this.targetTypeId,
    factor: factor ?? this.factor,
  );
  TypeEfficacyRow copyWithCompanion(TypeEfficacyCompanion data) {
    return TypeEfficacyRow(
      attackTypeId: data.attackTypeId.present
          ? data.attackTypeId.value
          : this.attackTypeId,
      targetTypeId: data.targetTypeId.present
          ? data.targetTypeId.value
          : this.targetTypeId,
      factor: data.factor.present ? data.factor.value : this.factor,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TypeEfficacyRow(')
          ..write('attackTypeId: $attackTypeId, ')
          ..write('targetTypeId: $targetTypeId, ')
          ..write('factor: $factor')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(attackTypeId, targetTypeId, factor);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TypeEfficacyRow &&
          other.attackTypeId == this.attackTypeId &&
          other.targetTypeId == this.targetTypeId &&
          other.factor == this.factor);
}

class TypeEfficacyCompanion extends UpdateCompanion<TypeEfficacyRow> {
  final Value<int> attackTypeId;
  final Value<int> targetTypeId;
  final Value<int> factor;
  final Value<int> rowid;
  const TypeEfficacyCompanion({
    this.attackTypeId = const Value.absent(),
    this.targetTypeId = const Value.absent(),
    this.factor = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TypeEfficacyCompanion.insert({
    required int attackTypeId,
    required int targetTypeId,
    required int factor,
    this.rowid = const Value.absent(),
  }) : attackTypeId = Value(attackTypeId),
       targetTypeId = Value(targetTypeId),
       factor = Value(factor);
  static Insertable<TypeEfficacyRow> custom({
    Expression<int>? attackTypeId,
    Expression<int>? targetTypeId,
    Expression<int>? factor,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (attackTypeId != null) 'attack_type_id': attackTypeId,
      if (targetTypeId != null) 'target_type_id': targetTypeId,
      if (factor != null) 'factor': factor,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TypeEfficacyCompanion copyWith({
    Value<int>? attackTypeId,
    Value<int>? targetTypeId,
    Value<int>? factor,
    Value<int>? rowid,
  }) {
    return TypeEfficacyCompanion(
      attackTypeId: attackTypeId ?? this.attackTypeId,
      targetTypeId: targetTypeId ?? this.targetTypeId,
      factor: factor ?? this.factor,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (attackTypeId.present) {
      map['attack_type_id'] = Variable<int>(attackTypeId.value);
    }
    if (targetTypeId.present) {
      map['target_type_id'] = Variable<int>(targetTypeId.value);
    }
    if (factor.present) {
      map['factor'] = Variable<int>(factor.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TypeEfficacyCompanion(')
          ..write('attackTypeId: $attackTypeId, ')
          ..write('targetTypeId: $targetTypeId, ')
          ..write('factor: $factor, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $GenerationsTable extends Generations
    with TableInfo<$GenerationsTable, GenerationRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $GenerationsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _regionNameMeta = const VerificationMeta(
    'regionName',
  );
  @override
  late final GeneratedColumn<String> regionName = GeneratedColumn<String>(
    'region_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, name, regionName];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'generations';
  @override
  VerificationContext validateIntegrity(
    Insertable<GenerationRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('region_name')) {
      context.handle(
        _regionNameMeta,
        regionName.isAcceptableOrUnknown(data['region_name']!, _regionNameMeta),
      );
    } else if (isInserting) {
      context.missing(_regionNameMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  GenerationRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return GenerationRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      regionName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}region_name'],
      )!,
    );
  }

  @override
  $GenerationsTable createAlias(String alias) {
    return $GenerationsTable(attachedDatabase, alias);
  }
}

class GenerationRow extends DataClass implements Insertable<GenerationRow> {
  final int id;
  final String name;
  final String regionName;
  const GenerationRow({
    required this.id,
    required this.name,
    required this.regionName,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['region_name'] = Variable<String>(regionName);
    return map;
  }

  GenerationsCompanion toCompanion(bool nullToAbsent) {
    return GenerationsCompanion(
      id: Value(id),
      name: Value(name),
      regionName: Value(regionName),
    );
  }

  factory GenerationRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return GenerationRow(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      regionName: serializer.fromJson<String>(json['regionName']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'regionName': serializer.toJson<String>(regionName),
    };
  }

  GenerationRow copyWith({int? id, String? name, String? regionName}) =>
      GenerationRow(
        id: id ?? this.id,
        name: name ?? this.name,
        regionName: regionName ?? this.regionName,
      );
  GenerationRow copyWithCompanion(GenerationsCompanion data) {
    return GenerationRow(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      regionName: data.regionName.present
          ? data.regionName.value
          : this.regionName,
    );
  }

  @override
  String toString() {
    return (StringBuffer('GenerationRow(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('regionName: $regionName')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, regionName);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is GenerationRow &&
          other.id == this.id &&
          other.name == this.name &&
          other.regionName == this.regionName);
}

class GenerationsCompanion extends UpdateCompanion<GenerationRow> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> regionName;
  const GenerationsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.regionName = const Value.absent(),
  });
  GenerationsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String regionName,
  }) : name = Value(name),
       regionName = Value(regionName);
  static Insertable<GenerationRow> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? regionName,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (regionName != null) 'region_name': regionName,
    });
  }

  GenerationsCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String>? regionName,
  }) {
    return GenerationsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      regionName: regionName ?? this.regionName,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (regionName.present) {
      map['region_name'] = Variable<String>(regionName.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('GenerationsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('regionName: $regionName')
          ..write(')'))
        .toString();
  }
}

class $VersionGroupsTable extends VersionGroups
    with TableInfo<$VersionGroupsTable, VersionGroupRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $VersionGroupsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _generationIdMeta = const VerificationMeta(
    'generationId',
  );
  @override
  late final GeneratedColumn<int> generationId = GeneratedColumn<int>(
    'generation_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sortOrderMeta = const VerificationMeta(
    'sortOrder',
  );
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
    'sort_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, name, generationId, sortOrder];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'version_groups';
  @override
  VerificationContext validateIntegrity(
    Insertable<VersionGroupRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('generation_id')) {
      context.handle(
        _generationIdMeta,
        generationId.isAcceptableOrUnknown(
          data['generation_id']!,
          _generationIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_generationIdMeta);
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    } else if (isInserting) {
      context.missing(_sortOrderMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  VersionGroupRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return VersionGroupRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      generationId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}generation_id'],
      )!,
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
    );
  }

  @override
  $VersionGroupsTable createAlias(String alias) {
    return $VersionGroupsTable(attachedDatabase, alias);
  }
}

class VersionGroupRow extends DataClass implements Insertable<VersionGroupRow> {
  final int id;
  final String name;
  final int generationId;
  final int sortOrder;
  const VersionGroupRow({
    required this.id,
    required this.name,
    required this.generationId,
    required this.sortOrder,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['generation_id'] = Variable<int>(generationId);
    map['sort_order'] = Variable<int>(sortOrder);
    return map;
  }

  VersionGroupsCompanion toCompanion(bool nullToAbsent) {
    return VersionGroupsCompanion(
      id: Value(id),
      name: Value(name),
      generationId: Value(generationId),
      sortOrder: Value(sortOrder),
    );
  }

  factory VersionGroupRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return VersionGroupRow(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      generationId: serializer.fromJson<int>(json['generationId']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'generationId': serializer.toJson<int>(generationId),
      'sortOrder': serializer.toJson<int>(sortOrder),
    };
  }

  VersionGroupRow copyWith({
    int? id,
    String? name,
    int? generationId,
    int? sortOrder,
  }) => VersionGroupRow(
    id: id ?? this.id,
    name: name ?? this.name,
    generationId: generationId ?? this.generationId,
    sortOrder: sortOrder ?? this.sortOrder,
  );
  VersionGroupRow copyWithCompanion(VersionGroupsCompanion data) {
    return VersionGroupRow(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      generationId: data.generationId.present
          ? data.generationId.value
          : this.generationId,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
    );
  }

  @override
  String toString() {
    return (StringBuffer('VersionGroupRow(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('generationId: $generationId, ')
          ..write('sortOrder: $sortOrder')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, generationId, sortOrder);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is VersionGroupRow &&
          other.id == this.id &&
          other.name == this.name &&
          other.generationId == this.generationId &&
          other.sortOrder == this.sortOrder);
}

class VersionGroupsCompanion extends UpdateCompanion<VersionGroupRow> {
  final Value<int> id;
  final Value<String> name;
  final Value<int> generationId;
  final Value<int> sortOrder;
  const VersionGroupsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.generationId = const Value.absent(),
    this.sortOrder = const Value.absent(),
  });
  VersionGroupsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required int generationId,
    required int sortOrder,
  }) : name = Value(name),
       generationId = Value(generationId),
       sortOrder = Value(sortOrder);
  static Insertable<VersionGroupRow> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<int>? generationId,
    Expression<int>? sortOrder,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (generationId != null) 'generation_id': generationId,
      if (sortOrder != null) 'sort_order': sortOrder,
    });
  }

  VersionGroupsCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<int>? generationId,
    Value<int>? sortOrder,
  }) {
    return VersionGroupsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      generationId: generationId ?? this.generationId,
      sortOrder: sortOrder ?? this.sortOrder,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (generationId.present) {
      map['generation_id'] = Variable<int>(generationId.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('VersionGroupsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('generationId: $generationId, ')
          ..write('sortOrder: $sortOrder')
          ..write(')'))
        .toString();
  }
}

class $AbilitiesTable extends Abilities
    with TableInfo<$AbilitiesTable, AbilityRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AbilitiesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameEsMeta = const VerificationMeta('nameEs');
  @override
  late final GeneratedColumn<String> nameEs = GeneratedColumn<String>(
    'name_es',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameEnMeta = const VerificationMeta('nameEn');
  @override
  late final GeneratedColumn<String> nameEn = GeneratedColumn<String>(
    'name_en',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _effectEsMeta = const VerificationMeta(
    'effectEs',
  );
  @override
  late final GeneratedColumn<String> effectEs = GeneratedColumn<String>(
    'effect_es',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _effectEnMeta = const VerificationMeta(
    'effectEn',
  );
  @override
  late final GeneratedColumn<String> effectEn = GeneratedColumn<String>(
    'effect_en',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    nameEs,
    nameEn,
    effectEs,
    effectEn,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'abilities';
  @override
  VerificationContext validateIntegrity(
    Insertable<AbilityRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('name_es')) {
      context.handle(
        _nameEsMeta,
        nameEs.isAcceptableOrUnknown(data['name_es']!, _nameEsMeta),
      );
    } else if (isInserting) {
      context.missing(_nameEsMeta);
    }
    if (data.containsKey('name_en')) {
      context.handle(
        _nameEnMeta,
        nameEn.isAcceptableOrUnknown(data['name_en']!, _nameEnMeta),
      );
    } else if (isInserting) {
      context.missing(_nameEnMeta);
    }
    if (data.containsKey('effect_es')) {
      context.handle(
        _effectEsMeta,
        effectEs.isAcceptableOrUnknown(data['effect_es']!, _effectEsMeta),
      );
    }
    if (data.containsKey('effect_en')) {
      context.handle(
        _effectEnMeta,
        effectEn.isAcceptableOrUnknown(data['effect_en']!, _effectEnMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AbilityRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AbilityRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      nameEs: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name_es'],
      )!,
      nameEn: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name_en'],
      )!,
      effectEs: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}effect_es'],
      ),
      effectEn: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}effect_en'],
      ),
    );
  }

  @override
  $AbilitiesTable createAlias(String alias) {
    return $AbilitiesTable(attachedDatabase, alias);
  }
}

class AbilityRow extends DataClass implements Insertable<AbilityRow> {
  final int id;
  final String name;
  final String nameEs;
  final String nameEn;
  final String? effectEs;
  final String? effectEn;
  const AbilityRow({
    required this.id,
    required this.name,
    required this.nameEs,
    required this.nameEn,
    this.effectEs,
    this.effectEn,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['name_es'] = Variable<String>(nameEs);
    map['name_en'] = Variable<String>(nameEn);
    if (!nullToAbsent || effectEs != null) {
      map['effect_es'] = Variable<String>(effectEs);
    }
    if (!nullToAbsent || effectEn != null) {
      map['effect_en'] = Variable<String>(effectEn);
    }
    return map;
  }

  AbilitiesCompanion toCompanion(bool nullToAbsent) {
    return AbilitiesCompanion(
      id: Value(id),
      name: Value(name),
      nameEs: Value(nameEs),
      nameEn: Value(nameEn),
      effectEs: effectEs == null && nullToAbsent
          ? const Value.absent()
          : Value(effectEs),
      effectEn: effectEn == null && nullToAbsent
          ? const Value.absent()
          : Value(effectEn),
    );
  }

  factory AbilityRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AbilityRow(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      nameEs: serializer.fromJson<String>(json['nameEs']),
      nameEn: serializer.fromJson<String>(json['nameEn']),
      effectEs: serializer.fromJson<String?>(json['effectEs']),
      effectEn: serializer.fromJson<String?>(json['effectEn']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'nameEs': serializer.toJson<String>(nameEs),
      'nameEn': serializer.toJson<String>(nameEn),
      'effectEs': serializer.toJson<String?>(effectEs),
      'effectEn': serializer.toJson<String?>(effectEn),
    };
  }

  AbilityRow copyWith({
    int? id,
    String? name,
    String? nameEs,
    String? nameEn,
    Value<String?> effectEs = const Value.absent(),
    Value<String?> effectEn = const Value.absent(),
  }) => AbilityRow(
    id: id ?? this.id,
    name: name ?? this.name,
    nameEs: nameEs ?? this.nameEs,
    nameEn: nameEn ?? this.nameEn,
    effectEs: effectEs.present ? effectEs.value : this.effectEs,
    effectEn: effectEn.present ? effectEn.value : this.effectEn,
  );
  AbilityRow copyWithCompanion(AbilitiesCompanion data) {
    return AbilityRow(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      nameEs: data.nameEs.present ? data.nameEs.value : this.nameEs,
      nameEn: data.nameEn.present ? data.nameEn.value : this.nameEn,
      effectEs: data.effectEs.present ? data.effectEs.value : this.effectEs,
      effectEn: data.effectEn.present ? data.effectEn.value : this.effectEn,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AbilityRow(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('nameEs: $nameEs, ')
          ..write('nameEn: $nameEn, ')
          ..write('effectEs: $effectEs, ')
          ..write('effectEn: $effectEn')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, nameEs, nameEn, effectEs, effectEn);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AbilityRow &&
          other.id == this.id &&
          other.name == this.name &&
          other.nameEs == this.nameEs &&
          other.nameEn == this.nameEn &&
          other.effectEs == this.effectEs &&
          other.effectEn == this.effectEn);
}

class AbilitiesCompanion extends UpdateCompanion<AbilityRow> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> nameEs;
  final Value<String> nameEn;
  final Value<String?> effectEs;
  final Value<String?> effectEn;
  const AbilitiesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.nameEs = const Value.absent(),
    this.nameEn = const Value.absent(),
    this.effectEs = const Value.absent(),
    this.effectEn = const Value.absent(),
  });
  AbilitiesCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String nameEs,
    required String nameEn,
    this.effectEs = const Value.absent(),
    this.effectEn = const Value.absent(),
  }) : name = Value(name),
       nameEs = Value(nameEs),
       nameEn = Value(nameEn);
  static Insertable<AbilityRow> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? nameEs,
    Expression<String>? nameEn,
    Expression<String>? effectEs,
    Expression<String>? effectEn,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (nameEs != null) 'name_es': nameEs,
      if (nameEn != null) 'name_en': nameEn,
      if (effectEs != null) 'effect_es': effectEs,
      if (effectEn != null) 'effect_en': effectEn,
    });
  }

  AbilitiesCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String>? nameEs,
    Value<String>? nameEn,
    Value<String?>? effectEs,
    Value<String?>? effectEn,
  }) {
    return AbilitiesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      nameEs: nameEs ?? this.nameEs,
      nameEn: nameEn ?? this.nameEn,
      effectEs: effectEs ?? this.effectEs,
      effectEn: effectEn ?? this.effectEn,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (nameEs.present) {
      map['name_es'] = Variable<String>(nameEs.value);
    }
    if (nameEn.present) {
      map['name_en'] = Variable<String>(nameEn.value);
    }
    if (effectEs.present) {
      map['effect_es'] = Variable<String>(effectEs.value);
    }
    if (effectEn.present) {
      map['effect_en'] = Variable<String>(effectEn.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AbilitiesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('nameEs: $nameEs, ')
          ..write('nameEn: $nameEn, ')
          ..write('effectEs: $effectEs, ')
          ..write('effectEn: $effectEn')
          ..write(')'))
        .toString();
  }
}

class $PokemonAbilitiesTable extends PokemonAbilities
    with TableInfo<$PokemonAbilitiesTable, PokemonAbilityRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PokemonAbilitiesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _pokemonIdMeta = const VerificationMeta(
    'pokemonId',
  );
  @override
  late final GeneratedColumn<int> pokemonId = GeneratedColumn<int>(
    'pokemon_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _abilityIdMeta = const VerificationMeta(
    'abilityId',
  );
  @override
  late final GeneratedColumn<int> abilityId = GeneratedColumn<int>(
    'ability_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isHiddenMeta = const VerificationMeta(
    'isHidden',
  );
  @override
  late final GeneratedColumn<bool> isHidden = GeneratedColumn<bool>(
    'is_hidden',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_hidden" IN (0, 1))',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [pokemonId, abilityId, isHidden];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'pokemon_abilities';
  @override
  VerificationContext validateIntegrity(
    Insertable<PokemonAbilityRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('pokemon_id')) {
      context.handle(
        _pokemonIdMeta,
        pokemonId.isAcceptableOrUnknown(data['pokemon_id']!, _pokemonIdMeta),
      );
    } else if (isInserting) {
      context.missing(_pokemonIdMeta);
    }
    if (data.containsKey('ability_id')) {
      context.handle(
        _abilityIdMeta,
        abilityId.isAcceptableOrUnknown(data['ability_id']!, _abilityIdMeta),
      );
    } else if (isInserting) {
      context.missing(_abilityIdMeta);
    }
    if (data.containsKey('is_hidden')) {
      context.handle(
        _isHiddenMeta,
        isHidden.isAcceptableOrUnknown(data['is_hidden']!, _isHiddenMeta),
      );
    } else if (isInserting) {
      context.missing(_isHiddenMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {pokemonId, abilityId};
  @override
  PokemonAbilityRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PokemonAbilityRow(
      pokemonId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}pokemon_id'],
      )!,
      abilityId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}ability_id'],
      )!,
      isHidden: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_hidden'],
      )!,
    );
  }

  @override
  $PokemonAbilitiesTable createAlias(String alias) {
    return $PokemonAbilitiesTable(attachedDatabase, alias);
  }
}

class PokemonAbilityRow extends DataClass
    implements Insertable<PokemonAbilityRow> {
  final int pokemonId;
  final int abilityId;
  final bool isHidden;
  const PokemonAbilityRow({
    required this.pokemonId,
    required this.abilityId,
    required this.isHidden,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['pokemon_id'] = Variable<int>(pokemonId);
    map['ability_id'] = Variable<int>(abilityId);
    map['is_hidden'] = Variable<bool>(isHidden);
    return map;
  }

  PokemonAbilitiesCompanion toCompanion(bool nullToAbsent) {
    return PokemonAbilitiesCompanion(
      pokemonId: Value(pokemonId),
      abilityId: Value(abilityId),
      isHidden: Value(isHidden),
    );
  }

  factory PokemonAbilityRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PokemonAbilityRow(
      pokemonId: serializer.fromJson<int>(json['pokemonId']),
      abilityId: serializer.fromJson<int>(json['abilityId']),
      isHidden: serializer.fromJson<bool>(json['isHidden']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'pokemonId': serializer.toJson<int>(pokemonId),
      'abilityId': serializer.toJson<int>(abilityId),
      'isHidden': serializer.toJson<bool>(isHidden),
    };
  }

  PokemonAbilityRow copyWith({
    int? pokemonId,
    int? abilityId,
    bool? isHidden,
  }) => PokemonAbilityRow(
    pokemonId: pokemonId ?? this.pokemonId,
    abilityId: abilityId ?? this.abilityId,
    isHidden: isHidden ?? this.isHidden,
  );
  PokemonAbilityRow copyWithCompanion(PokemonAbilitiesCompanion data) {
    return PokemonAbilityRow(
      pokemonId: data.pokemonId.present ? data.pokemonId.value : this.pokemonId,
      abilityId: data.abilityId.present ? data.abilityId.value : this.abilityId,
      isHidden: data.isHidden.present ? data.isHidden.value : this.isHidden,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PokemonAbilityRow(')
          ..write('pokemonId: $pokemonId, ')
          ..write('abilityId: $abilityId, ')
          ..write('isHidden: $isHidden')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(pokemonId, abilityId, isHidden);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PokemonAbilityRow &&
          other.pokemonId == this.pokemonId &&
          other.abilityId == this.abilityId &&
          other.isHidden == this.isHidden);
}

class PokemonAbilitiesCompanion extends UpdateCompanion<PokemonAbilityRow> {
  final Value<int> pokemonId;
  final Value<int> abilityId;
  final Value<bool> isHidden;
  final Value<int> rowid;
  const PokemonAbilitiesCompanion({
    this.pokemonId = const Value.absent(),
    this.abilityId = const Value.absent(),
    this.isHidden = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PokemonAbilitiesCompanion.insert({
    required int pokemonId,
    required int abilityId,
    required bool isHidden,
    this.rowid = const Value.absent(),
  }) : pokemonId = Value(pokemonId),
       abilityId = Value(abilityId),
       isHidden = Value(isHidden);
  static Insertable<PokemonAbilityRow> custom({
    Expression<int>? pokemonId,
    Expression<int>? abilityId,
    Expression<bool>? isHidden,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (pokemonId != null) 'pokemon_id': pokemonId,
      if (abilityId != null) 'ability_id': abilityId,
      if (isHidden != null) 'is_hidden': isHidden,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PokemonAbilitiesCompanion copyWith({
    Value<int>? pokemonId,
    Value<int>? abilityId,
    Value<bool>? isHidden,
    Value<int>? rowid,
  }) {
    return PokemonAbilitiesCompanion(
      pokemonId: pokemonId ?? this.pokemonId,
      abilityId: abilityId ?? this.abilityId,
      isHidden: isHidden ?? this.isHidden,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (pokemonId.present) {
      map['pokemon_id'] = Variable<int>(pokemonId.value);
    }
    if (abilityId.present) {
      map['ability_id'] = Variable<int>(abilityId.value);
    }
    if (isHidden.present) {
      map['is_hidden'] = Variable<bool>(isHidden.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PokemonAbilitiesCompanion(')
          ..write('pokemonId: $pokemonId, ')
          ..write('abilityId: $abilityId, ')
          ..write('isHidden: $isHidden, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $MovesTable extends Moves with TableInfo<$MovesTable, MoveRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MovesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _powerMeta = const VerificationMeta('power');
  @override
  late final GeneratedColumn<int> power = GeneratedColumn<int>(
    'power',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _accuracyMeta = const VerificationMeta(
    'accuracy',
  );
  @override
  late final GeneratedColumn<int> accuracy = GeneratedColumn<int>(
    'accuracy',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _ppMeta = const VerificationMeta('pp');
  @override
  late final GeneratedColumn<int> pp = GeneratedColumn<int>(
    'pp',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _typeIdMeta = const VerificationMeta('typeId');
  @override
  late final GeneratedColumn<int> typeId = GeneratedColumn<int>(
    'type_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _damageClassIdMeta = const VerificationMeta(
    'damageClassId',
  );
  @override
  late final GeneratedColumn<int> damageClassId = GeneratedColumn<int>(
    'damage_class_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    power,
    accuracy,
    pp,
    typeId,
    damageClassId,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'moves';
  @override
  VerificationContext validateIntegrity(
    Insertable<MoveRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('power')) {
      context.handle(
        _powerMeta,
        power.isAcceptableOrUnknown(data['power']!, _powerMeta),
      );
    }
    if (data.containsKey('accuracy')) {
      context.handle(
        _accuracyMeta,
        accuracy.isAcceptableOrUnknown(data['accuracy']!, _accuracyMeta),
      );
    }
    if (data.containsKey('pp')) {
      context.handle(_ppMeta, pp.isAcceptableOrUnknown(data['pp']!, _ppMeta));
    }
    if (data.containsKey('type_id')) {
      context.handle(
        _typeIdMeta,
        typeId.isAcceptableOrUnknown(data['type_id']!, _typeIdMeta),
      );
    } else if (isInserting) {
      context.missing(_typeIdMeta);
    }
    if (data.containsKey('damage_class_id')) {
      context.handle(
        _damageClassIdMeta,
        damageClassId.isAcceptableOrUnknown(
          data['damage_class_id']!,
          _damageClassIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_damageClassIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MoveRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MoveRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      power: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}power'],
      ),
      accuracy: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}accuracy'],
      ),
      pp: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}pp'],
      ),
      typeId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}type_id'],
      )!,
      damageClassId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}damage_class_id'],
      )!,
    );
  }

  @override
  $MovesTable createAlias(String alias) {
    return $MovesTable(attachedDatabase, alias);
  }
}

class MoveRow extends DataClass implements Insertable<MoveRow> {
  final int id;
  final String name;
  final int? power;
  final int? accuracy;
  final int? pp;
  final int typeId;

  /// 1 estado, 2 físico, 3 especial.
  final int damageClassId;
  const MoveRow({
    required this.id,
    required this.name,
    this.power,
    this.accuracy,
    this.pp,
    required this.typeId,
    required this.damageClassId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || power != null) {
      map['power'] = Variable<int>(power);
    }
    if (!nullToAbsent || accuracy != null) {
      map['accuracy'] = Variable<int>(accuracy);
    }
    if (!nullToAbsent || pp != null) {
      map['pp'] = Variable<int>(pp);
    }
    map['type_id'] = Variable<int>(typeId);
    map['damage_class_id'] = Variable<int>(damageClassId);
    return map;
  }

  MovesCompanion toCompanion(bool nullToAbsent) {
    return MovesCompanion(
      id: Value(id),
      name: Value(name),
      power: power == null && nullToAbsent
          ? const Value.absent()
          : Value(power),
      accuracy: accuracy == null && nullToAbsent
          ? const Value.absent()
          : Value(accuracy),
      pp: pp == null && nullToAbsent ? const Value.absent() : Value(pp),
      typeId: Value(typeId),
      damageClassId: Value(damageClassId),
    );
  }

  factory MoveRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MoveRow(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      power: serializer.fromJson<int?>(json['power']),
      accuracy: serializer.fromJson<int?>(json['accuracy']),
      pp: serializer.fromJson<int?>(json['pp']),
      typeId: serializer.fromJson<int>(json['typeId']),
      damageClassId: serializer.fromJson<int>(json['damageClassId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'power': serializer.toJson<int?>(power),
      'accuracy': serializer.toJson<int?>(accuracy),
      'pp': serializer.toJson<int?>(pp),
      'typeId': serializer.toJson<int>(typeId),
      'damageClassId': serializer.toJson<int>(damageClassId),
    };
  }

  MoveRow copyWith({
    int? id,
    String? name,
    Value<int?> power = const Value.absent(),
    Value<int?> accuracy = const Value.absent(),
    Value<int?> pp = const Value.absent(),
    int? typeId,
    int? damageClassId,
  }) => MoveRow(
    id: id ?? this.id,
    name: name ?? this.name,
    power: power.present ? power.value : this.power,
    accuracy: accuracy.present ? accuracy.value : this.accuracy,
    pp: pp.present ? pp.value : this.pp,
    typeId: typeId ?? this.typeId,
    damageClassId: damageClassId ?? this.damageClassId,
  );
  MoveRow copyWithCompanion(MovesCompanion data) {
    return MoveRow(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      power: data.power.present ? data.power.value : this.power,
      accuracy: data.accuracy.present ? data.accuracy.value : this.accuracy,
      pp: data.pp.present ? data.pp.value : this.pp,
      typeId: data.typeId.present ? data.typeId.value : this.typeId,
      damageClassId: data.damageClassId.present
          ? data.damageClassId.value
          : this.damageClassId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MoveRow(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('power: $power, ')
          ..write('accuracy: $accuracy, ')
          ..write('pp: $pp, ')
          ..write('typeId: $typeId, ')
          ..write('damageClassId: $damageClassId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, name, power, accuracy, pp, typeId, damageClassId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MoveRow &&
          other.id == this.id &&
          other.name == this.name &&
          other.power == this.power &&
          other.accuracy == this.accuracy &&
          other.pp == this.pp &&
          other.typeId == this.typeId &&
          other.damageClassId == this.damageClassId);
}

class MovesCompanion extends UpdateCompanion<MoveRow> {
  final Value<int> id;
  final Value<String> name;
  final Value<int?> power;
  final Value<int?> accuracy;
  final Value<int?> pp;
  final Value<int> typeId;
  final Value<int> damageClassId;
  const MovesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.power = const Value.absent(),
    this.accuracy = const Value.absent(),
    this.pp = const Value.absent(),
    this.typeId = const Value.absent(),
    this.damageClassId = const Value.absent(),
  });
  MovesCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.power = const Value.absent(),
    this.accuracy = const Value.absent(),
    this.pp = const Value.absent(),
    required int typeId,
    required int damageClassId,
  }) : name = Value(name),
       typeId = Value(typeId),
       damageClassId = Value(damageClassId);
  static Insertable<MoveRow> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<int>? power,
    Expression<int>? accuracy,
    Expression<int>? pp,
    Expression<int>? typeId,
    Expression<int>? damageClassId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (power != null) 'power': power,
      if (accuracy != null) 'accuracy': accuracy,
      if (pp != null) 'pp': pp,
      if (typeId != null) 'type_id': typeId,
      if (damageClassId != null) 'damage_class_id': damageClassId,
    });
  }

  MovesCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<int?>? power,
    Value<int?>? accuracy,
    Value<int?>? pp,
    Value<int>? typeId,
    Value<int>? damageClassId,
  }) {
    return MovesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      power: power ?? this.power,
      accuracy: accuracy ?? this.accuracy,
      pp: pp ?? this.pp,
      typeId: typeId ?? this.typeId,
      damageClassId: damageClassId ?? this.damageClassId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (power.present) {
      map['power'] = Variable<int>(power.value);
    }
    if (accuracy.present) {
      map['accuracy'] = Variable<int>(accuracy.value);
    }
    if (pp.present) {
      map['pp'] = Variable<int>(pp.value);
    }
    if (typeId.present) {
      map['type_id'] = Variable<int>(typeId.value);
    }
    if (damageClassId.present) {
      map['damage_class_id'] = Variable<int>(damageClassId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MovesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('power: $power, ')
          ..write('accuracy: $accuracy, ')
          ..write('pp: $pp, ')
          ..write('typeId: $typeId, ')
          ..write('damageClassId: $damageClassId')
          ..write(')'))
        .toString();
  }
}

class $PokemonMovesTable extends PokemonMoves
    with TableInfo<$PokemonMovesTable, PokemonMoveRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PokemonMovesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _pokemonIdMeta = const VerificationMeta(
    'pokemonId',
  );
  @override
  late final GeneratedColumn<int> pokemonId = GeneratedColumn<int>(
    'pokemon_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _moveIdMeta = const VerificationMeta('moveId');
  @override
  late final GeneratedColumn<int> moveId = GeneratedColumn<int>(
    'move_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _versionGroupIdMeta = const VerificationMeta(
    'versionGroupId',
  );
  @override
  late final GeneratedColumn<int> versionGroupId = GeneratedColumn<int>(
    'version_group_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _methodIdMeta = const VerificationMeta(
    'methodId',
  );
  @override
  late final GeneratedColumn<int> methodId = GeneratedColumn<int>(
    'method_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _levelMeta = const VerificationMeta('level');
  @override
  late final GeneratedColumn<int> level = GeneratedColumn<int>(
    'level',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    pokemonId,
    moveId,
    versionGroupId,
    methodId,
    level,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'pokemon_moves';
  @override
  VerificationContext validateIntegrity(
    Insertable<PokemonMoveRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('pokemon_id')) {
      context.handle(
        _pokemonIdMeta,
        pokemonId.isAcceptableOrUnknown(data['pokemon_id']!, _pokemonIdMeta),
      );
    } else if (isInserting) {
      context.missing(_pokemonIdMeta);
    }
    if (data.containsKey('move_id')) {
      context.handle(
        _moveIdMeta,
        moveId.isAcceptableOrUnknown(data['move_id']!, _moveIdMeta),
      );
    } else if (isInserting) {
      context.missing(_moveIdMeta);
    }
    if (data.containsKey('version_group_id')) {
      context.handle(
        _versionGroupIdMeta,
        versionGroupId.isAcceptableOrUnknown(
          data['version_group_id']!,
          _versionGroupIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_versionGroupIdMeta);
    }
    if (data.containsKey('method_id')) {
      context.handle(
        _methodIdMeta,
        methodId.isAcceptableOrUnknown(data['method_id']!, _methodIdMeta),
      );
    } else if (isInserting) {
      context.missing(_methodIdMeta);
    }
    if (data.containsKey('level')) {
      context.handle(
        _levelMeta,
        level.isAcceptableOrUnknown(data['level']!, _levelMeta),
      );
    } else if (isInserting) {
      context.missing(_levelMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {
    pokemonId,
    moveId,
    versionGroupId,
    methodId,
    level,
  };
  @override
  PokemonMoveRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PokemonMoveRow(
      pokemonId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}pokemon_id'],
      )!,
      moveId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}move_id'],
      )!,
      versionGroupId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}version_group_id'],
      )!,
      methodId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}method_id'],
      )!,
      level: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}level'],
      )!,
    );
  }

  @override
  $PokemonMovesTable createAlias(String alias) {
    return $PokemonMovesTable(attachedDatabase, alias);
  }
}

class PokemonMoveRow extends DataClass implements Insertable<PokemonMoveRow> {
  final int pokemonId;
  final int moveId;
  final int versionGroupId;

  /// 1 nivel, 2 huevo, 3 tutor, 4 (MT).
  final int methodId;
  final int level;
  const PokemonMoveRow({
    required this.pokemonId,
    required this.moveId,
    required this.versionGroupId,
    required this.methodId,
    required this.level,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['pokemon_id'] = Variable<int>(pokemonId);
    map['move_id'] = Variable<int>(moveId);
    map['version_group_id'] = Variable<int>(versionGroupId);
    map['method_id'] = Variable<int>(methodId);
    map['level'] = Variable<int>(level);
    return map;
  }

  PokemonMovesCompanion toCompanion(bool nullToAbsent) {
    return PokemonMovesCompanion(
      pokemonId: Value(pokemonId),
      moveId: Value(moveId),
      versionGroupId: Value(versionGroupId),
      methodId: Value(methodId),
      level: Value(level),
    );
  }

  factory PokemonMoveRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PokemonMoveRow(
      pokemonId: serializer.fromJson<int>(json['pokemonId']),
      moveId: serializer.fromJson<int>(json['moveId']),
      versionGroupId: serializer.fromJson<int>(json['versionGroupId']),
      methodId: serializer.fromJson<int>(json['methodId']),
      level: serializer.fromJson<int>(json['level']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'pokemonId': serializer.toJson<int>(pokemonId),
      'moveId': serializer.toJson<int>(moveId),
      'versionGroupId': serializer.toJson<int>(versionGroupId),
      'methodId': serializer.toJson<int>(methodId),
      'level': serializer.toJson<int>(level),
    };
  }

  PokemonMoveRow copyWith({
    int? pokemonId,
    int? moveId,
    int? versionGroupId,
    int? methodId,
    int? level,
  }) => PokemonMoveRow(
    pokemonId: pokemonId ?? this.pokemonId,
    moveId: moveId ?? this.moveId,
    versionGroupId: versionGroupId ?? this.versionGroupId,
    methodId: methodId ?? this.methodId,
    level: level ?? this.level,
  );
  PokemonMoveRow copyWithCompanion(PokemonMovesCompanion data) {
    return PokemonMoveRow(
      pokemonId: data.pokemonId.present ? data.pokemonId.value : this.pokemonId,
      moveId: data.moveId.present ? data.moveId.value : this.moveId,
      versionGroupId: data.versionGroupId.present
          ? data.versionGroupId.value
          : this.versionGroupId,
      methodId: data.methodId.present ? data.methodId.value : this.methodId,
      level: data.level.present ? data.level.value : this.level,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PokemonMoveRow(')
          ..write('pokemonId: $pokemonId, ')
          ..write('moveId: $moveId, ')
          ..write('versionGroupId: $versionGroupId, ')
          ..write('methodId: $methodId, ')
          ..write('level: $level')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(pokemonId, moveId, versionGroupId, methodId, level);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PokemonMoveRow &&
          other.pokemonId == this.pokemonId &&
          other.moveId == this.moveId &&
          other.versionGroupId == this.versionGroupId &&
          other.methodId == this.methodId &&
          other.level == this.level);
}

class PokemonMovesCompanion extends UpdateCompanion<PokemonMoveRow> {
  final Value<int> pokemonId;
  final Value<int> moveId;
  final Value<int> versionGroupId;
  final Value<int> methodId;
  final Value<int> level;
  final Value<int> rowid;
  const PokemonMovesCompanion({
    this.pokemonId = const Value.absent(),
    this.moveId = const Value.absent(),
    this.versionGroupId = const Value.absent(),
    this.methodId = const Value.absent(),
    this.level = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PokemonMovesCompanion.insert({
    required int pokemonId,
    required int moveId,
    required int versionGroupId,
    required int methodId,
    required int level,
    this.rowid = const Value.absent(),
  }) : pokemonId = Value(pokemonId),
       moveId = Value(moveId),
       versionGroupId = Value(versionGroupId),
       methodId = Value(methodId),
       level = Value(level);
  static Insertable<PokemonMoveRow> custom({
    Expression<int>? pokemonId,
    Expression<int>? moveId,
    Expression<int>? versionGroupId,
    Expression<int>? methodId,
    Expression<int>? level,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (pokemonId != null) 'pokemon_id': pokemonId,
      if (moveId != null) 'move_id': moveId,
      if (versionGroupId != null) 'version_group_id': versionGroupId,
      if (methodId != null) 'method_id': methodId,
      if (level != null) 'level': level,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PokemonMovesCompanion copyWith({
    Value<int>? pokemonId,
    Value<int>? moveId,
    Value<int>? versionGroupId,
    Value<int>? methodId,
    Value<int>? level,
    Value<int>? rowid,
  }) {
    return PokemonMovesCompanion(
      pokemonId: pokemonId ?? this.pokemonId,
      moveId: moveId ?? this.moveId,
      versionGroupId: versionGroupId ?? this.versionGroupId,
      methodId: methodId ?? this.methodId,
      level: level ?? this.level,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (pokemonId.present) {
      map['pokemon_id'] = Variable<int>(pokemonId.value);
    }
    if (moveId.present) {
      map['move_id'] = Variable<int>(moveId.value);
    }
    if (versionGroupId.present) {
      map['version_group_id'] = Variable<int>(versionGroupId.value);
    }
    if (methodId.present) {
      map['method_id'] = Variable<int>(methodId.value);
    }
    if (level.present) {
      map['level'] = Variable<int>(level.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PokemonMovesCompanion(')
          ..write('pokemonId: $pokemonId, ')
          ..write('moveId: $moveId, ')
          ..write('versionGroupId: $versionGroupId, ')
          ..write('methodId: $methodId, ')
          ..write('level: $level, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $EvolutionsTable extends Evolutions
    with TableInfo<$EvolutionsTable, EvolutionRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $EvolutionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _speciesIdMeta = const VerificationMeta(
    'speciesId',
  );
  @override
  late final GeneratedColumn<int> speciesId = GeneratedColumn<int>(
    'species_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _chainIdMeta = const VerificationMeta(
    'chainId',
  );
  @override
  late final GeneratedColumn<int> chainId = GeneratedColumn<int>(
    'chain_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _fromSpeciesIdMeta = const VerificationMeta(
    'fromSpeciesId',
  );
  @override
  late final GeneratedColumn<int> fromSpeciesId = GeneratedColumn<int>(
    'from_species_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _triggerMeta = const VerificationMeta(
    'trigger',
  );
  @override
  late final GeneratedColumn<String> trigger = GeneratedColumn<String>(
    'trigger',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _minLevelMeta = const VerificationMeta(
    'minLevel',
  );
  @override
  late final GeneratedColumn<int> minLevel = GeneratedColumn<int>(
    'min_level',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _itemMeta = const VerificationMeta('item');
  @override
  late final GeneratedColumn<String> item = GeneratedColumn<String>(
    'item',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _minHappinessMeta = const VerificationMeta(
    'minHappiness',
  );
  @override
  late final GeneratedColumn<int> minHappiness = GeneratedColumn<int>(
    'min_happiness',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _timeOfDayMeta = const VerificationMeta(
    'timeOfDay',
  );
  @override
  late final GeneratedColumn<String> timeOfDay = GeneratedColumn<String>(
    'time_of_day',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    speciesId,
    chainId,
    fromSpeciesId,
    name,
    trigger,
    minLevel,
    item,
    minHappiness,
    timeOfDay,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'evolutions';
  @override
  VerificationContext validateIntegrity(
    Insertable<EvolutionRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('species_id')) {
      context.handle(
        _speciesIdMeta,
        speciesId.isAcceptableOrUnknown(data['species_id']!, _speciesIdMeta),
      );
    }
    if (data.containsKey('chain_id')) {
      context.handle(
        _chainIdMeta,
        chainId.isAcceptableOrUnknown(data['chain_id']!, _chainIdMeta),
      );
    } else if (isInserting) {
      context.missing(_chainIdMeta);
    }
    if (data.containsKey('from_species_id')) {
      context.handle(
        _fromSpeciesIdMeta,
        fromSpeciesId.isAcceptableOrUnknown(
          data['from_species_id']!,
          _fromSpeciesIdMeta,
        ),
      );
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('trigger')) {
      context.handle(
        _triggerMeta,
        trigger.isAcceptableOrUnknown(data['trigger']!, _triggerMeta),
      );
    }
    if (data.containsKey('min_level')) {
      context.handle(
        _minLevelMeta,
        minLevel.isAcceptableOrUnknown(data['min_level']!, _minLevelMeta),
      );
    }
    if (data.containsKey('item')) {
      context.handle(
        _itemMeta,
        item.isAcceptableOrUnknown(data['item']!, _itemMeta),
      );
    }
    if (data.containsKey('min_happiness')) {
      context.handle(
        _minHappinessMeta,
        minHappiness.isAcceptableOrUnknown(
          data['min_happiness']!,
          _minHappinessMeta,
        ),
      );
    }
    if (data.containsKey('time_of_day')) {
      context.handle(
        _timeOfDayMeta,
        timeOfDay.isAcceptableOrUnknown(data['time_of_day']!, _timeOfDayMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {speciesId};
  @override
  EvolutionRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return EvolutionRow(
      speciesId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}species_id'],
      )!,
      chainId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}chain_id'],
      )!,
      fromSpeciesId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}from_species_id'],
      ),
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      trigger: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}trigger'],
      ),
      minLevel: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}min_level'],
      ),
      item: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}item'],
      ),
      minHappiness: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}min_happiness'],
      ),
      timeOfDay: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}time_of_day'],
      ),
    );
  }

  @override
  $EvolutionsTable createAlias(String alias) {
    return $EvolutionsTable(attachedDatabase, alias);
  }
}

class EvolutionRow extends DataClass implements Insertable<EvolutionRow> {
  final int speciesId;
  final int chainId;
  final int? fromSpeciesId;
  final String name;
  final String? trigger;
  final int? minLevel;
  final String? item;
  final int? minHappiness;
  final String? timeOfDay;
  const EvolutionRow({
    required this.speciesId,
    required this.chainId,
    this.fromSpeciesId,
    required this.name,
    this.trigger,
    this.minLevel,
    this.item,
    this.minHappiness,
    this.timeOfDay,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['species_id'] = Variable<int>(speciesId);
    map['chain_id'] = Variable<int>(chainId);
    if (!nullToAbsent || fromSpeciesId != null) {
      map['from_species_id'] = Variable<int>(fromSpeciesId);
    }
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || trigger != null) {
      map['trigger'] = Variable<String>(trigger);
    }
    if (!nullToAbsent || minLevel != null) {
      map['min_level'] = Variable<int>(minLevel);
    }
    if (!nullToAbsent || item != null) {
      map['item'] = Variable<String>(item);
    }
    if (!nullToAbsent || minHappiness != null) {
      map['min_happiness'] = Variable<int>(minHappiness);
    }
    if (!nullToAbsent || timeOfDay != null) {
      map['time_of_day'] = Variable<String>(timeOfDay);
    }
    return map;
  }

  EvolutionsCompanion toCompanion(bool nullToAbsent) {
    return EvolutionsCompanion(
      speciesId: Value(speciesId),
      chainId: Value(chainId),
      fromSpeciesId: fromSpeciesId == null && nullToAbsent
          ? const Value.absent()
          : Value(fromSpeciesId),
      name: Value(name),
      trigger: trigger == null && nullToAbsent
          ? const Value.absent()
          : Value(trigger),
      minLevel: minLevel == null && nullToAbsent
          ? const Value.absent()
          : Value(minLevel),
      item: item == null && nullToAbsent ? const Value.absent() : Value(item),
      minHappiness: minHappiness == null && nullToAbsent
          ? const Value.absent()
          : Value(minHappiness),
      timeOfDay: timeOfDay == null && nullToAbsent
          ? const Value.absent()
          : Value(timeOfDay),
    );
  }

  factory EvolutionRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return EvolutionRow(
      speciesId: serializer.fromJson<int>(json['speciesId']),
      chainId: serializer.fromJson<int>(json['chainId']),
      fromSpeciesId: serializer.fromJson<int?>(json['fromSpeciesId']),
      name: serializer.fromJson<String>(json['name']),
      trigger: serializer.fromJson<String?>(json['trigger']),
      minLevel: serializer.fromJson<int?>(json['minLevel']),
      item: serializer.fromJson<String?>(json['item']),
      minHappiness: serializer.fromJson<int?>(json['minHappiness']),
      timeOfDay: serializer.fromJson<String?>(json['timeOfDay']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'speciesId': serializer.toJson<int>(speciesId),
      'chainId': serializer.toJson<int>(chainId),
      'fromSpeciesId': serializer.toJson<int?>(fromSpeciesId),
      'name': serializer.toJson<String>(name),
      'trigger': serializer.toJson<String?>(trigger),
      'minLevel': serializer.toJson<int?>(minLevel),
      'item': serializer.toJson<String?>(item),
      'minHappiness': serializer.toJson<int?>(minHappiness),
      'timeOfDay': serializer.toJson<String?>(timeOfDay),
    };
  }

  EvolutionRow copyWith({
    int? speciesId,
    int? chainId,
    Value<int?> fromSpeciesId = const Value.absent(),
    String? name,
    Value<String?> trigger = const Value.absent(),
    Value<int?> minLevel = const Value.absent(),
    Value<String?> item = const Value.absent(),
    Value<int?> minHappiness = const Value.absent(),
    Value<String?> timeOfDay = const Value.absent(),
  }) => EvolutionRow(
    speciesId: speciesId ?? this.speciesId,
    chainId: chainId ?? this.chainId,
    fromSpeciesId: fromSpeciesId.present
        ? fromSpeciesId.value
        : this.fromSpeciesId,
    name: name ?? this.name,
    trigger: trigger.present ? trigger.value : this.trigger,
    minLevel: minLevel.present ? minLevel.value : this.minLevel,
    item: item.present ? item.value : this.item,
    minHappiness: minHappiness.present ? minHappiness.value : this.minHappiness,
    timeOfDay: timeOfDay.present ? timeOfDay.value : this.timeOfDay,
  );
  EvolutionRow copyWithCompanion(EvolutionsCompanion data) {
    return EvolutionRow(
      speciesId: data.speciesId.present ? data.speciesId.value : this.speciesId,
      chainId: data.chainId.present ? data.chainId.value : this.chainId,
      fromSpeciesId: data.fromSpeciesId.present
          ? data.fromSpeciesId.value
          : this.fromSpeciesId,
      name: data.name.present ? data.name.value : this.name,
      trigger: data.trigger.present ? data.trigger.value : this.trigger,
      minLevel: data.minLevel.present ? data.minLevel.value : this.minLevel,
      item: data.item.present ? data.item.value : this.item,
      minHappiness: data.minHappiness.present
          ? data.minHappiness.value
          : this.minHappiness,
      timeOfDay: data.timeOfDay.present ? data.timeOfDay.value : this.timeOfDay,
    );
  }

  @override
  String toString() {
    return (StringBuffer('EvolutionRow(')
          ..write('speciesId: $speciesId, ')
          ..write('chainId: $chainId, ')
          ..write('fromSpeciesId: $fromSpeciesId, ')
          ..write('name: $name, ')
          ..write('trigger: $trigger, ')
          ..write('minLevel: $minLevel, ')
          ..write('item: $item, ')
          ..write('minHappiness: $minHappiness, ')
          ..write('timeOfDay: $timeOfDay')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    speciesId,
    chainId,
    fromSpeciesId,
    name,
    trigger,
    minLevel,
    item,
    minHappiness,
    timeOfDay,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is EvolutionRow &&
          other.speciesId == this.speciesId &&
          other.chainId == this.chainId &&
          other.fromSpeciesId == this.fromSpeciesId &&
          other.name == this.name &&
          other.trigger == this.trigger &&
          other.minLevel == this.minLevel &&
          other.item == this.item &&
          other.minHappiness == this.minHappiness &&
          other.timeOfDay == this.timeOfDay);
}

class EvolutionsCompanion extends UpdateCompanion<EvolutionRow> {
  final Value<int> speciesId;
  final Value<int> chainId;
  final Value<int?> fromSpeciesId;
  final Value<String> name;
  final Value<String?> trigger;
  final Value<int?> minLevel;
  final Value<String?> item;
  final Value<int?> minHappiness;
  final Value<String?> timeOfDay;
  const EvolutionsCompanion({
    this.speciesId = const Value.absent(),
    this.chainId = const Value.absent(),
    this.fromSpeciesId = const Value.absent(),
    this.name = const Value.absent(),
    this.trigger = const Value.absent(),
    this.minLevel = const Value.absent(),
    this.item = const Value.absent(),
    this.minHappiness = const Value.absent(),
    this.timeOfDay = const Value.absent(),
  });
  EvolutionsCompanion.insert({
    this.speciesId = const Value.absent(),
    required int chainId,
    this.fromSpeciesId = const Value.absent(),
    required String name,
    this.trigger = const Value.absent(),
    this.minLevel = const Value.absent(),
    this.item = const Value.absent(),
    this.minHappiness = const Value.absent(),
    this.timeOfDay = const Value.absent(),
  }) : chainId = Value(chainId),
       name = Value(name);
  static Insertable<EvolutionRow> custom({
    Expression<int>? speciesId,
    Expression<int>? chainId,
    Expression<int>? fromSpeciesId,
    Expression<String>? name,
    Expression<String>? trigger,
    Expression<int>? minLevel,
    Expression<String>? item,
    Expression<int>? minHappiness,
    Expression<String>? timeOfDay,
  }) {
    return RawValuesInsertable({
      if (speciesId != null) 'species_id': speciesId,
      if (chainId != null) 'chain_id': chainId,
      if (fromSpeciesId != null) 'from_species_id': fromSpeciesId,
      if (name != null) 'name': name,
      if (trigger != null) 'trigger': trigger,
      if (minLevel != null) 'min_level': minLevel,
      if (item != null) 'item': item,
      if (minHappiness != null) 'min_happiness': minHappiness,
      if (timeOfDay != null) 'time_of_day': timeOfDay,
    });
  }

  EvolutionsCompanion copyWith({
    Value<int>? speciesId,
    Value<int>? chainId,
    Value<int?>? fromSpeciesId,
    Value<String>? name,
    Value<String?>? trigger,
    Value<int?>? minLevel,
    Value<String?>? item,
    Value<int?>? minHappiness,
    Value<String?>? timeOfDay,
  }) {
    return EvolutionsCompanion(
      speciesId: speciesId ?? this.speciesId,
      chainId: chainId ?? this.chainId,
      fromSpeciesId: fromSpeciesId ?? this.fromSpeciesId,
      name: name ?? this.name,
      trigger: trigger ?? this.trigger,
      minLevel: minLevel ?? this.minLevel,
      item: item ?? this.item,
      minHappiness: minHappiness ?? this.minHappiness,
      timeOfDay: timeOfDay ?? this.timeOfDay,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (speciesId.present) {
      map['species_id'] = Variable<int>(speciesId.value);
    }
    if (chainId.present) {
      map['chain_id'] = Variable<int>(chainId.value);
    }
    if (fromSpeciesId.present) {
      map['from_species_id'] = Variable<int>(fromSpeciesId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (trigger.present) {
      map['trigger'] = Variable<String>(trigger.value);
    }
    if (minLevel.present) {
      map['min_level'] = Variable<int>(minLevel.value);
    }
    if (item.present) {
      map['item'] = Variable<String>(item.value);
    }
    if (minHappiness.present) {
      map['min_happiness'] = Variable<int>(minHappiness.value);
    }
    if (timeOfDay.present) {
      map['time_of_day'] = Variable<String>(timeOfDay.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EvolutionsCompanion(')
          ..write('speciesId: $speciesId, ')
          ..write('chainId: $chainId, ')
          ..write('fromSpeciesId: $fromSpeciesId, ')
          ..write('name: $name, ')
          ..write('trigger: $trigger, ')
          ..write('minLevel: $minLevel, ')
          ..write('item: $item, ')
          ..write('minHappiness: $minHappiness, ')
          ..write('timeOfDay: $timeOfDay')
          ..write(')'))
        .toString();
  }
}

class $FavoritesTable extends Favorites
    with TableInfo<$FavoritesTable, FavoriteRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FavoritesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _pokemonIdMeta = const VerificationMeta(
    'pokemonId',
  );
  @override
  late final GeneratedColumn<int> pokemonId = GeneratedColumn<int>(
    'pokemon_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _addedAtMeta = const VerificationMeta(
    'addedAt',
  );
  @override
  late final GeneratedColumn<DateTime> addedAt = GeneratedColumn<DateTime>(
    'added_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [pokemonId, addedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'favorites';
  @override
  VerificationContext validateIntegrity(
    Insertable<FavoriteRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('pokemon_id')) {
      context.handle(
        _pokemonIdMeta,
        pokemonId.isAcceptableOrUnknown(data['pokemon_id']!, _pokemonIdMeta),
      );
    }
    if (data.containsKey('added_at')) {
      context.handle(
        _addedAtMeta,
        addedAt.isAcceptableOrUnknown(data['added_at']!, _addedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_addedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {pokemonId};
  @override
  FavoriteRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FavoriteRow(
      pokemonId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}pokemon_id'],
      )!,
      addedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}added_at'],
      )!,
    );
  }

  @override
  $FavoritesTable createAlias(String alias) {
    return $FavoritesTable(attachedDatabase, alias);
  }
}

class FavoriteRow extends DataClass implements Insertable<FavoriteRow> {
  final int pokemonId;
  final DateTime addedAt;
  const FavoriteRow({required this.pokemonId, required this.addedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['pokemon_id'] = Variable<int>(pokemonId);
    map['added_at'] = Variable<DateTime>(addedAt);
    return map;
  }

  FavoritesCompanion toCompanion(bool nullToAbsent) {
    return FavoritesCompanion(
      pokemonId: Value(pokemonId),
      addedAt: Value(addedAt),
    );
  }

  factory FavoriteRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FavoriteRow(
      pokemonId: serializer.fromJson<int>(json['pokemonId']),
      addedAt: serializer.fromJson<DateTime>(json['addedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'pokemonId': serializer.toJson<int>(pokemonId),
      'addedAt': serializer.toJson<DateTime>(addedAt),
    };
  }

  FavoriteRow copyWith({int? pokemonId, DateTime? addedAt}) => FavoriteRow(
    pokemonId: pokemonId ?? this.pokemonId,
    addedAt: addedAt ?? this.addedAt,
  );
  FavoriteRow copyWithCompanion(FavoritesCompanion data) {
    return FavoriteRow(
      pokemonId: data.pokemonId.present ? data.pokemonId.value : this.pokemonId,
      addedAt: data.addedAt.present ? data.addedAt.value : this.addedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FavoriteRow(')
          ..write('pokemonId: $pokemonId, ')
          ..write('addedAt: $addedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(pokemonId, addedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FavoriteRow &&
          other.pokemonId == this.pokemonId &&
          other.addedAt == this.addedAt);
}

class FavoritesCompanion extends UpdateCompanion<FavoriteRow> {
  final Value<int> pokemonId;
  final Value<DateTime> addedAt;
  const FavoritesCompanion({
    this.pokemonId = const Value.absent(),
    this.addedAt = const Value.absent(),
  });
  FavoritesCompanion.insert({
    this.pokemonId = const Value.absent(),
    required DateTime addedAt,
  }) : addedAt = Value(addedAt);
  static Insertable<FavoriteRow> custom({
    Expression<int>? pokemonId,
    Expression<DateTime>? addedAt,
  }) {
    return RawValuesInsertable({
      if (pokemonId != null) 'pokemon_id': pokemonId,
      if (addedAt != null) 'added_at': addedAt,
    });
  }

  FavoritesCompanion copyWith({
    Value<int>? pokemonId,
    Value<DateTime>? addedAt,
  }) {
    return FavoritesCompanion(
      pokemonId: pokemonId ?? this.pokemonId,
      addedAt: addedAt ?? this.addedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (pokemonId.present) {
      map['pokemon_id'] = Variable<int>(pokemonId.value);
    }
    if (addedAt.present) {
      map['added_at'] = Variable<DateTime>(addedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FavoritesCompanion(')
          ..write('pokemonId: $pokemonId, ')
          ..write('addedAt: $addedAt')
          ..write(')'))
        .toString();
  }
}

class $TriviaScoresTable extends TriviaScores
    with TableInfo<$TriviaScoresTable, TriviaScoreRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TriviaScoresTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _scoreMeta = const VerificationMeta('score');
  @override
  late final GeneratedColumn<int> score = GeneratedColumn<int>(
    'score',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _correctMeta = const VerificationMeta(
    'correct',
  );
  @override
  late final GeneratedColumn<int> correct = GeneratedColumn<int>(
    'correct',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _totalMeta = const VerificationMeta('total');
  @override
  late final GeneratedColumn<int> total = GeneratedColumn<int>(
    'total',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _bestStreakMeta = const VerificationMeta(
    'bestStreak',
  );
  @override
  late final GeneratedColumn<int> bestStreak = GeneratedColumn<int>(
    'best_streak',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _durationMsMeta = const VerificationMeta(
    'durationMs',
  );
  @override
  late final GeneratedColumn<int> durationMs = GeneratedColumn<int>(
    'duration_ms',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _playedAtMeta = const VerificationMeta(
    'playedAt',
  );
  @override
  late final GeneratedColumn<DateTime> playedAt = GeneratedColumn<DateTime>(
    'played_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    score,
    correct,
    total,
    bestStreak,
    durationMs,
    playedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'trivia_scores';
  @override
  VerificationContext validateIntegrity(
    Insertable<TriviaScoreRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('score')) {
      context.handle(
        _scoreMeta,
        score.isAcceptableOrUnknown(data['score']!, _scoreMeta),
      );
    } else if (isInserting) {
      context.missing(_scoreMeta);
    }
    if (data.containsKey('correct')) {
      context.handle(
        _correctMeta,
        correct.isAcceptableOrUnknown(data['correct']!, _correctMeta),
      );
    } else if (isInserting) {
      context.missing(_correctMeta);
    }
    if (data.containsKey('total')) {
      context.handle(
        _totalMeta,
        total.isAcceptableOrUnknown(data['total']!, _totalMeta),
      );
    } else if (isInserting) {
      context.missing(_totalMeta);
    }
    if (data.containsKey('best_streak')) {
      context.handle(
        _bestStreakMeta,
        bestStreak.isAcceptableOrUnknown(data['best_streak']!, _bestStreakMeta),
      );
    } else if (isInserting) {
      context.missing(_bestStreakMeta);
    }
    if (data.containsKey('duration_ms')) {
      context.handle(
        _durationMsMeta,
        durationMs.isAcceptableOrUnknown(data['duration_ms']!, _durationMsMeta),
      );
    } else if (isInserting) {
      context.missing(_durationMsMeta);
    }
    if (data.containsKey('played_at')) {
      context.handle(
        _playedAtMeta,
        playedAt.isAcceptableOrUnknown(data['played_at']!, _playedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_playedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TriviaScoreRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TriviaScoreRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      score: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}score'],
      )!,
      correct: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}correct'],
      )!,
      total: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}total'],
      )!,
      bestStreak: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}best_streak'],
      )!,
      durationMs: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}duration_ms'],
      )!,
      playedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}played_at'],
      )!,
    );
  }

  @override
  $TriviaScoresTable createAlias(String alias) {
    return $TriviaScoresTable(attachedDatabase, alias);
  }
}

class TriviaScoreRow extends DataClass implements Insertable<TriviaScoreRow> {
  final int id;
  final int score;
  final int correct;
  final int total;
  final int bestStreak;
  final int durationMs;
  final DateTime playedAt;
  const TriviaScoreRow({
    required this.id,
    required this.score,
    required this.correct,
    required this.total,
    required this.bestStreak,
    required this.durationMs,
    required this.playedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['score'] = Variable<int>(score);
    map['correct'] = Variable<int>(correct);
    map['total'] = Variable<int>(total);
    map['best_streak'] = Variable<int>(bestStreak);
    map['duration_ms'] = Variable<int>(durationMs);
    map['played_at'] = Variable<DateTime>(playedAt);
    return map;
  }

  TriviaScoresCompanion toCompanion(bool nullToAbsent) {
    return TriviaScoresCompanion(
      id: Value(id),
      score: Value(score),
      correct: Value(correct),
      total: Value(total),
      bestStreak: Value(bestStreak),
      durationMs: Value(durationMs),
      playedAt: Value(playedAt),
    );
  }

  factory TriviaScoreRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TriviaScoreRow(
      id: serializer.fromJson<int>(json['id']),
      score: serializer.fromJson<int>(json['score']),
      correct: serializer.fromJson<int>(json['correct']),
      total: serializer.fromJson<int>(json['total']),
      bestStreak: serializer.fromJson<int>(json['bestStreak']),
      durationMs: serializer.fromJson<int>(json['durationMs']),
      playedAt: serializer.fromJson<DateTime>(json['playedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'score': serializer.toJson<int>(score),
      'correct': serializer.toJson<int>(correct),
      'total': serializer.toJson<int>(total),
      'bestStreak': serializer.toJson<int>(bestStreak),
      'durationMs': serializer.toJson<int>(durationMs),
      'playedAt': serializer.toJson<DateTime>(playedAt),
    };
  }

  TriviaScoreRow copyWith({
    int? id,
    int? score,
    int? correct,
    int? total,
    int? bestStreak,
    int? durationMs,
    DateTime? playedAt,
  }) => TriviaScoreRow(
    id: id ?? this.id,
    score: score ?? this.score,
    correct: correct ?? this.correct,
    total: total ?? this.total,
    bestStreak: bestStreak ?? this.bestStreak,
    durationMs: durationMs ?? this.durationMs,
    playedAt: playedAt ?? this.playedAt,
  );
  TriviaScoreRow copyWithCompanion(TriviaScoresCompanion data) {
    return TriviaScoreRow(
      id: data.id.present ? data.id.value : this.id,
      score: data.score.present ? data.score.value : this.score,
      correct: data.correct.present ? data.correct.value : this.correct,
      total: data.total.present ? data.total.value : this.total,
      bestStreak: data.bestStreak.present
          ? data.bestStreak.value
          : this.bestStreak,
      durationMs: data.durationMs.present
          ? data.durationMs.value
          : this.durationMs,
      playedAt: data.playedAt.present ? data.playedAt.value : this.playedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TriviaScoreRow(')
          ..write('id: $id, ')
          ..write('score: $score, ')
          ..write('correct: $correct, ')
          ..write('total: $total, ')
          ..write('bestStreak: $bestStreak, ')
          ..write('durationMs: $durationMs, ')
          ..write('playedAt: $playedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, score, correct, total, bestStreak, durationMs, playedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TriviaScoreRow &&
          other.id == this.id &&
          other.score == this.score &&
          other.correct == this.correct &&
          other.total == this.total &&
          other.bestStreak == this.bestStreak &&
          other.durationMs == this.durationMs &&
          other.playedAt == this.playedAt);
}

class TriviaScoresCompanion extends UpdateCompanion<TriviaScoreRow> {
  final Value<int> id;
  final Value<int> score;
  final Value<int> correct;
  final Value<int> total;
  final Value<int> bestStreak;
  final Value<int> durationMs;
  final Value<DateTime> playedAt;
  const TriviaScoresCompanion({
    this.id = const Value.absent(),
    this.score = const Value.absent(),
    this.correct = const Value.absent(),
    this.total = const Value.absent(),
    this.bestStreak = const Value.absent(),
    this.durationMs = const Value.absent(),
    this.playedAt = const Value.absent(),
  });
  TriviaScoresCompanion.insert({
    this.id = const Value.absent(),
    required int score,
    required int correct,
    required int total,
    required int bestStreak,
    required int durationMs,
    required DateTime playedAt,
  }) : score = Value(score),
       correct = Value(correct),
       total = Value(total),
       bestStreak = Value(bestStreak),
       durationMs = Value(durationMs),
       playedAt = Value(playedAt);
  static Insertable<TriviaScoreRow> custom({
    Expression<int>? id,
    Expression<int>? score,
    Expression<int>? correct,
    Expression<int>? total,
    Expression<int>? bestStreak,
    Expression<int>? durationMs,
    Expression<DateTime>? playedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (score != null) 'score': score,
      if (correct != null) 'correct': correct,
      if (total != null) 'total': total,
      if (bestStreak != null) 'best_streak': bestStreak,
      if (durationMs != null) 'duration_ms': durationMs,
      if (playedAt != null) 'played_at': playedAt,
    });
  }

  TriviaScoresCompanion copyWith({
    Value<int>? id,
    Value<int>? score,
    Value<int>? correct,
    Value<int>? total,
    Value<int>? bestStreak,
    Value<int>? durationMs,
    Value<DateTime>? playedAt,
  }) {
    return TriviaScoresCompanion(
      id: id ?? this.id,
      score: score ?? this.score,
      correct: correct ?? this.correct,
      total: total ?? this.total,
      bestStreak: bestStreak ?? this.bestStreak,
      durationMs: durationMs ?? this.durationMs,
      playedAt: playedAt ?? this.playedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (score.present) {
      map['score'] = Variable<int>(score.value);
    }
    if (correct.present) {
      map['correct'] = Variable<int>(correct.value);
    }
    if (total.present) {
      map['total'] = Variable<int>(total.value);
    }
    if (bestStreak.present) {
      map['best_streak'] = Variable<int>(bestStreak.value);
    }
    if (durationMs.present) {
      map['duration_ms'] = Variable<int>(durationMs.value);
    }
    if (playedAt.present) {
      map['played_at'] = Variable<DateTime>(playedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TriviaScoresCompanion(')
          ..write('id: $id, ')
          ..write('score: $score, ')
          ..write('correct: $correct, ')
          ..write('total: $total, ')
          ..write('bestStreak: $bestStreak, ')
          ..write('durationMs: $durationMs, ')
          ..write('playedAt: $playedAt')
          ..write(')'))
        .toString();
  }
}

class $AchievementsTable extends Achievements
    with TableInfo<$AchievementsTable, AchievementRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AchievementsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _unlockedAtMeta = const VerificationMeta(
    'unlockedAt',
  );
  @override
  late final GeneratedColumn<DateTime> unlockedAt = GeneratedColumn<DateTime>(
    'unlocked_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, unlockedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'achievements';
  @override
  VerificationContext validateIntegrity(
    Insertable<AchievementRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('unlocked_at')) {
      context.handle(
        _unlockedAtMeta,
        unlockedAt.isAcceptableOrUnknown(data['unlocked_at']!, _unlockedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_unlockedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AchievementRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AchievementRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      unlockedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}unlocked_at'],
      )!,
    );
  }

  @override
  $AchievementsTable createAlias(String alias) {
    return $AchievementsTable(attachedDatabase, alias);
  }
}

class AchievementRow extends DataClass implements Insertable<AchievementRow> {
  final String id;
  final DateTime unlockedAt;
  const AchievementRow({required this.id, required this.unlockedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['unlocked_at'] = Variable<DateTime>(unlockedAt);
    return map;
  }

  AchievementsCompanion toCompanion(bool nullToAbsent) {
    return AchievementsCompanion(id: Value(id), unlockedAt: Value(unlockedAt));
  }

  factory AchievementRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AchievementRow(
      id: serializer.fromJson<String>(json['id']),
      unlockedAt: serializer.fromJson<DateTime>(json['unlockedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'unlockedAt': serializer.toJson<DateTime>(unlockedAt),
    };
  }

  AchievementRow copyWith({String? id, DateTime? unlockedAt}) => AchievementRow(
    id: id ?? this.id,
    unlockedAt: unlockedAt ?? this.unlockedAt,
  );
  AchievementRow copyWithCompanion(AchievementsCompanion data) {
    return AchievementRow(
      id: data.id.present ? data.id.value : this.id,
      unlockedAt: data.unlockedAt.present
          ? data.unlockedAt.value
          : this.unlockedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AchievementRow(')
          ..write('id: $id, ')
          ..write('unlockedAt: $unlockedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, unlockedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AchievementRow &&
          other.id == this.id &&
          other.unlockedAt == this.unlockedAt);
}

class AchievementsCompanion extends UpdateCompanion<AchievementRow> {
  final Value<String> id;
  final Value<DateTime> unlockedAt;
  final Value<int> rowid;
  const AchievementsCompanion({
    this.id = const Value.absent(),
    this.unlockedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AchievementsCompanion.insert({
    required String id,
    required DateTime unlockedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       unlockedAt = Value(unlockedAt);
  static Insertable<AchievementRow> custom({
    Expression<String>? id,
    Expression<DateTime>? unlockedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (unlockedAt != null) 'unlocked_at': unlockedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AchievementsCompanion copyWith({
    Value<String>? id,
    Value<DateTime>? unlockedAt,
    Value<int>? rowid,
  }) {
    return AchievementsCompanion(
      id: id ?? this.id,
      unlockedAt: unlockedAt ?? this.unlockedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (unlockedAt.present) {
      map['unlocked_at'] = Variable<DateTime>(unlockedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AchievementsCompanion(')
          ..write('id: $id, ')
          ..write('unlockedAt: $unlockedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $BattleRecordsTable extends BattleRecords
    with TableInfo<$BattleRecordsTable, BattleRecordRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BattleRecordsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _playerIdMeta = const VerificationMeta(
    'playerId',
  );
  @override
  late final GeneratedColumn<int> playerId = GeneratedColumn<int>(
    'player_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _rivalIdMeta = const VerificationMeta(
    'rivalId',
  );
  @override
  late final GeneratedColumn<int> rivalId = GeneratedColumn<int>(
    'rival_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _wonMeta = const VerificationMeta('won');
  @override
  late final GeneratedColumn<bool> won = GeneratedColumn<bool>(
    'won',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("won" IN (0, 1))',
    ),
  );
  static const VerificationMeta _turnsMeta = const VerificationMeta('turns');
  @override
  late final GeneratedColumn<int> turns = GeneratedColumn<int>(
    'turns',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _playedAtMeta = const VerificationMeta(
    'playedAt',
  );
  @override
  late final GeneratedColumn<DateTime> playedAt = GeneratedColumn<DateTime>(
    'played_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    playerId,
    rivalId,
    won,
    turns,
    playedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'battle_records';
  @override
  VerificationContext validateIntegrity(
    Insertable<BattleRecordRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('player_id')) {
      context.handle(
        _playerIdMeta,
        playerId.isAcceptableOrUnknown(data['player_id']!, _playerIdMeta),
      );
    } else if (isInserting) {
      context.missing(_playerIdMeta);
    }
    if (data.containsKey('rival_id')) {
      context.handle(
        _rivalIdMeta,
        rivalId.isAcceptableOrUnknown(data['rival_id']!, _rivalIdMeta),
      );
    } else if (isInserting) {
      context.missing(_rivalIdMeta);
    }
    if (data.containsKey('won')) {
      context.handle(
        _wonMeta,
        won.isAcceptableOrUnknown(data['won']!, _wonMeta),
      );
    } else if (isInserting) {
      context.missing(_wonMeta);
    }
    if (data.containsKey('turns')) {
      context.handle(
        _turnsMeta,
        turns.isAcceptableOrUnknown(data['turns']!, _turnsMeta),
      );
    } else if (isInserting) {
      context.missing(_turnsMeta);
    }
    if (data.containsKey('played_at')) {
      context.handle(
        _playedAtMeta,
        playedAt.isAcceptableOrUnknown(data['played_at']!, _playedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_playedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  BattleRecordRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BattleRecordRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      playerId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}player_id'],
      )!,
      rivalId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}rival_id'],
      )!,
      won: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}won'],
      )!,
      turns: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}turns'],
      )!,
      playedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}played_at'],
      )!,
    );
  }

  @override
  $BattleRecordsTable createAlias(String alias) {
    return $BattleRecordsTable(attachedDatabase, alias);
  }
}

class BattleRecordRow extends DataClass implements Insertable<BattleRecordRow> {
  final int id;
  final int playerId;
  final int rivalId;
  final bool won;
  final int turns;
  final DateTime playedAt;
  const BattleRecordRow({
    required this.id,
    required this.playerId,
    required this.rivalId,
    required this.won,
    required this.turns,
    required this.playedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['player_id'] = Variable<int>(playerId);
    map['rival_id'] = Variable<int>(rivalId);
    map['won'] = Variable<bool>(won);
    map['turns'] = Variable<int>(turns);
    map['played_at'] = Variable<DateTime>(playedAt);
    return map;
  }

  BattleRecordsCompanion toCompanion(bool nullToAbsent) {
    return BattleRecordsCompanion(
      id: Value(id),
      playerId: Value(playerId),
      rivalId: Value(rivalId),
      won: Value(won),
      turns: Value(turns),
      playedAt: Value(playedAt),
    );
  }

  factory BattleRecordRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BattleRecordRow(
      id: serializer.fromJson<int>(json['id']),
      playerId: serializer.fromJson<int>(json['playerId']),
      rivalId: serializer.fromJson<int>(json['rivalId']),
      won: serializer.fromJson<bool>(json['won']),
      turns: serializer.fromJson<int>(json['turns']),
      playedAt: serializer.fromJson<DateTime>(json['playedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'playerId': serializer.toJson<int>(playerId),
      'rivalId': serializer.toJson<int>(rivalId),
      'won': serializer.toJson<bool>(won),
      'turns': serializer.toJson<int>(turns),
      'playedAt': serializer.toJson<DateTime>(playedAt),
    };
  }

  BattleRecordRow copyWith({
    int? id,
    int? playerId,
    int? rivalId,
    bool? won,
    int? turns,
    DateTime? playedAt,
  }) => BattleRecordRow(
    id: id ?? this.id,
    playerId: playerId ?? this.playerId,
    rivalId: rivalId ?? this.rivalId,
    won: won ?? this.won,
    turns: turns ?? this.turns,
    playedAt: playedAt ?? this.playedAt,
  );
  BattleRecordRow copyWithCompanion(BattleRecordsCompanion data) {
    return BattleRecordRow(
      id: data.id.present ? data.id.value : this.id,
      playerId: data.playerId.present ? data.playerId.value : this.playerId,
      rivalId: data.rivalId.present ? data.rivalId.value : this.rivalId,
      won: data.won.present ? data.won.value : this.won,
      turns: data.turns.present ? data.turns.value : this.turns,
      playedAt: data.playedAt.present ? data.playedAt.value : this.playedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BattleRecordRow(')
          ..write('id: $id, ')
          ..write('playerId: $playerId, ')
          ..write('rivalId: $rivalId, ')
          ..write('won: $won, ')
          ..write('turns: $turns, ')
          ..write('playedAt: $playedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, playerId, rivalId, won, turns, playedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BattleRecordRow &&
          other.id == this.id &&
          other.playerId == this.playerId &&
          other.rivalId == this.rivalId &&
          other.won == this.won &&
          other.turns == this.turns &&
          other.playedAt == this.playedAt);
}

class BattleRecordsCompanion extends UpdateCompanion<BattleRecordRow> {
  final Value<int> id;
  final Value<int> playerId;
  final Value<int> rivalId;
  final Value<bool> won;
  final Value<int> turns;
  final Value<DateTime> playedAt;
  const BattleRecordsCompanion({
    this.id = const Value.absent(),
    this.playerId = const Value.absent(),
    this.rivalId = const Value.absent(),
    this.won = const Value.absent(),
    this.turns = const Value.absent(),
    this.playedAt = const Value.absent(),
  });
  BattleRecordsCompanion.insert({
    this.id = const Value.absent(),
    required int playerId,
    required int rivalId,
    required bool won,
    required int turns,
    required DateTime playedAt,
  }) : playerId = Value(playerId),
       rivalId = Value(rivalId),
       won = Value(won),
       turns = Value(turns),
       playedAt = Value(playedAt);
  static Insertable<BattleRecordRow> custom({
    Expression<int>? id,
    Expression<int>? playerId,
    Expression<int>? rivalId,
    Expression<bool>? won,
    Expression<int>? turns,
    Expression<DateTime>? playedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (playerId != null) 'player_id': playerId,
      if (rivalId != null) 'rival_id': rivalId,
      if (won != null) 'won': won,
      if (turns != null) 'turns': turns,
      if (playedAt != null) 'played_at': playedAt,
    });
  }

  BattleRecordsCompanion copyWith({
    Value<int>? id,
    Value<int>? playerId,
    Value<int>? rivalId,
    Value<bool>? won,
    Value<int>? turns,
    Value<DateTime>? playedAt,
  }) {
    return BattleRecordsCompanion(
      id: id ?? this.id,
      playerId: playerId ?? this.playerId,
      rivalId: rivalId ?? this.rivalId,
      won: won ?? this.won,
      turns: turns ?? this.turns,
      playedAt: playedAt ?? this.playedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (playerId.present) {
      map['player_id'] = Variable<int>(playerId.value);
    }
    if (rivalId.present) {
      map['rival_id'] = Variable<int>(rivalId.value);
    }
    if (won.present) {
      map['won'] = Variable<bool>(won.value);
    }
    if (turns.present) {
      map['turns'] = Variable<int>(turns.value);
    }
    if (playedAt.present) {
      map['played_at'] = Variable<DateTime>(playedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BattleRecordsCompanion(')
          ..write('id: $id, ')
          ..write('playerId: $playerId, ')
          ..write('rivalId: $rivalId, ')
          ..write('won: $won, ')
          ..write('turns: $turns, ')
          ..write('playedAt: $playedAt')
          ..write(')'))
        .toString();
  }
}

class $SyncMetaTable extends SyncMeta
    with TableInfo<$SyncMetaTable, SyncMetaRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SyncMetaTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _resourceMeta = const VerificationMeta(
    'resource',
  );
  @override
  late final GeneratedColumn<String> resource = GeneratedColumn<String>(
    'resource',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lastSyncedAtMeta = const VerificationMeta(
    'lastSyncedAt',
  );
  @override
  late final GeneratedColumn<DateTime> lastSyncedAt = GeneratedColumn<DateTime>(
    'last_synced_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _contentHashMeta = const VerificationMeta(
    'contentHash',
  );
  @override
  late final GeneratedColumn<String> contentHash = GeneratedColumn<String>(
    'content_hash',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('ok'),
  );
  static const VerificationMeta _attemptsMeta = const VerificationMeta(
    'attempts',
  );
  @override
  late final GeneratedColumn<int> attempts = GeneratedColumn<int>(
    'attempts',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _lastErrorMeta = const VerificationMeta(
    'lastError',
  );
  @override
  late final GeneratedColumn<String> lastError = GeneratedColumn<String>(
    'last_error',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    resource,
    lastSyncedAt,
    contentHash,
    status,
    attempts,
    lastError,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sync_meta';
  @override
  VerificationContext validateIntegrity(
    Insertable<SyncMetaRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('resource')) {
      context.handle(
        _resourceMeta,
        resource.isAcceptableOrUnknown(data['resource']!, _resourceMeta),
      );
    } else if (isInserting) {
      context.missing(_resourceMeta);
    }
    if (data.containsKey('last_synced_at')) {
      context.handle(
        _lastSyncedAtMeta,
        lastSyncedAt.isAcceptableOrUnknown(
          data['last_synced_at']!,
          _lastSyncedAtMeta,
        ),
      );
    }
    if (data.containsKey('content_hash')) {
      context.handle(
        _contentHashMeta,
        contentHash.isAcceptableOrUnknown(
          data['content_hash']!,
          _contentHashMeta,
        ),
      );
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    if (data.containsKey('attempts')) {
      context.handle(
        _attemptsMeta,
        attempts.isAcceptableOrUnknown(data['attempts']!, _attemptsMeta),
      );
    }
    if (data.containsKey('last_error')) {
      context.handle(
        _lastErrorMeta,
        lastError.isAcceptableOrUnknown(data['last_error']!, _lastErrorMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {resource};
  @override
  SyncMetaRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SyncMetaRow(
      resource: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}resource'],
      )!,
      lastSyncedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_synced_at'],
      ),
      contentHash: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}content_hash'],
      ),
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      attempts: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}attempts'],
      )!,
      lastError: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}last_error'],
      ),
    );
  }

  @override
  $SyncMetaTable createAlias(String alias) {
    return $SyncMetaTable(attachedDatabase, alias);
  }
}

class SyncMetaRow extends DataClass implements Insertable<SyncMetaRow> {
  final String resource;
  final DateTime? lastSyncedAt;
  final String? contentHash;
  final String status;
  final int attempts;
  final String? lastError;
  const SyncMetaRow({
    required this.resource,
    this.lastSyncedAt,
    this.contentHash,
    required this.status,
    required this.attempts,
    this.lastError,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['resource'] = Variable<String>(resource);
    if (!nullToAbsent || lastSyncedAt != null) {
      map['last_synced_at'] = Variable<DateTime>(lastSyncedAt);
    }
    if (!nullToAbsent || contentHash != null) {
      map['content_hash'] = Variable<String>(contentHash);
    }
    map['status'] = Variable<String>(status);
    map['attempts'] = Variable<int>(attempts);
    if (!nullToAbsent || lastError != null) {
      map['last_error'] = Variable<String>(lastError);
    }
    return map;
  }

  SyncMetaCompanion toCompanion(bool nullToAbsent) {
    return SyncMetaCompanion(
      resource: Value(resource),
      lastSyncedAt: lastSyncedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastSyncedAt),
      contentHash: contentHash == null && nullToAbsent
          ? const Value.absent()
          : Value(contentHash),
      status: Value(status),
      attempts: Value(attempts),
      lastError: lastError == null && nullToAbsent
          ? const Value.absent()
          : Value(lastError),
    );
  }

  factory SyncMetaRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SyncMetaRow(
      resource: serializer.fromJson<String>(json['resource']),
      lastSyncedAt: serializer.fromJson<DateTime?>(json['lastSyncedAt']),
      contentHash: serializer.fromJson<String?>(json['contentHash']),
      status: serializer.fromJson<String>(json['status']),
      attempts: serializer.fromJson<int>(json['attempts']),
      lastError: serializer.fromJson<String?>(json['lastError']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'resource': serializer.toJson<String>(resource),
      'lastSyncedAt': serializer.toJson<DateTime?>(lastSyncedAt),
      'contentHash': serializer.toJson<String?>(contentHash),
      'status': serializer.toJson<String>(status),
      'attempts': serializer.toJson<int>(attempts),
      'lastError': serializer.toJson<String?>(lastError),
    };
  }

  SyncMetaRow copyWith({
    String? resource,
    Value<DateTime?> lastSyncedAt = const Value.absent(),
    Value<String?> contentHash = const Value.absent(),
    String? status,
    int? attempts,
    Value<String?> lastError = const Value.absent(),
  }) => SyncMetaRow(
    resource: resource ?? this.resource,
    lastSyncedAt: lastSyncedAt.present ? lastSyncedAt.value : this.lastSyncedAt,
    contentHash: contentHash.present ? contentHash.value : this.contentHash,
    status: status ?? this.status,
    attempts: attempts ?? this.attempts,
    lastError: lastError.present ? lastError.value : this.lastError,
  );
  SyncMetaRow copyWithCompanion(SyncMetaCompanion data) {
    return SyncMetaRow(
      resource: data.resource.present ? data.resource.value : this.resource,
      lastSyncedAt: data.lastSyncedAt.present
          ? data.lastSyncedAt.value
          : this.lastSyncedAt,
      contentHash: data.contentHash.present
          ? data.contentHash.value
          : this.contentHash,
      status: data.status.present ? data.status.value : this.status,
      attempts: data.attempts.present ? data.attempts.value : this.attempts,
      lastError: data.lastError.present ? data.lastError.value : this.lastError,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SyncMetaRow(')
          ..write('resource: $resource, ')
          ..write('lastSyncedAt: $lastSyncedAt, ')
          ..write('contentHash: $contentHash, ')
          ..write('status: $status, ')
          ..write('attempts: $attempts, ')
          ..write('lastError: $lastError')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    resource,
    lastSyncedAt,
    contentHash,
    status,
    attempts,
    lastError,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SyncMetaRow &&
          other.resource == this.resource &&
          other.lastSyncedAt == this.lastSyncedAt &&
          other.contentHash == this.contentHash &&
          other.status == this.status &&
          other.attempts == this.attempts &&
          other.lastError == this.lastError);
}

class SyncMetaCompanion extends UpdateCompanion<SyncMetaRow> {
  final Value<String> resource;
  final Value<DateTime?> lastSyncedAt;
  final Value<String?> contentHash;
  final Value<String> status;
  final Value<int> attempts;
  final Value<String?> lastError;
  final Value<int> rowid;
  const SyncMetaCompanion({
    this.resource = const Value.absent(),
    this.lastSyncedAt = const Value.absent(),
    this.contentHash = const Value.absent(),
    this.status = const Value.absent(),
    this.attempts = const Value.absent(),
    this.lastError = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SyncMetaCompanion.insert({
    required String resource,
    this.lastSyncedAt = const Value.absent(),
    this.contentHash = const Value.absent(),
    this.status = const Value.absent(),
    this.attempts = const Value.absent(),
    this.lastError = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : resource = Value(resource);
  static Insertable<SyncMetaRow> custom({
    Expression<String>? resource,
    Expression<DateTime>? lastSyncedAt,
    Expression<String>? contentHash,
    Expression<String>? status,
    Expression<int>? attempts,
    Expression<String>? lastError,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (resource != null) 'resource': resource,
      if (lastSyncedAt != null) 'last_synced_at': lastSyncedAt,
      if (contentHash != null) 'content_hash': contentHash,
      if (status != null) 'status': status,
      if (attempts != null) 'attempts': attempts,
      if (lastError != null) 'last_error': lastError,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SyncMetaCompanion copyWith({
    Value<String>? resource,
    Value<DateTime?>? lastSyncedAt,
    Value<String?>? contentHash,
    Value<String>? status,
    Value<int>? attempts,
    Value<String?>? lastError,
    Value<int>? rowid,
  }) {
    return SyncMetaCompanion(
      resource: resource ?? this.resource,
      lastSyncedAt: lastSyncedAt ?? this.lastSyncedAt,
      contentHash: contentHash ?? this.contentHash,
      status: status ?? this.status,
      attempts: attempts ?? this.attempts,
      lastError: lastError ?? this.lastError,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (resource.present) {
      map['resource'] = Variable<String>(resource.value);
    }
    if (lastSyncedAt.present) {
      map['last_synced_at'] = Variable<DateTime>(lastSyncedAt.value);
    }
    if (contentHash.present) {
      map['content_hash'] = Variable<String>(contentHash.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (attempts.present) {
      map['attempts'] = Variable<int>(attempts.value);
    }
    if (lastError.present) {
      map['last_error'] = Variable<String>(lastError.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SyncMetaCompanion(')
          ..write('resource: $resource, ')
          ..write('lastSyncedAt: $lastSyncedAt, ')
          ..write('contentHash: $contentHash, ')
          ..write('status: $status, ')
          ..write('attempts: $attempts, ')
          ..write('lastError: $lastError, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AppSettingsTable extends AppSettings
    with TableInfo<$AppSettingsTable, SettingRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AppSettingsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _keyMeta = const VerificationMeta('key');
  @override
  late final GeneratedColumn<String> key = GeneratedColumn<String>(
    'key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<String> value = GeneratedColumn<String>(
    'value',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [key, value];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'app_settings';
  @override
  VerificationContext validateIntegrity(
    Insertable<SettingRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('key')) {
      context.handle(
        _keyMeta,
        key.isAcceptableOrUnknown(data['key']!, _keyMeta),
      );
    } else if (isInserting) {
      context.missing(_keyMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
        _valueMeta,
        value.isAcceptableOrUnknown(data['value']!, _valueMeta),
      );
    } else if (isInserting) {
      context.missing(_valueMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {key};
  @override
  SettingRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SettingRow(
      key: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}key'],
      )!,
      value: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}value'],
      )!,
    );
  }

  @override
  $AppSettingsTable createAlias(String alias) {
    return $AppSettingsTable(attachedDatabase, alias);
  }
}

class SettingRow extends DataClass implements Insertable<SettingRow> {
  final String key;
  final String value;
  const SettingRow({required this.key, required this.value});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['key'] = Variable<String>(key);
    map['value'] = Variable<String>(value);
    return map;
  }

  AppSettingsCompanion toCompanion(bool nullToAbsent) {
    return AppSettingsCompanion(key: Value(key), value: Value(value));
  }

  factory SettingRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SettingRow(
      key: serializer.fromJson<String>(json['key']),
      value: serializer.fromJson<String>(json['value']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'key': serializer.toJson<String>(key),
      'value': serializer.toJson<String>(value),
    };
  }

  SettingRow copyWith({String? key, String? value}) =>
      SettingRow(key: key ?? this.key, value: value ?? this.value);
  SettingRow copyWithCompanion(AppSettingsCompanion data) {
    return SettingRow(
      key: data.key.present ? data.key.value : this.key,
      value: data.value.present ? data.value.value : this.value,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SettingRow(')
          ..write('key: $key, ')
          ..write('value: $value')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(key, value);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SettingRow &&
          other.key == this.key &&
          other.value == this.value);
}

class AppSettingsCompanion extends UpdateCompanion<SettingRow> {
  final Value<String> key;
  final Value<String> value;
  final Value<int> rowid;
  const AppSettingsCompanion({
    this.key = const Value.absent(),
    this.value = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AppSettingsCompanion.insert({
    required String key,
    required String value,
    this.rowid = const Value.absent(),
  }) : key = Value(key),
       value = Value(value);
  static Insertable<SettingRow> custom({
    Expression<String>? key,
    Expression<String>? value,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (key != null) 'key': key,
      if (value != null) 'value': value,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AppSettingsCompanion copyWith({
    Value<String>? key,
    Value<String>? value,
    Value<int>? rowid,
  }) {
    return AppSettingsCompanion(
      key: key ?? this.key,
      value: value ?? this.value,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (key.present) {
      map['key'] = Variable<String>(key.value);
    }
    if (value.present) {
      map['value'] = Variable<String>(value.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AppSettingsCompanion(')
          ..write('key: $key, ')
          ..write('value: $value, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $PokemonTable pokemon = $PokemonTable(this);
  late final $PokeTypesTable pokeTypes = $PokeTypesTable(this);
  late final $PokemonTypesTable pokemonTypes = $PokemonTypesTable(this);
  late final $TypeEfficacyTable typeEfficacy = $TypeEfficacyTable(this);
  late final $GenerationsTable generations = $GenerationsTable(this);
  late final $VersionGroupsTable versionGroups = $VersionGroupsTable(this);
  late final $AbilitiesTable abilities = $AbilitiesTable(this);
  late final $PokemonAbilitiesTable pokemonAbilities = $PokemonAbilitiesTable(
    this,
  );
  late final $MovesTable moves = $MovesTable(this);
  late final $PokemonMovesTable pokemonMoves = $PokemonMovesTable(this);
  late final $EvolutionsTable evolutions = $EvolutionsTable(this);
  late final $FavoritesTable favorites = $FavoritesTable(this);
  late final $TriviaScoresTable triviaScores = $TriviaScoresTable(this);
  late final $AchievementsTable achievements = $AchievementsTable(this);
  late final $BattleRecordsTable battleRecords = $BattleRecordsTable(this);
  late final $SyncMetaTable syncMeta = $SyncMetaTable(this);
  late final $AppSettingsTable appSettings = $AppSettingsTable(this);
  late final Index idxPokemonName = Index(
    'idx_pokemon_name',
    'CREATE INDEX idx_pokemon_name ON pokemon (name_es, name_en)',
  );
  late final Index idxPokemonGeneration = Index(
    'idx_pokemon_generation',
    'CREATE INDEX idx_pokemon_generation ON pokemon (generation_id)',
  );
  late final Index idxPokemonTotal = Index(
    'idx_pokemon_total',
    'CREATE INDEX idx_pokemon_total ON pokemon (stat_total)',
  );
  late final Index idxPokemonSpecies = Index(
    'idx_pokemon_species',
    'CREATE INDEX idx_pokemon_species ON pokemon (species_id)',
  );
  late final Index idxPokemonTypesType = Index(
    'idx_pokemon_types_type',
    'CREATE INDEX idx_pokemon_types_type ON pokemon_types (type_id)',
  );
  late final Index idxPokemonAbilitiesAbility = Index(
    'idx_pokemon_abilities_ability',
    'CREATE INDEX idx_pokemon_abilities_ability ON pokemon_abilities (ability_id)',
  );
  late final Index idxPokemonMovesVersion = Index(
    'idx_pokemon_moves_version',
    'CREATE INDEX idx_pokemon_moves_version ON pokemon_moves (pokemon_id, version_group_id)',
  );
  late final Index idxEvolutionsChain = Index(
    'idx_evolutions_chain',
    'CREATE INDEX idx_evolutions_chain ON evolutions (chain_id)',
  );
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    pokemon,
    pokeTypes,
    pokemonTypes,
    typeEfficacy,
    generations,
    versionGroups,
    abilities,
    pokemonAbilities,
    moves,
    pokemonMoves,
    evolutions,
    favorites,
    triviaScores,
    achievements,
    battleRecords,
    syncMeta,
    appSettings,
    idxPokemonName,
    idxPokemonGeneration,
    idxPokemonTotal,
    idxPokemonSpecies,
    idxPokemonTypesType,
    idxPokemonAbilitiesAbility,
    idxPokemonMovesVersion,
    idxEvolutionsChain,
  ];
}

typedef $$PokemonTableCreateCompanionBuilder = PokemonCompanion Function({
  Value<int> id,
  required String name,
  required String nameEs,
  required String nameEn,
  Value<String?> nameJa,
  Value<int?> speciesId,
  Value<bool> isDefault,
  Value<String?> formNameEs,
  Value<String?> formNameEn,
  required int generationId,
  Value<int?> evolutionChainId,
  required int hp,
  required int attack,
  required int defense,
  required int specialAttack,
  required int specialDefense,
  required int speed,
  required int statTotal,
  Value<String?> spriteUrl,
  Value<String?> artworkUrl,
  Value<String?> shinyArtworkUrl,
  Value<String?> spriteFile,
  Value<String?> artworkFile,
  Value<bool> hasDetail,
  Value<int?> height,
  Value<int?> weight,
  Value<String?> flavorEs,
  Value<String?> flavorEn,
  Value<String?> eggGroups,
  Value<int?> captureRate,
  Value<bool> isLegendary,
  Value<bool> isMythical,
});
typedef $$PokemonTableUpdateCompanionBuilder = PokemonCompanion Function({
  Value<int> id,
  Value<String> name,
  Value<String> nameEs,
  Value<String> nameEn,
  Value<String?> nameJa,
  Value<int?> speciesId,
  Value<bool> isDefault,
  Value<String?> formNameEs,
  Value<String?> formNameEn,
  Value<int> generationId,
  Value<int?> evolutionChainId,
  Value<int> hp,
  Value<int> attack,
  Value<int> defense,
  Value<int> specialAttack,
  Value<int> specialDefense,
  Value<int> speed,
  Value<int> statTotal,
  Value<String?> spriteUrl,
  Value<String?> artworkUrl,
  Value<String?> shinyArtworkUrl,
  Value<String?> spriteFile,
  Value<String?> artworkFile,
  Value<bool> hasDetail,
  Value<int?> height,
  Value<int?> weight,
  Value<String?> flavorEs,
  Value<String?> flavorEn,
  Value<String?> eggGroups,
  Value<int?> captureRate,
  Value<bool> isLegendary,
  Value<bool> isMythical,
});

class $$PokemonTableFilterComposer
    extends Composer<_$AppDatabase, $PokemonTable> {
  $$PokemonTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nameEs => $composableBuilder(
    column: $table.nameEs,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nameEn => $composableBuilder(
    column: $table.nameEn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nameJa => $composableBuilder(
    column: $table.nameJa,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get speciesId => $composableBuilder(
    column: $table.speciesId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isDefault => $composableBuilder(
    column: $table.isDefault,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get formNameEs => $composableBuilder(
    column: $table.formNameEs,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get formNameEn => $composableBuilder(
    column: $table.formNameEn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get generationId => $composableBuilder(
    column: $table.generationId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get evolutionChainId => $composableBuilder(
    column: $table.evolutionChainId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get hp => $composableBuilder(
    column: $table.hp,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get attack => $composableBuilder(
    column: $table.attack,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get defense => $composableBuilder(
    column: $table.defense,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get specialAttack => $composableBuilder(
    column: $table.specialAttack,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get specialDefense => $composableBuilder(
    column: $table.specialDefense,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get speed => $composableBuilder(
    column: $table.speed,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get statTotal => $composableBuilder(
    column: $table.statTotal,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get spriteUrl => $composableBuilder(
    column: $table.spriteUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get artworkUrl => $composableBuilder(
    column: $table.artworkUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get shinyArtworkUrl => $composableBuilder(
    column: $table.shinyArtworkUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get spriteFile => $composableBuilder(
    column: $table.spriteFile,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get artworkFile => $composableBuilder(
    column: $table.artworkFile,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get hasDetail => $composableBuilder(
    column: $table.hasDetail,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get height => $composableBuilder(
    column: $table.height,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get weight => $composableBuilder(
    column: $table.weight,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get flavorEs => $composableBuilder(
    column: $table.flavorEs,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get flavorEn => $composableBuilder(
    column: $table.flavorEn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get eggGroups => $composableBuilder(
    column: $table.eggGroups,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get captureRate => $composableBuilder(
    column: $table.captureRate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isLegendary => $composableBuilder(
    column: $table.isLegendary,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isMythical => $composableBuilder(
    column: $table.isMythical,
    builder: (column) => ColumnFilters(column),
  );
}

class $$PokemonTableOrderingComposer
    extends Composer<_$AppDatabase, $PokemonTable> {
  $$PokemonTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nameEs => $composableBuilder(
    column: $table.nameEs,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nameEn => $composableBuilder(
    column: $table.nameEn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nameJa => $composableBuilder(
    column: $table.nameJa,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get speciesId => $composableBuilder(
    column: $table.speciesId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isDefault => $composableBuilder(
    column: $table.isDefault,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get formNameEs => $composableBuilder(
    column: $table.formNameEs,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get formNameEn => $composableBuilder(
    column: $table.formNameEn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get generationId => $composableBuilder(
    column: $table.generationId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get evolutionChainId => $composableBuilder(
    column: $table.evolutionChainId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get hp => $composableBuilder(
    column: $table.hp,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get attack => $composableBuilder(
    column: $table.attack,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get defense => $composableBuilder(
    column: $table.defense,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get specialAttack => $composableBuilder(
    column: $table.specialAttack,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get specialDefense => $composableBuilder(
    column: $table.specialDefense,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get speed => $composableBuilder(
    column: $table.speed,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get statTotal => $composableBuilder(
    column: $table.statTotal,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get spriteUrl => $composableBuilder(
    column: $table.spriteUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get artworkUrl => $composableBuilder(
    column: $table.artworkUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get shinyArtworkUrl => $composableBuilder(
    column: $table.shinyArtworkUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get spriteFile => $composableBuilder(
    column: $table.spriteFile,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get artworkFile => $composableBuilder(
    column: $table.artworkFile,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get hasDetail => $composableBuilder(
    column: $table.hasDetail,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get height => $composableBuilder(
    column: $table.height,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get weight => $composableBuilder(
    column: $table.weight,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get flavorEs => $composableBuilder(
    column: $table.flavorEs,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get flavorEn => $composableBuilder(
    column: $table.flavorEn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get eggGroups => $composableBuilder(
    column: $table.eggGroups,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get captureRate => $composableBuilder(
    column: $table.captureRate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isLegendary => $composableBuilder(
    column: $table.isLegendary,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isMythical => $composableBuilder(
    column: $table.isMythical,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PokemonTableAnnotationComposer
    extends Composer<_$AppDatabase, $PokemonTable> {
  $$PokemonTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get nameEs =>
      $composableBuilder(column: $table.nameEs, builder: (column) => column);

  GeneratedColumn<String> get nameEn =>
      $composableBuilder(column: $table.nameEn, builder: (column) => column);

  GeneratedColumn<String> get nameJa =>
      $composableBuilder(column: $table.nameJa, builder: (column) => column);

  GeneratedColumn<int> get speciesId =>
      $composableBuilder(column: $table.speciesId, builder: (column) => column);

  GeneratedColumn<bool> get isDefault =>
      $composableBuilder(column: $table.isDefault, builder: (column) => column);

  GeneratedColumn<String> get formNameEs => $composableBuilder(
    column: $table.formNameEs,
    builder: (column) => column,
  );

  GeneratedColumn<String> get formNameEn => $composableBuilder(
    column: $table.formNameEn,
    builder: (column) => column,
  );

  GeneratedColumn<int> get generationId => $composableBuilder(
    column: $table.generationId,
    builder: (column) => column,
  );

  GeneratedColumn<int> get evolutionChainId => $composableBuilder(
    column: $table.evolutionChainId,
    builder: (column) => column,
  );

  GeneratedColumn<int> get hp =>
      $composableBuilder(column: $table.hp, builder: (column) => column);

  GeneratedColumn<int> get attack =>
      $composableBuilder(column: $table.attack, builder: (column) => column);

  GeneratedColumn<int> get defense =>
      $composableBuilder(column: $table.defense, builder: (column) => column);

  GeneratedColumn<int> get specialAttack => $composableBuilder(
    column: $table.specialAttack,
    builder: (column) => column,
  );

  GeneratedColumn<int> get specialDefense => $composableBuilder(
    column: $table.specialDefense,
    builder: (column) => column,
  );

  GeneratedColumn<int> get speed =>
      $composableBuilder(column: $table.speed, builder: (column) => column);

  GeneratedColumn<int> get statTotal =>
      $composableBuilder(column: $table.statTotal, builder: (column) => column);

  GeneratedColumn<String> get spriteUrl =>
      $composableBuilder(column: $table.spriteUrl, builder: (column) => column);

  GeneratedColumn<String> get artworkUrl => $composableBuilder(
    column: $table.artworkUrl,
    builder: (column) => column,
  );

  GeneratedColumn<String> get shinyArtworkUrl => $composableBuilder(
    column: $table.shinyArtworkUrl,
    builder: (column) => column,
  );

  GeneratedColumn<String> get spriteFile => $composableBuilder(
    column: $table.spriteFile,
    builder: (column) => column,
  );

  GeneratedColumn<String> get artworkFile => $composableBuilder(
    column: $table.artworkFile,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get hasDetail =>
      $composableBuilder(column: $table.hasDetail, builder: (column) => column);

  GeneratedColumn<int> get height =>
      $composableBuilder(column: $table.height, builder: (column) => column);

  GeneratedColumn<int> get weight =>
      $composableBuilder(column: $table.weight, builder: (column) => column);

  GeneratedColumn<String> get flavorEs =>
      $composableBuilder(column: $table.flavorEs, builder: (column) => column);

  GeneratedColumn<String> get flavorEn =>
      $composableBuilder(column: $table.flavorEn, builder: (column) => column);

  GeneratedColumn<String> get eggGroups =>
      $composableBuilder(column: $table.eggGroups, builder: (column) => column);

  GeneratedColumn<int> get captureRate => $composableBuilder(
    column: $table.captureRate,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isLegendary => $composableBuilder(
    column: $table.isLegendary,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isMythical => $composableBuilder(
    column: $table.isMythical,
    builder: (column) => column,
  );
}

class $$PokemonTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PokemonTable,
          PokemonRow,
          $$PokemonTableFilterComposer,
          $$PokemonTableOrderingComposer,
          $$PokemonTableAnnotationComposer,
          $$PokemonTableCreateCompanionBuilder,
          $$PokemonTableUpdateCompanionBuilder,
          (
            PokemonRow,
            BaseReferences<_$AppDatabase, $PokemonTable, PokemonRow>,
          ),
          PokemonRow,
          PrefetchHooks Function()
        > {
  $$PokemonTableTableManager(_$AppDatabase db, $PokemonTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PokemonTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PokemonTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PokemonTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> nameEs = const Value.absent(),
                Value<String> nameEn = const Value.absent(),
                Value<String?> nameJa = const Value.absent(),
                Value<int?> speciesId = const Value.absent(),
                Value<bool> isDefault = const Value.absent(),
                Value<String?> formNameEs = const Value.absent(),
                Value<String?> formNameEn = const Value.absent(),
                Value<int> generationId = const Value.absent(),
                Value<int?> evolutionChainId = const Value.absent(),
                Value<int> hp = const Value.absent(),
                Value<int> attack = const Value.absent(),
                Value<int> defense = const Value.absent(),
                Value<int> specialAttack = const Value.absent(),
                Value<int> specialDefense = const Value.absent(),
                Value<int> speed = const Value.absent(),
                Value<int> statTotal = const Value.absent(),
                Value<String?> spriteUrl = const Value.absent(),
                Value<String?> artworkUrl = const Value.absent(),
                Value<String?> shinyArtworkUrl = const Value.absent(),
                Value<String?> spriteFile = const Value.absent(),
                Value<String?> artworkFile = const Value.absent(),
                Value<bool> hasDetail = const Value.absent(),
                Value<int?> height = const Value.absent(),
                Value<int?> weight = const Value.absent(),
                Value<String?> flavorEs = const Value.absent(),
                Value<String?> flavorEn = const Value.absent(),
                Value<String?> eggGroups = const Value.absent(),
                Value<int?> captureRate = const Value.absent(),
                Value<bool> isLegendary = const Value.absent(),
                Value<bool> isMythical = const Value.absent(),
              }) => PokemonCompanion(
                id: id,
                name: name,
                nameEs: nameEs,
                nameEn: nameEn,
                nameJa: nameJa,
                speciesId: speciesId,
                isDefault: isDefault,
                formNameEs: formNameEs,
                formNameEn: formNameEn,
                generationId: generationId,
                evolutionChainId: evolutionChainId,
                hp: hp,
                attack: attack,
                defense: defense,
                specialAttack: specialAttack,
                specialDefense: specialDefense,
                speed: speed,
                statTotal: statTotal,
                spriteUrl: spriteUrl,
                artworkUrl: artworkUrl,
                shinyArtworkUrl: shinyArtworkUrl,
                spriteFile: spriteFile,
                artworkFile: artworkFile,
                hasDetail: hasDetail,
                height: height,
                weight: weight,
                flavorEs: flavorEs,
                flavorEn: flavorEn,
                eggGroups: eggGroups,
                captureRate: captureRate,
                isLegendary: isLegendary,
                isMythical: isMythical,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                required String nameEs,
                required String nameEn,
                Value<String?> nameJa = const Value.absent(),
                Value<int?> speciesId = const Value.absent(),
                Value<bool> isDefault = const Value.absent(),
                Value<String?> formNameEs = const Value.absent(),
                Value<String?> formNameEn = const Value.absent(),
                required int generationId,
                Value<int?> evolutionChainId = const Value.absent(),
                required int hp,
                required int attack,
                required int defense,
                required int specialAttack,
                required int specialDefense,
                required int speed,
                required int statTotal,
                Value<String?> spriteUrl = const Value.absent(),
                Value<String?> artworkUrl = const Value.absent(),
                Value<String?> shinyArtworkUrl = const Value.absent(),
                Value<String?> spriteFile = const Value.absent(),
                Value<String?> artworkFile = const Value.absent(),
                Value<bool> hasDetail = const Value.absent(),
                Value<int?> height = const Value.absent(),
                Value<int?> weight = const Value.absent(),
                Value<String?> flavorEs = const Value.absent(),
                Value<String?> flavorEn = const Value.absent(),
                Value<String?> eggGroups = const Value.absent(),
                Value<int?> captureRate = const Value.absent(),
                Value<bool> isLegendary = const Value.absent(),
                Value<bool> isMythical = const Value.absent(),
              }) => PokemonCompanion.insert(
                id: id,
                name: name,
                nameEs: nameEs,
                nameEn: nameEn,
                nameJa: nameJa,
                speciesId: speciesId,
                isDefault: isDefault,
                formNameEs: formNameEs,
                formNameEn: formNameEn,
                generationId: generationId,
                evolutionChainId: evolutionChainId,
                hp: hp,
                attack: attack,
                defense: defense,
                specialAttack: specialAttack,
                specialDefense: specialDefense,
                speed: speed,
                statTotal: statTotal,
                spriteUrl: spriteUrl,
                artworkUrl: artworkUrl,
                shinyArtworkUrl: shinyArtworkUrl,
                spriteFile: spriteFile,
                artworkFile: artworkFile,
                hasDetail: hasDetail,
                height: height,
                weight: weight,
                flavorEs: flavorEs,
                flavorEn: flavorEn,
                eggGroups: eggGroups,
                captureRate: captureRate,
                isLegendary: isLegendary,
                isMythical: isMythical,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$PokemonTable, PokemonRow>(table),
                  BaseReferences<_$AppDatabase, $PokemonTable, PokemonRow>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$PokemonTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PokemonTable,
      PokemonRow,
      $$PokemonTableFilterComposer,
      $$PokemonTableOrderingComposer,
      $$PokemonTableAnnotationComposer,
      $$PokemonTableCreateCompanionBuilder,
      $$PokemonTableUpdateCompanionBuilder,
      (PokemonRow, BaseReferences<_$AppDatabase, $PokemonTable, PokemonRow>),
      PokemonRow,
      PrefetchHooks Function()
    >;
typedef $$PokeTypesTableCreateCompanionBuilder = PokeTypesCompanion Function({
  Value<int> id,
  required String name,
  required String nameEs,
  required String nameEn,
});
typedef $$PokeTypesTableUpdateCompanionBuilder = PokeTypesCompanion Function({
  Value<int> id,
  Value<String> name,
  Value<String> nameEs,
  Value<String> nameEn,
});

class $$PokeTypesTableFilterComposer
    extends Composer<_$AppDatabase, $PokeTypesTable> {
  $$PokeTypesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nameEs => $composableBuilder(
    column: $table.nameEs,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nameEn => $composableBuilder(
    column: $table.nameEn,
    builder: (column) => ColumnFilters(column),
  );
}

class $$PokeTypesTableOrderingComposer
    extends Composer<_$AppDatabase, $PokeTypesTable> {
  $$PokeTypesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nameEs => $composableBuilder(
    column: $table.nameEs,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nameEn => $composableBuilder(
    column: $table.nameEn,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PokeTypesTableAnnotationComposer
    extends Composer<_$AppDatabase, $PokeTypesTable> {
  $$PokeTypesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get nameEs =>
      $composableBuilder(column: $table.nameEs, builder: (column) => column);

  GeneratedColumn<String> get nameEn =>
      $composableBuilder(column: $table.nameEn, builder: (column) => column);
}

class $$PokeTypesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PokeTypesTable,
          PokeTypeRow,
          $$PokeTypesTableFilterComposer,
          $$PokeTypesTableOrderingComposer,
          $$PokeTypesTableAnnotationComposer,
          $$PokeTypesTableCreateCompanionBuilder,
          $$PokeTypesTableUpdateCompanionBuilder,
          (
            PokeTypeRow,
            BaseReferences<_$AppDatabase, $PokeTypesTable, PokeTypeRow>,
          ),
          PokeTypeRow,
          PrefetchHooks Function()
        > {
  $$PokeTypesTableTableManager(_$AppDatabase db, $PokeTypesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PokeTypesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PokeTypesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PokeTypesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> nameEs = const Value.absent(),
                Value<String> nameEn = const Value.absent(),
              }) => PokeTypesCompanion(
                id: id,
                name: name,
                nameEs: nameEs,
                nameEn: nameEn,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                required String nameEs,
                required String nameEn,
              }) => PokeTypesCompanion.insert(
                id: id,
                name: name,
                nameEs: nameEs,
                nameEn: nameEn,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$PokeTypesTable, PokeTypeRow>(table),
                  BaseReferences<_$AppDatabase, $PokeTypesTable, PokeTypeRow>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$PokeTypesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PokeTypesTable,
      PokeTypeRow,
      $$PokeTypesTableFilterComposer,
      $$PokeTypesTableOrderingComposer,
      $$PokeTypesTableAnnotationComposer,
      $$PokeTypesTableCreateCompanionBuilder,
      $$PokeTypesTableUpdateCompanionBuilder,
      (
        PokeTypeRow,
        BaseReferences<_$AppDatabase, $PokeTypesTable, PokeTypeRow>,
      ),
      PokeTypeRow,
      PrefetchHooks Function()
    >;
typedef $$PokemonTypesTableCreateCompanionBuilder =
    PokemonTypesCompanion Function({
      required int pokemonId,
      required int typeId,
      required int slot,
      Value<int> rowid,
    });
typedef $$PokemonTypesTableUpdateCompanionBuilder =
    PokemonTypesCompanion Function({
      Value<int> pokemonId,
      Value<int> typeId,
      Value<int> slot,
      Value<int> rowid,
    });

class $$PokemonTypesTableFilterComposer
    extends Composer<_$AppDatabase, $PokemonTypesTable> {
  $$PokemonTypesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get pokemonId => $composableBuilder(
    column: $table.pokemonId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get typeId => $composableBuilder(
    column: $table.typeId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get slot => $composableBuilder(
    column: $table.slot,
    builder: (column) => ColumnFilters(column),
  );
}

class $$PokemonTypesTableOrderingComposer
    extends Composer<_$AppDatabase, $PokemonTypesTable> {
  $$PokemonTypesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get pokemonId => $composableBuilder(
    column: $table.pokemonId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get typeId => $composableBuilder(
    column: $table.typeId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get slot => $composableBuilder(
    column: $table.slot,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PokemonTypesTableAnnotationComposer
    extends Composer<_$AppDatabase, $PokemonTypesTable> {
  $$PokemonTypesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get pokemonId =>
      $composableBuilder(column: $table.pokemonId, builder: (column) => column);

  GeneratedColumn<int> get typeId =>
      $composableBuilder(column: $table.typeId, builder: (column) => column);

  GeneratedColumn<int> get slot =>
      $composableBuilder(column: $table.slot, builder: (column) => column);
}

class $$PokemonTypesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PokemonTypesTable,
          PokemonTypeRow,
          $$PokemonTypesTableFilterComposer,
          $$PokemonTypesTableOrderingComposer,
          $$PokemonTypesTableAnnotationComposer,
          $$PokemonTypesTableCreateCompanionBuilder,
          $$PokemonTypesTableUpdateCompanionBuilder,
          (
            PokemonTypeRow,
            BaseReferences<_$AppDatabase, $PokemonTypesTable, PokemonTypeRow>,
          ),
          PokemonTypeRow,
          PrefetchHooks Function()
        > {
  $$PokemonTypesTableTableManager(_$AppDatabase db, $PokemonTypesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PokemonTypesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PokemonTypesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PokemonTypesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> pokemonId = const Value.absent(),
                Value<int> typeId = const Value.absent(),
                Value<int> slot = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PokemonTypesCompanion(
                pokemonId: pokemonId,
                typeId: typeId,
                slot: slot,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required int pokemonId,
                required int typeId,
                required int slot,
                Value<int> rowid = const Value.absent(),
              }) => PokemonTypesCompanion.insert(
                pokemonId: pokemonId,
                typeId: typeId,
                slot: slot,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$PokemonTypesTable, PokemonTypeRow>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $PokemonTypesTable,
                    PokemonTypeRow
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$PokemonTypesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PokemonTypesTable,
      PokemonTypeRow,
      $$PokemonTypesTableFilterComposer,
      $$PokemonTypesTableOrderingComposer,
      $$PokemonTypesTableAnnotationComposer,
      $$PokemonTypesTableCreateCompanionBuilder,
      $$PokemonTypesTableUpdateCompanionBuilder,
      (
        PokemonTypeRow,
        BaseReferences<_$AppDatabase, $PokemonTypesTable, PokemonTypeRow>,
      ),
      PokemonTypeRow,
      PrefetchHooks Function()
    >;
typedef $$TypeEfficacyTableCreateCompanionBuilder =
    TypeEfficacyCompanion Function({
      required int attackTypeId,
      required int targetTypeId,
      required int factor,
      Value<int> rowid,
    });
typedef $$TypeEfficacyTableUpdateCompanionBuilder =
    TypeEfficacyCompanion Function({
      Value<int> attackTypeId,
      Value<int> targetTypeId,
      Value<int> factor,
      Value<int> rowid,
    });

class $$TypeEfficacyTableFilterComposer
    extends Composer<_$AppDatabase, $TypeEfficacyTable> {
  $$TypeEfficacyTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get attackTypeId => $composableBuilder(
    column: $table.attackTypeId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get targetTypeId => $composableBuilder(
    column: $table.targetTypeId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get factor => $composableBuilder(
    column: $table.factor,
    builder: (column) => ColumnFilters(column),
  );
}

class $$TypeEfficacyTableOrderingComposer
    extends Composer<_$AppDatabase, $TypeEfficacyTable> {
  $$TypeEfficacyTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get attackTypeId => $composableBuilder(
    column: $table.attackTypeId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get targetTypeId => $composableBuilder(
    column: $table.targetTypeId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get factor => $composableBuilder(
    column: $table.factor,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$TypeEfficacyTableAnnotationComposer
    extends Composer<_$AppDatabase, $TypeEfficacyTable> {
  $$TypeEfficacyTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get attackTypeId => $composableBuilder(
    column: $table.attackTypeId,
    builder: (column) => column,
  );

  GeneratedColumn<int> get targetTypeId => $composableBuilder(
    column: $table.targetTypeId,
    builder: (column) => column,
  );

  GeneratedColumn<int> get factor =>
      $composableBuilder(column: $table.factor, builder: (column) => column);
}

class $$TypeEfficacyTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TypeEfficacyTable,
          TypeEfficacyRow,
          $$TypeEfficacyTableFilterComposer,
          $$TypeEfficacyTableOrderingComposer,
          $$TypeEfficacyTableAnnotationComposer,
          $$TypeEfficacyTableCreateCompanionBuilder,
          $$TypeEfficacyTableUpdateCompanionBuilder,
          (
            TypeEfficacyRow,
            BaseReferences<_$AppDatabase, $TypeEfficacyTable, TypeEfficacyRow>,
          ),
          TypeEfficacyRow,
          PrefetchHooks Function()
        > {
  $$TypeEfficacyTableTableManager(_$AppDatabase db, $TypeEfficacyTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TypeEfficacyTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TypeEfficacyTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TypeEfficacyTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> attackTypeId = const Value.absent(),
                Value<int> targetTypeId = const Value.absent(),
                Value<int> factor = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TypeEfficacyCompanion(
                attackTypeId: attackTypeId,
                targetTypeId: targetTypeId,
                factor: factor,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required int attackTypeId,
                required int targetTypeId,
                required int factor,
                Value<int> rowid = const Value.absent(),
              }) => TypeEfficacyCompanion.insert(
                attackTypeId: attackTypeId,
                targetTypeId: targetTypeId,
                factor: factor,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$TypeEfficacyTable, TypeEfficacyRow>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $TypeEfficacyTable,
                    TypeEfficacyRow
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$TypeEfficacyTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TypeEfficacyTable,
      TypeEfficacyRow,
      $$TypeEfficacyTableFilterComposer,
      $$TypeEfficacyTableOrderingComposer,
      $$TypeEfficacyTableAnnotationComposer,
      $$TypeEfficacyTableCreateCompanionBuilder,
      $$TypeEfficacyTableUpdateCompanionBuilder,
      (
        TypeEfficacyRow,
        BaseReferences<_$AppDatabase, $TypeEfficacyTable, TypeEfficacyRow>,
      ),
      TypeEfficacyRow,
      PrefetchHooks Function()
    >;
typedef $$GenerationsTableCreateCompanionBuilder =
    GenerationsCompanion Function({
      Value<int> id,
      required String name,
      required String regionName,
    });
typedef $$GenerationsTableUpdateCompanionBuilder =
    GenerationsCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String> regionName,
    });

class $$GenerationsTableFilterComposer
    extends Composer<_$AppDatabase, $GenerationsTable> {
  $$GenerationsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get regionName => $composableBuilder(
    column: $table.regionName,
    builder: (column) => ColumnFilters(column),
  );
}

class $$GenerationsTableOrderingComposer
    extends Composer<_$AppDatabase, $GenerationsTable> {
  $$GenerationsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get regionName => $composableBuilder(
    column: $table.regionName,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$GenerationsTableAnnotationComposer
    extends Composer<_$AppDatabase, $GenerationsTable> {
  $$GenerationsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get regionName => $composableBuilder(
    column: $table.regionName,
    builder: (column) => column,
  );
}

class $$GenerationsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $GenerationsTable,
          GenerationRow,
          $$GenerationsTableFilterComposer,
          $$GenerationsTableOrderingComposer,
          $$GenerationsTableAnnotationComposer,
          $$GenerationsTableCreateCompanionBuilder,
          $$GenerationsTableUpdateCompanionBuilder,
          (
            GenerationRow,
            BaseReferences<_$AppDatabase, $GenerationsTable, GenerationRow>,
          ),
          GenerationRow,
          PrefetchHooks Function()
        > {
  $$GenerationsTableTableManager(_$AppDatabase db, $GenerationsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$GenerationsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$GenerationsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$GenerationsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> regionName = const Value.absent(),
              }) => GenerationsCompanion(
                id: id,
                name: name,
                regionName: regionName,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                required String regionName,
              }) => GenerationsCompanion.insert(
                id: id,
                name: name,
                regionName: regionName,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$GenerationsTable, GenerationRow>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $GenerationsTable,
                    GenerationRow
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$GenerationsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $GenerationsTable,
      GenerationRow,
      $$GenerationsTableFilterComposer,
      $$GenerationsTableOrderingComposer,
      $$GenerationsTableAnnotationComposer,
      $$GenerationsTableCreateCompanionBuilder,
      $$GenerationsTableUpdateCompanionBuilder,
      (
        GenerationRow,
        BaseReferences<_$AppDatabase, $GenerationsTable, GenerationRow>,
      ),
      GenerationRow,
      PrefetchHooks Function()
    >;
typedef $$VersionGroupsTableCreateCompanionBuilder =
    VersionGroupsCompanion Function({
      Value<int> id,
      required String name,
      required int generationId,
      required int sortOrder,
    });
typedef $$VersionGroupsTableUpdateCompanionBuilder =
    VersionGroupsCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<int> generationId,
      Value<int> sortOrder,
    });

class $$VersionGroupsTableFilterComposer
    extends Composer<_$AppDatabase, $VersionGroupsTable> {
  $$VersionGroupsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get generationId => $composableBuilder(
    column: $table.generationId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );
}

class $$VersionGroupsTableOrderingComposer
    extends Composer<_$AppDatabase, $VersionGroupsTable> {
  $$VersionGroupsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get generationId => $composableBuilder(
    column: $table.generationId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$VersionGroupsTableAnnotationComposer
    extends Composer<_$AppDatabase, $VersionGroupsTable> {
  $$VersionGroupsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<int> get generationId => $composableBuilder(
    column: $table.generationId,
    builder: (column) => column,
  );

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);
}

class $$VersionGroupsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $VersionGroupsTable,
          VersionGroupRow,
          $$VersionGroupsTableFilterComposer,
          $$VersionGroupsTableOrderingComposer,
          $$VersionGroupsTableAnnotationComposer,
          $$VersionGroupsTableCreateCompanionBuilder,
          $$VersionGroupsTableUpdateCompanionBuilder,
          (
            VersionGroupRow,
            BaseReferences<_$AppDatabase, $VersionGroupsTable, VersionGroupRow>,
          ),
          VersionGroupRow,
          PrefetchHooks Function()
        > {
  $$VersionGroupsTableTableManager(_$AppDatabase db, $VersionGroupsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$VersionGroupsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$VersionGroupsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$VersionGroupsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<int> generationId = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
              }) => VersionGroupsCompanion(
                id: id,
                name: name,
                generationId: generationId,
                sortOrder: sortOrder,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                required int generationId,
                required int sortOrder,
              }) => VersionGroupsCompanion.insert(
                id: id,
                name: name,
                generationId: generationId,
                sortOrder: sortOrder,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$VersionGroupsTable, VersionGroupRow>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $VersionGroupsTable,
                    VersionGroupRow
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$VersionGroupsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $VersionGroupsTable,
      VersionGroupRow,
      $$VersionGroupsTableFilterComposer,
      $$VersionGroupsTableOrderingComposer,
      $$VersionGroupsTableAnnotationComposer,
      $$VersionGroupsTableCreateCompanionBuilder,
      $$VersionGroupsTableUpdateCompanionBuilder,
      (
        VersionGroupRow,
        BaseReferences<_$AppDatabase, $VersionGroupsTable, VersionGroupRow>,
      ),
      VersionGroupRow,
      PrefetchHooks Function()
    >;
typedef $$AbilitiesTableCreateCompanionBuilder = AbilitiesCompanion Function({
  Value<int> id,
  required String name,
  required String nameEs,
  required String nameEn,
  Value<String?> effectEs,
  Value<String?> effectEn,
});
typedef $$AbilitiesTableUpdateCompanionBuilder = AbilitiesCompanion Function({
  Value<int> id,
  Value<String> name,
  Value<String> nameEs,
  Value<String> nameEn,
  Value<String?> effectEs,
  Value<String?> effectEn,
});

class $$AbilitiesTableFilterComposer
    extends Composer<_$AppDatabase, $AbilitiesTable> {
  $$AbilitiesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nameEs => $composableBuilder(
    column: $table.nameEs,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nameEn => $composableBuilder(
    column: $table.nameEn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get effectEs => $composableBuilder(
    column: $table.effectEs,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get effectEn => $composableBuilder(
    column: $table.effectEn,
    builder: (column) => ColumnFilters(column),
  );
}

class $$AbilitiesTableOrderingComposer
    extends Composer<_$AppDatabase, $AbilitiesTable> {
  $$AbilitiesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nameEs => $composableBuilder(
    column: $table.nameEs,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nameEn => $composableBuilder(
    column: $table.nameEn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get effectEs => $composableBuilder(
    column: $table.effectEs,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get effectEn => $composableBuilder(
    column: $table.effectEn,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AbilitiesTableAnnotationComposer
    extends Composer<_$AppDatabase, $AbilitiesTable> {
  $$AbilitiesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get nameEs =>
      $composableBuilder(column: $table.nameEs, builder: (column) => column);

  GeneratedColumn<String> get nameEn =>
      $composableBuilder(column: $table.nameEn, builder: (column) => column);

  GeneratedColumn<String> get effectEs =>
      $composableBuilder(column: $table.effectEs, builder: (column) => column);

  GeneratedColumn<String> get effectEn =>
      $composableBuilder(column: $table.effectEn, builder: (column) => column);
}

class $$AbilitiesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AbilitiesTable,
          AbilityRow,
          $$AbilitiesTableFilterComposer,
          $$AbilitiesTableOrderingComposer,
          $$AbilitiesTableAnnotationComposer,
          $$AbilitiesTableCreateCompanionBuilder,
          $$AbilitiesTableUpdateCompanionBuilder,
          (
            AbilityRow,
            BaseReferences<_$AppDatabase, $AbilitiesTable, AbilityRow>,
          ),
          AbilityRow,
          PrefetchHooks Function()
        > {
  $$AbilitiesTableTableManager(_$AppDatabase db, $AbilitiesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AbilitiesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AbilitiesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AbilitiesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> nameEs = const Value.absent(),
                Value<String> nameEn = const Value.absent(),
                Value<String?> effectEs = const Value.absent(),
                Value<String?> effectEn = const Value.absent(),
              }) => AbilitiesCompanion(
                id: id,
                name: name,
                nameEs: nameEs,
                nameEn: nameEn,
                effectEs: effectEs,
                effectEn: effectEn,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                required String nameEs,
                required String nameEn,
                Value<String?> effectEs = const Value.absent(),
                Value<String?> effectEn = const Value.absent(),
              }) => AbilitiesCompanion.insert(
                id: id,
                name: name,
                nameEs: nameEs,
                nameEn: nameEn,
                effectEs: effectEs,
                effectEn: effectEn,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$AbilitiesTable, AbilityRow>(table),
                  BaseReferences<_$AppDatabase, $AbilitiesTable, AbilityRow>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AbilitiesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AbilitiesTable,
      AbilityRow,
      $$AbilitiesTableFilterComposer,
      $$AbilitiesTableOrderingComposer,
      $$AbilitiesTableAnnotationComposer,
      $$AbilitiesTableCreateCompanionBuilder,
      $$AbilitiesTableUpdateCompanionBuilder,
      (AbilityRow, BaseReferences<_$AppDatabase, $AbilitiesTable, AbilityRow>),
      AbilityRow,
      PrefetchHooks Function()
    >;
typedef $$PokemonAbilitiesTableCreateCompanionBuilder =
    PokemonAbilitiesCompanion Function({
      required int pokemonId,
      required int abilityId,
      required bool isHidden,
      Value<int> rowid,
    });
typedef $$PokemonAbilitiesTableUpdateCompanionBuilder =
    PokemonAbilitiesCompanion Function({
      Value<int> pokemonId,
      Value<int> abilityId,
      Value<bool> isHidden,
      Value<int> rowid,
    });

class $$PokemonAbilitiesTableFilterComposer
    extends Composer<_$AppDatabase, $PokemonAbilitiesTable> {
  $$PokemonAbilitiesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get pokemonId => $composableBuilder(
    column: $table.pokemonId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get abilityId => $composableBuilder(
    column: $table.abilityId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isHidden => $composableBuilder(
    column: $table.isHidden,
    builder: (column) => ColumnFilters(column),
  );
}

class $$PokemonAbilitiesTableOrderingComposer
    extends Composer<_$AppDatabase, $PokemonAbilitiesTable> {
  $$PokemonAbilitiesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get pokemonId => $composableBuilder(
    column: $table.pokemonId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get abilityId => $composableBuilder(
    column: $table.abilityId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isHidden => $composableBuilder(
    column: $table.isHidden,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PokemonAbilitiesTableAnnotationComposer
    extends Composer<_$AppDatabase, $PokemonAbilitiesTable> {
  $$PokemonAbilitiesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get pokemonId =>
      $composableBuilder(column: $table.pokemonId, builder: (column) => column);

  GeneratedColumn<int> get abilityId =>
      $composableBuilder(column: $table.abilityId, builder: (column) => column);

  GeneratedColumn<bool> get isHidden =>
      $composableBuilder(column: $table.isHidden, builder: (column) => column);
}

class $$PokemonAbilitiesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PokemonAbilitiesTable,
          PokemonAbilityRow,
          $$PokemonAbilitiesTableFilterComposer,
          $$PokemonAbilitiesTableOrderingComposer,
          $$PokemonAbilitiesTableAnnotationComposer,
          $$PokemonAbilitiesTableCreateCompanionBuilder,
          $$PokemonAbilitiesTableUpdateCompanionBuilder,
          (
            PokemonAbilityRow,
            BaseReferences<
              _$AppDatabase,
              $PokemonAbilitiesTable,
              PokemonAbilityRow
            >,
          ),
          PokemonAbilityRow,
          PrefetchHooks Function()
        > {
  $$PokemonAbilitiesTableTableManager(
    _$AppDatabase db,
    $PokemonAbilitiesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PokemonAbilitiesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PokemonAbilitiesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PokemonAbilitiesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> pokemonId = const Value.absent(),
                Value<int> abilityId = const Value.absent(),
                Value<bool> isHidden = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PokemonAbilitiesCompanion(
                pokemonId: pokemonId,
                abilityId: abilityId,
                isHidden: isHidden,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required int pokemonId,
                required int abilityId,
                required bool isHidden,
                Value<int> rowid = const Value.absent(),
              }) => PokemonAbilitiesCompanion.insert(
                pokemonId: pokemonId,
                abilityId: abilityId,
                isHidden: isHidden,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$PokemonAbilitiesTable, PokemonAbilityRow>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $PokemonAbilitiesTable,
                    PokemonAbilityRow
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$PokemonAbilitiesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PokemonAbilitiesTable,
      PokemonAbilityRow,
      $$PokemonAbilitiesTableFilterComposer,
      $$PokemonAbilitiesTableOrderingComposer,
      $$PokemonAbilitiesTableAnnotationComposer,
      $$PokemonAbilitiesTableCreateCompanionBuilder,
      $$PokemonAbilitiesTableUpdateCompanionBuilder,
      (
        PokemonAbilityRow,
        BaseReferences<
          _$AppDatabase,
          $PokemonAbilitiesTable,
          PokemonAbilityRow
        >,
      ),
      PokemonAbilityRow,
      PrefetchHooks Function()
    >;
typedef $$MovesTableCreateCompanionBuilder = MovesCompanion Function({
  Value<int> id,
  required String name,
  Value<int?> power,
  Value<int?> accuracy,
  Value<int?> pp,
  required int typeId,
  required int damageClassId,
});
typedef $$MovesTableUpdateCompanionBuilder = MovesCompanion Function({
  Value<int> id,
  Value<String> name,
  Value<int?> power,
  Value<int?> accuracy,
  Value<int?> pp,
  Value<int> typeId,
  Value<int> damageClassId,
});

class $$MovesTableFilterComposer extends Composer<_$AppDatabase, $MovesTable> {
  $$MovesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get power => $composableBuilder(
    column: $table.power,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get accuracy => $composableBuilder(
    column: $table.accuracy,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get pp => $composableBuilder(
    column: $table.pp,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get typeId => $composableBuilder(
    column: $table.typeId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get damageClassId => $composableBuilder(
    column: $table.damageClassId,
    builder: (column) => ColumnFilters(column),
  );
}

class $$MovesTableOrderingComposer
    extends Composer<_$AppDatabase, $MovesTable> {
  $$MovesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get power => $composableBuilder(
    column: $table.power,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get accuracy => $composableBuilder(
    column: $table.accuracy,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get pp => $composableBuilder(
    column: $table.pp,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get typeId => $composableBuilder(
    column: $table.typeId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get damageClassId => $composableBuilder(
    column: $table.damageClassId,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$MovesTableAnnotationComposer
    extends Composer<_$AppDatabase, $MovesTable> {
  $$MovesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<int> get power =>
      $composableBuilder(column: $table.power, builder: (column) => column);

  GeneratedColumn<int> get accuracy =>
      $composableBuilder(column: $table.accuracy, builder: (column) => column);

  GeneratedColumn<int> get pp =>
      $composableBuilder(column: $table.pp, builder: (column) => column);

  GeneratedColumn<int> get typeId =>
      $composableBuilder(column: $table.typeId, builder: (column) => column);

  GeneratedColumn<int> get damageClassId => $composableBuilder(
    column: $table.damageClassId,
    builder: (column) => column,
  );
}

class $$MovesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MovesTable,
          MoveRow,
          $$MovesTableFilterComposer,
          $$MovesTableOrderingComposer,
          $$MovesTableAnnotationComposer,
          $$MovesTableCreateCompanionBuilder,
          $$MovesTableUpdateCompanionBuilder,
          (MoveRow, BaseReferences<_$AppDatabase, $MovesTable, MoveRow>),
          MoveRow,
          PrefetchHooks Function()
        > {
  $$MovesTableTableManager(_$AppDatabase db, $MovesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MovesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MovesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MovesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<int?> power = const Value.absent(),
                Value<int?> accuracy = const Value.absent(),
                Value<int?> pp = const Value.absent(),
                Value<int> typeId = const Value.absent(),
                Value<int> damageClassId = const Value.absent(),
              }) => MovesCompanion(
                id: id,
                name: name,
                power: power,
                accuracy: accuracy,
                pp: pp,
                typeId: typeId,
                damageClassId: damageClassId,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                Value<int?> power = const Value.absent(),
                Value<int?> accuracy = const Value.absent(),
                Value<int?> pp = const Value.absent(),
                required int typeId,
                required int damageClassId,
              }) => MovesCompanion.insert(
                id: id,
                name: name,
                power: power,
                accuracy: accuracy,
                pp: pp,
                typeId: typeId,
                damageClassId: damageClassId,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$MovesTable, MoveRow>(table),
                  BaseReferences<_$AppDatabase, $MovesTable, MoveRow>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$MovesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MovesTable,
      MoveRow,
      $$MovesTableFilterComposer,
      $$MovesTableOrderingComposer,
      $$MovesTableAnnotationComposer,
      $$MovesTableCreateCompanionBuilder,
      $$MovesTableUpdateCompanionBuilder,
      (MoveRow, BaseReferences<_$AppDatabase, $MovesTable, MoveRow>),
      MoveRow,
      PrefetchHooks Function()
    >;
typedef $$PokemonMovesTableCreateCompanionBuilder =
    PokemonMovesCompanion Function({
      required int pokemonId,
      required int moveId,
      required int versionGroupId,
      required int methodId,
      required int level,
      Value<int> rowid,
    });
typedef $$PokemonMovesTableUpdateCompanionBuilder =
    PokemonMovesCompanion Function({
      Value<int> pokemonId,
      Value<int> moveId,
      Value<int> versionGroupId,
      Value<int> methodId,
      Value<int> level,
      Value<int> rowid,
    });

class $$PokemonMovesTableFilterComposer
    extends Composer<_$AppDatabase, $PokemonMovesTable> {
  $$PokemonMovesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get pokemonId => $composableBuilder(
    column: $table.pokemonId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get moveId => $composableBuilder(
    column: $table.moveId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get versionGroupId => $composableBuilder(
    column: $table.versionGroupId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get methodId => $composableBuilder(
    column: $table.methodId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get level => $composableBuilder(
    column: $table.level,
    builder: (column) => ColumnFilters(column),
  );
}

class $$PokemonMovesTableOrderingComposer
    extends Composer<_$AppDatabase, $PokemonMovesTable> {
  $$PokemonMovesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get pokemonId => $composableBuilder(
    column: $table.pokemonId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get moveId => $composableBuilder(
    column: $table.moveId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get versionGroupId => $composableBuilder(
    column: $table.versionGroupId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get methodId => $composableBuilder(
    column: $table.methodId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get level => $composableBuilder(
    column: $table.level,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PokemonMovesTableAnnotationComposer
    extends Composer<_$AppDatabase, $PokemonMovesTable> {
  $$PokemonMovesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get pokemonId =>
      $composableBuilder(column: $table.pokemonId, builder: (column) => column);

  GeneratedColumn<int> get moveId =>
      $composableBuilder(column: $table.moveId, builder: (column) => column);

  GeneratedColumn<int> get versionGroupId => $composableBuilder(
    column: $table.versionGroupId,
    builder: (column) => column,
  );

  GeneratedColumn<int> get methodId =>
      $composableBuilder(column: $table.methodId, builder: (column) => column);

  GeneratedColumn<int> get level =>
      $composableBuilder(column: $table.level, builder: (column) => column);
}

class $$PokemonMovesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PokemonMovesTable,
          PokemonMoveRow,
          $$PokemonMovesTableFilterComposer,
          $$PokemonMovesTableOrderingComposer,
          $$PokemonMovesTableAnnotationComposer,
          $$PokemonMovesTableCreateCompanionBuilder,
          $$PokemonMovesTableUpdateCompanionBuilder,
          (
            PokemonMoveRow,
            BaseReferences<_$AppDatabase, $PokemonMovesTable, PokemonMoveRow>,
          ),
          PokemonMoveRow,
          PrefetchHooks Function()
        > {
  $$PokemonMovesTableTableManager(_$AppDatabase db, $PokemonMovesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PokemonMovesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PokemonMovesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PokemonMovesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> pokemonId = const Value.absent(),
                Value<int> moveId = const Value.absent(),
                Value<int> versionGroupId = const Value.absent(),
                Value<int> methodId = const Value.absent(),
                Value<int> level = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PokemonMovesCompanion(
                pokemonId: pokemonId,
                moveId: moveId,
                versionGroupId: versionGroupId,
                methodId: methodId,
                level: level,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required int pokemonId,
                required int moveId,
                required int versionGroupId,
                required int methodId,
                required int level,
                Value<int> rowid = const Value.absent(),
              }) => PokemonMovesCompanion.insert(
                pokemonId: pokemonId,
                moveId: moveId,
                versionGroupId: versionGroupId,
                methodId: methodId,
                level: level,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$PokemonMovesTable, PokemonMoveRow>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $PokemonMovesTable,
                    PokemonMoveRow
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$PokemonMovesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PokemonMovesTable,
      PokemonMoveRow,
      $$PokemonMovesTableFilterComposer,
      $$PokemonMovesTableOrderingComposer,
      $$PokemonMovesTableAnnotationComposer,
      $$PokemonMovesTableCreateCompanionBuilder,
      $$PokemonMovesTableUpdateCompanionBuilder,
      (
        PokemonMoveRow,
        BaseReferences<_$AppDatabase, $PokemonMovesTable, PokemonMoveRow>,
      ),
      PokemonMoveRow,
      PrefetchHooks Function()
    >;
typedef $$EvolutionsTableCreateCompanionBuilder = EvolutionsCompanion Function({
  Value<int> speciesId,
  required int chainId,
  Value<int?> fromSpeciesId,
  required String name,
  Value<String?> trigger,
  Value<int?> minLevel,
  Value<String?> item,
  Value<int?> minHappiness,
  Value<String?> timeOfDay,
});
typedef $$EvolutionsTableUpdateCompanionBuilder = EvolutionsCompanion Function({
  Value<int> speciesId,
  Value<int> chainId,
  Value<int?> fromSpeciesId,
  Value<String> name,
  Value<String?> trigger,
  Value<int?> minLevel,
  Value<String?> item,
  Value<int?> minHappiness,
  Value<String?> timeOfDay,
});

class $$EvolutionsTableFilterComposer
    extends Composer<_$AppDatabase, $EvolutionsTable> {
  $$EvolutionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get speciesId => $composableBuilder(
    column: $table.speciesId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get chainId => $composableBuilder(
    column: $table.chainId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get fromSpeciesId => $composableBuilder(
    column: $table.fromSpeciesId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get trigger => $composableBuilder(
    column: $table.trigger,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get minLevel => $composableBuilder(
    column: $table.minLevel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get item => $composableBuilder(
    column: $table.item,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get minHappiness => $composableBuilder(
    column: $table.minHappiness,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get timeOfDay => $composableBuilder(
    column: $table.timeOfDay,
    builder: (column) => ColumnFilters(column),
  );
}

class $$EvolutionsTableOrderingComposer
    extends Composer<_$AppDatabase, $EvolutionsTable> {
  $$EvolutionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get speciesId => $composableBuilder(
    column: $table.speciesId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get chainId => $composableBuilder(
    column: $table.chainId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get fromSpeciesId => $composableBuilder(
    column: $table.fromSpeciesId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get trigger => $composableBuilder(
    column: $table.trigger,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get minLevel => $composableBuilder(
    column: $table.minLevel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get item => $composableBuilder(
    column: $table.item,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get minHappiness => $composableBuilder(
    column: $table.minHappiness,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get timeOfDay => $composableBuilder(
    column: $table.timeOfDay,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$EvolutionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $EvolutionsTable> {
  $$EvolutionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get speciesId =>
      $composableBuilder(column: $table.speciesId, builder: (column) => column);

  GeneratedColumn<int> get chainId =>
      $composableBuilder(column: $table.chainId, builder: (column) => column);

  GeneratedColumn<int> get fromSpeciesId => $composableBuilder(
    column: $table.fromSpeciesId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get trigger =>
      $composableBuilder(column: $table.trigger, builder: (column) => column);

  GeneratedColumn<int> get minLevel =>
      $composableBuilder(column: $table.minLevel, builder: (column) => column);

  GeneratedColumn<String> get item =>
      $composableBuilder(column: $table.item, builder: (column) => column);

  GeneratedColumn<int> get minHappiness => $composableBuilder(
    column: $table.minHappiness,
    builder: (column) => column,
  );

  GeneratedColumn<String> get timeOfDay =>
      $composableBuilder(column: $table.timeOfDay, builder: (column) => column);
}

class $$EvolutionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $EvolutionsTable,
          EvolutionRow,
          $$EvolutionsTableFilterComposer,
          $$EvolutionsTableOrderingComposer,
          $$EvolutionsTableAnnotationComposer,
          $$EvolutionsTableCreateCompanionBuilder,
          $$EvolutionsTableUpdateCompanionBuilder,
          (
            EvolutionRow,
            BaseReferences<_$AppDatabase, $EvolutionsTable, EvolutionRow>,
          ),
          EvolutionRow,
          PrefetchHooks Function()
        > {
  $$EvolutionsTableTableManager(_$AppDatabase db, $EvolutionsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$EvolutionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$EvolutionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$EvolutionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> speciesId = const Value.absent(),
                Value<int> chainId = const Value.absent(),
                Value<int?> fromSpeciesId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> trigger = const Value.absent(),
                Value<int?> minLevel = const Value.absent(),
                Value<String?> item = const Value.absent(),
                Value<int?> minHappiness = const Value.absent(),
                Value<String?> timeOfDay = const Value.absent(),
              }) => EvolutionsCompanion(
                speciesId: speciesId,
                chainId: chainId,
                fromSpeciesId: fromSpeciesId,
                name: name,
                trigger: trigger,
                minLevel: minLevel,
                item: item,
                minHappiness: minHappiness,
                timeOfDay: timeOfDay,
              ),
          createCompanionCallback:
              ({
                Value<int> speciesId = const Value.absent(),
                required int chainId,
                Value<int?> fromSpeciesId = const Value.absent(),
                required String name,
                Value<String?> trigger = const Value.absent(),
                Value<int?> minLevel = const Value.absent(),
                Value<String?> item = const Value.absent(),
                Value<int?> minHappiness = const Value.absent(),
                Value<String?> timeOfDay = const Value.absent(),
              }) => EvolutionsCompanion.insert(
                speciesId: speciesId,
                chainId: chainId,
                fromSpeciesId: fromSpeciesId,
                name: name,
                trigger: trigger,
                minLevel: minLevel,
                item: item,
                minHappiness: minHappiness,
                timeOfDay: timeOfDay,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$EvolutionsTable, EvolutionRow>(table),
                  BaseReferences<_$AppDatabase, $EvolutionsTable, EvolutionRow>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$EvolutionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $EvolutionsTable,
      EvolutionRow,
      $$EvolutionsTableFilterComposer,
      $$EvolutionsTableOrderingComposer,
      $$EvolutionsTableAnnotationComposer,
      $$EvolutionsTableCreateCompanionBuilder,
      $$EvolutionsTableUpdateCompanionBuilder,
      (
        EvolutionRow,
        BaseReferences<_$AppDatabase, $EvolutionsTable, EvolutionRow>,
      ),
      EvolutionRow,
      PrefetchHooks Function()
    >;
typedef $$FavoritesTableCreateCompanionBuilder = FavoritesCompanion Function({
  Value<int> pokemonId,
  required DateTime addedAt,
});
typedef $$FavoritesTableUpdateCompanionBuilder = FavoritesCompanion Function({
  Value<int> pokemonId,
  Value<DateTime> addedAt,
});

class $$FavoritesTableFilterComposer
    extends Composer<_$AppDatabase, $FavoritesTable> {
  $$FavoritesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get pokemonId => $composableBuilder(
    column: $table.pokemonId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get addedAt => $composableBuilder(
    column: $table.addedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$FavoritesTableOrderingComposer
    extends Composer<_$AppDatabase, $FavoritesTable> {
  $$FavoritesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get pokemonId => $composableBuilder(
    column: $table.pokemonId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get addedAt => $composableBuilder(
    column: $table.addedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$FavoritesTableAnnotationComposer
    extends Composer<_$AppDatabase, $FavoritesTable> {
  $$FavoritesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get pokemonId =>
      $composableBuilder(column: $table.pokemonId, builder: (column) => column);

  GeneratedColumn<DateTime> get addedAt =>
      $composableBuilder(column: $table.addedAt, builder: (column) => column);
}

class $$FavoritesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $FavoritesTable,
          FavoriteRow,
          $$FavoritesTableFilterComposer,
          $$FavoritesTableOrderingComposer,
          $$FavoritesTableAnnotationComposer,
          $$FavoritesTableCreateCompanionBuilder,
          $$FavoritesTableUpdateCompanionBuilder,
          (
            FavoriteRow,
            BaseReferences<_$AppDatabase, $FavoritesTable, FavoriteRow>,
          ),
          FavoriteRow,
          PrefetchHooks Function()
        > {
  $$FavoritesTableTableManager(_$AppDatabase db, $FavoritesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FavoritesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FavoritesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FavoritesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> pokemonId = const Value.absent(),
            Value<DateTime> addedAt = const Value.absent(),
          }) => FavoritesCompanion(pokemonId: pokemonId, addedAt: addedAt),
          createCompanionCallback:
              ({
                Value<int> pokemonId = const Value.absent(),
                required DateTime addedAt,
              }) => FavoritesCompanion.insert(
                pokemonId: pokemonId,
                addedAt: addedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$FavoritesTable, FavoriteRow>(table),
                  BaseReferences<_$AppDatabase, $FavoritesTable, FavoriteRow>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$FavoritesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $FavoritesTable,
      FavoriteRow,
      $$FavoritesTableFilterComposer,
      $$FavoritesTableOrderingComposer,
      $$FavoritesTableAnnotationComposer,
      $$FavoritesTableCreateCompanionBuilder,
      $$FavoritesTableUpdateCompanionBuilder,
      (
        FavoriteRow,
        BaseReferences<_$AppDatabase, $FavoritesTable, FavoriteRow>,
      ),
      FavoriteRow,
      PrefetchHooks Function()
    >;
typedef $$TriviaScoresTableCreateCompanionBuilder =
    TriviaScoresCompanion Function({
      Value<int> id,
      required int score,
      required int correct,
      required int total,
      required int bestStreak,
      required int durationMs,
      required DateTime playedAt,
    });
typedef $$TriviaScoresTableUpdateCompanionBuilder =
    TriviaScoresCompanion Function({
      Value<int> id,
      Value<int> score,
      Value<int> correct,
      Value<int> total,
      Value<int> bestStreak,
      Value<int> durationMs,
      Value<DateTime> playedAt,
    });

class $$TriviaScoresTableFilterComposer
    extends Composer<_$AppDatabase, $TriviaScoresTable> {
  $$TriviaScoresTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get score => $composableBuilder(
    column: $table.score,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get correct => $composableBuilder(
    column: $table.correct,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get total => $composableBuilder(
    column: $table.total,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get bestStreak => $composableBuilder(
    column: $table.bestStreak,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get durationMs => $composableBuilder(
    column: $table.durationMs,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get playedAt => $composableBuilder(
    column: $table.playedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$TriviaScoresTableOrderingComposer
    extends Composer<_$AppDatabase, $TriviaScoresTable> {
  $$TriviaScoresTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get score => $composableBuilder(
    column: $table.score,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get correct => $composableBuilder(
    column: $table.correct,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get total => $composableBuilder(
    column: $table.total,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get bestStreak => $composableBuilder(
    column: $table.bestStreak,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get durationMs => $composableBuilder(
    column: $table.durationMs,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get playedAt => $composableBuilder(
    column: $table.playedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$TriviaScoresTableAnnotationComposer
    extends Composer<_$AppDatabase, $TriviaScoresTable> {
  $$TriviaScoresTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get score =>
      $composableBuilder(column: $table.score, builder: (column) => column);

  GeneratedColumn<int> get correct =>
      $composableBuilder(column: $table.correct, builder: (column) => column);

  GeneratedColumn<int> get total =>
      $composableBuilder(column: $table.total, builder: (column) => column);

  GeneratedColumn<int> get bestStreak => $composableBuilder(
    column: $table.bestStreak,
    builder: (column) => column,
  );

  GeneratedColumn<int> get durationMs => $composableBuilder(
    column: $table.durationMs,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get playedAt =>
      $composableBuilder(column: $table.playedAt, builder: (column) => column);
}

class $$TriviaScoresTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TriviaScoresTable,
          TriviaScoreRow,
          $$TriviaScoresTableFilterComposer,
          $$TriviaScoresTableOrderingComposer,
          $$TriviaScoresTableAnnotationComposer,
          $$TriviaScoresTableCreateCompanionBuilder,
          $$TriviaScoresTableUpdateCompanionBuilder,
          (
            TriviaScoreRow,
            BaseReferences<_$AppDatabase, $TriviaScoresTable, TriviaScoreRow>,
          ),
          TriviaScoreRow,
          PrefetchHooks Function()
        > {
  $$TriviaScoresTableTableManager(_$AppDatabase db, $TriviaScoresTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TriviaScoresTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TriviaScoresTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TriviaScoresTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> score = const Value.absent(),
                Value<int> correct = const Value.absent(),
                Value<int> total = const Value.absent(),
                Value<int> bestStreak = const Value.absent(),
                Value<int> durationMs = const Value.absent(),
                Value<DateTime> playedAt = const Value.absent(),
              }) => TriviaScoresCompanion(
                id: id,
                score: score,
                correct: correct,
                total: total,
                bestStreak: bestStreak,
                durationMs: durationMs,
                playedAt: playedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int score,
                required int correct,
                required int total,
                required int bestStreak,
                required int durationMs,
                required DateTime playedAt,
              }) => TriviaScoresCompanion.insert(
                id: id,
                score: score,
                correct: correct,
                total: total,
                bestStreak: bestStreak,
                durationMs: durationMs,
                playedAt: playedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$TriviaScoresTable, TriviaScoreRow>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $TriviaScoresTable,
                    TriviaScoreRow
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$TriviaScoresTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TriviaScoresTable,
      TriviaScoreRow,
      $$TriviaScoresTableFilterComposer,
      $$TriviaScoresTableOrderingComposer,
      $$TriviaScoresTableAnnotationComposer,
      $$TriviaScoresTableCreateCompanionBuilder,
      $$TriviaScoresTableUpdateCompanionBuilder,
      (
        TriviaScoreRow,
        BaseReferences<_$AppDatabase, $TriviaScoresTable, TriviaScoreRow>,
      ),
      TriviaScoreRow,
      PrefetchHooks Function()
    >;
typedef $$AchievementsTableCreateCompanionBuilder =
    AchievementsCompanion Function({
      required String id,
      required DateTime unlockedAt,
      Value<int> rowid,
    });
typedef $$AchievementsTableUpdateCompanionBuilder =
    AchievementsCompanion Function({
      Value<String> id,
      Value<DateTime> unlockedAt,
      Value<int> rowid,
    });

class $$AchievementsTableFilterComposer
    extends Composer<_$AppDatabase, $AchievementsTable> {
  $$AchievementsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get unlockedAt => $composableBuilder(
    column: $table.unlockedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$AchievementsTableOrderingComposer
    extends Composer<_$AppDatabase, $AchievementsTable> {
  $$AchievementsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get unlockedAt => $composableBuilder(
    column: $table.unlockedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AchievementsTableAnnotationComposer
    extends Composer<_$AppDatabase, $AchievementsTable> {
  $$AchievementsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get unlockedAt => $composableBuilder(
    column: $table.unlockedAt,
    builder: (column) => column,
  );
}

class $$AchievementsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AchievementsTable,
          AchievementRow,
          $$AchievementsTableFilterComposer,
          $$AchievementsTableOrderingComposer,
          $$AchievementsTableAnnotationComposer,
          $$AchievementsTableCreateCompanionBuilder,
          $$AchievementsTableUpdateCompanionBuilder,
          (
            AchievementRow,
            BaseReferences<_$AppDatabase, $AchievementsTable, AchievementRow>,
          ),
          AchievementRow,
          PrefetchHooks Function()
        > {
  $$AchievementsTableTableManager(_$AppDatabase db, $AchievementsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AchievementsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AchievementsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AchievementsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> unlockedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AchievementsCompanion(
                id: id,
                unlockedAt: unlockedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required DateTime unlockedAt,
                Value<int> rowid = const Value.absent(),
              }) => AchievementsCompanion.insert(
                id: id,
                unlockedAt: unlockedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$AchievementsTable, AchievementRow>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $AchievementsTable,
                    AchievementRow
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AchievementsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AchievementsTable,
      AchievementRow,
      $$AchievementsTableFilterComposer,
      $$AchievementsTableOrderingComposer,
      $$AchievementsTableAnnotationComposer,
      $$AchievementsTableCreateCompanionBuilder,
      $$AchievementsTableUpdateCompanionBuilder,
      (
        AchievementRow,
        BaseReferences<_$AppDatabase, $AchievementsTable, AchievementRow>,
      ),
      AchievementRow,
      PrefetchHooks Function()
    >;
typedef $$BattleRecordsTableCreateCompanionBuilder =
    BattleRecordsCompanion Function({
      Value<int> id,
      required int playerId,
      required int rivalId,
      required bool won,
      required int turns,
      required DateTime playedAt,
    });
typedef $$BattleRecordsTableUpdateCompanionBuilder =
    BattleRecordsCompanion Function({
      Value<int> id,
      Value<int> playerId,
      Value<int> rivalId,
      Value<bool> won,
      Value<int> turns,
      Value<DateTime> playedAt,
    });

class $$BattleRecordsTableFilterComposer
    extends Composer<_$AppDatabase, $BattleRecordsTable> {
  $$BattleRecordsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get playerId => $composableBuilder(
    column: $table.playerId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get rivalId => $composableBuilder(
    column: $table.rivalId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get won => $composableBuilder(
    column: $table.won,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get turns => $composableBuilder(
    column: $table.turns,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get playedAt => $composableBuilder(
    column: $table.playedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$BattleRecordsTableOrderingComposer
    extends Composer<_$AppDatabase, $BattleRecordsTable> {
  $$BattleRecordsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get playerId => $composableBuilder(
    column: $table.playerId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get rivalId => $composableBuilder(
    column: $table.rivalId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get won => $composableBuilder(
    column: $table.won,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get turns => $composableBuilder(
    column: $table.turns,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get playedAt => $composableBuilder(
    column: $table.playedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$BattleRecordsTableAnnotationComposer
    extends Composer<_$AppDatabase, $BattleRecordsTable> {
  $$BattleRecordsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get playerId =>
      $composableBuilder(column: $table.playerId, builder: (column) => column);

  GeneratedColumn<int> get rivalId =>
      $composableBuilder(column: $table.rivalId, builder: (column) => column);

  GeneratedColumn<bool> get won =>
      $composableBuilder(column: $table.won, builder: (column) => column);

  GeneratedColumn<int> get turns =>
      $composableBuilder(column: $table.turns, builder: (column) => column);

  GeneratedColumn<DateTime> get playedAt =>
      $composableBuilder(column: $table.playedAt, builder: (column) => column);
}

class $$BattleRecordsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $BattleRecordsTable,
          BattleRecordRow,
          $$BattleRecordsTableFilterComposer,
          $$BattleRecordsTableOrderingComposer,
          $$BattleRecordsTableAnnotationComposer,
          $$BattleRecordsTableCreateCompanionBuilder,
          $$BattleRecordsTableUpdateCompanionBuilder,
          (
            BattleRecordRow,
            BaseReferences<_$AppDatabase, $BattleRecordsTable, BattleRecordRow>,
          ),
          BattleRecordRow,
          PrefetchHooks Function()
        > {
  $$BattleRecordsTableTableManager(_$AppDatabase db, $BattleRecordsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BattleRecordsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BattleRecordsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BattleRecordsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> playerId = const Value.absent(),
                Value<int> rivalId = const Value.absent(),
                Value<bool> won = const Value.absent(),
                Value<int> turns = const Value.absent(),
                Value<DateTime> playedAt = const Value.absent(),
              }) => BattleRecordsCompanion(
                id: id,
                playerId: playerId,
                rivalId: rivalId,
                won: won,
                turns: turns,
                playedAt: playedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int playerId,
                required int rivalId,
                required bool won,
                required int turns,
                required DateTime playedAt,
              }) => BattleRecordsCompanion.insert(
                id: id,
                playerId: playerId,
                rivalId: rivalId,
                won: won,
                turns: turns,
                playedAt: playedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$BattleRecordsTable, BattleRecordRow>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $BattleRecordsTable,
                    BattleRecordRow
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$BattleRecordsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $BattleRecordsTable,
      BattleRecordRow,
      $$BattleRecordsTableFilterComposer,
      $$BattleRecordsTableOrderingComposer,
      $$BattleRecordsTableAnnotationComposer,
      $$BattleRecordsTableCreateCompanionBuilder,
      $$BattleRecordsTableUpdateCompanionBuilder,
      (
        BattleRecordRow,
        BaseReferences<_$AppDatabase, $BattleRecordsTable, BattleRecordRow>,
      ),
      BattleRecordRow,
      PrefetchHooks Function()
    >;
typedef $$SyncMetaTableCreateCompanionBuilder = SyncMetaCompanion Function({
  required String resource,
  Value<DateTime?> lastSyncedAt,
  Value<String?> contentHash,
  Value<String> status,
  Value<int> attempts,
  Value<String?> lastError,
  Value<int> rowid,
});
typedef $$SyncMetaTableUpdateCompanionBuilder = SyncMetaCompanion Function({
  Value<String> resource,
  Value<DateTime?> lastSyncedAt,
  Value<String?> contentHash,
  Value<String> status,
  Value<int> attempts,
  Value<String?> lastError,
  Value<int> rowid,
});

class $$SyncMetaTableFilterComposer
    extends Composer<_$AppDatabase, $SyncMetaTable> {
  $$SyncMetaTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get resource => $composableBuilder(
    column: $table.resource,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastSyncedAt => $composableBuilder(
    column: $table.lastSyncedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get contentHash => $composableBuilder(
    column: $table.contentHash,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get attempts => $composableBuilder(
    column: $table.attempts,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lastError => $composableBuilder(
    column: $table.lastError,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SyncMetaTableOrderingComposer
    extends Composer<_$AppDatabase, $SyncMetaTable> {
  $$SyncMetaTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get resource => $composableBuilder(
    column: $table.resource,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastSyncedAt => $composableBuilder(
    column: $table.lastSyncedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get contentHash => $composableBuilder(
    column: $table.contentHash,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get attempts => $composableBuilder(
    column: $table.attempts,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lastError => $composableBuilder(
    column: $table.lastError,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SyncMetaTableAnnotationComposer
    extends Composer<_$AppDatabase, $SyncMetaTable> {
  $$SyncMetaTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get resource =>
      $composableBuilder(column: $table.resource, builder: (column) => column);

  GeneratedColumn<DateTime> get lastSyncedAt => $composableBuilder(
    column: $table.lastSyncedAt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get contentHash => $composableBuilder(
    column: $table.contentHash,
    builder: (column) => column,
  );

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<int> get attempts =>
      $composableBuilder(column: $table.attempts, builder: (column) => column);

  GeneratedColumn<String> get lastError =>
      $composableBuilder(column: $table.lastError, builder: (column) => column);
}

class $$SyncMetaTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SyncMetaTable,
          SyncMetaRow,
          $$SyncMetaTableFilterComposer,
          $$SyncMetaTableOrderingComposer,
          $$SyncMetaTableAnnotationComposer,
          $$SyncMetaTableCreateCompanionBuilder,
          $$SyncMetaTableUpdateCompanionBuilder,
          (
            SyncMetaRow,
            BaseReferences<_$AppDatabase, $SyncMetaTable, SyncMetaRow>,
          ),
          SyncMetaRow,
          PrefetchHooks Function()
        > {
  $$SyncMetaTableTableManager(_$AppDatabase db, $SyncMetaTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SyncMetaTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SyncMetaTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SyncMetaTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> resource = const Value.absent(),
                Value<DateTime?> lastSyncedAt = const Value.absent(),
                Value<String?> contentHash = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<int> attempts = const Value.absent(),
                Value<String?> lastError = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SyncMetaCompanion(
                resource: resource,
                lastSyncedAt: lastSyncedAt,
                contentHash: contentHash,
                status: status,
                attempts: attempts,
                lastError: lastError,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String resource,
                Value<DateTime?> lastSyncedAt = const Value.absent(),
                Value<String?> contentHash = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<int> attempts = const Value.absent(),
                Value<String?> lastError = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SyncMetaCompanion.insert(
                resource: resource,
                lastSyncedAt: lastSyncedAt,
                contentHash: contentHash,
                status: status,
                attempts: attempts,
                lastError: lastError,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$SyncMetaTable, SyncMetaRow>(table),
                  BaseReferences<_$AppDatabase, $SyncMetaTable, SyncMetaRow>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SyncMetaTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SyncMetaTable,
      SyncMetaRow,
      $$SyncMetaTableFilterComposer,
      $$SyncMetaTableOrderingComposer,
      $$SyncMetaTableAnnotationComposer,
      $$SyncMetaTableCreateCompanionBuilder,
      $$SyncMetaTableUpdateCompanionBuilder,
      (SyncMetaRow, BaseReferences<_$AppDatabase, $SyncMetaTable, SyncMetaRow>),
      SyncMetaRow,
      PrefetchHooks Function()
    >;
typedef $$AppSettingsTableCreateCompanionBuilder =
    AppSettingsCompanion Function({
      required String key,
      required String value,
      Value<int> rowid,
    });
typedef $$AppSettingsTableUpdateCompanionBuilder =
    AppSettingsCompanion Function({
      Value<String> key,
      Value<String> value,
      Value<int> rowid,
    });

class $$AppSettingsTableFilterComposer
    extends Composer<_$AppDatabase, $AppSettingsTable> {
  $$AppSettingsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnFilters(column),
  );
}

class $$AppSettingsTableOrderingComposer
    extends Composer<_$AppDatabase, $AppSettingsTable> {
  $$AppSettingsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AppSettingsTableAnnotationComposer
    extends Composer<_$AppDatabase, $AppSettingsTable> {
  $$AppSettingsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get key =>
      $composableBuilder(column: $table.key, builder: (column) => column);

  GeneratedColumn<String> get value =>
      $composableBuilder(column: $table.value, builder: (column) => column);
}

class $$AppSettingsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AppSettingsTable,
          SettingRow,
          $$AppSettingsTableFilterComposer,
          $$AppSettingsTableOrderingComposer,
          $$AppSettingsTableAnnotationComposer,
          $$AppSettingsTableCreateCompanionBuilder,
          $$AppSettingsTableUpdateCompanionBuilder,
          (
            SettingRow,
            BaseReferences<_$AppDatabase, $AppSettingsTable, SettingRow>,
          ),
          SettingRow,
          PrefetchHooks Function()
        > {
  $$AppSettingsTableTableManager(_$AppDatabase db, $AppSettingsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AppSettingsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AppSettingsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AppSettingsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> key = const Value.absent(),
            Value<String> value = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) => AppSettingsCompanion(key: key, value: value, rowid: rowid),
          createCompanionCallback:
              ({
                required String key,
                required String value,
                Value<int> rowid = const Value.absent(),
              }) => AppSettingsCompanion.insert(
                key: key,
                value: value,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$AppSettingsTable, SettingRow>(table),
                  BaseReferences<_$AppDatabase, $AppSettingsTable, SettingRow>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AppSettingsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AppSettingsTable,
      SettingRow,
      $$AppSettingsTableFilterComposer,
      $$AppSettingsTableOrderingComposer,
      $$AppSettingsTableAnnotationComposer,
      $$AppSettingsTableCreateCompanionBuilder,
      $$AppSettingsTableUpdateCompanionBuilder,
      (
        SettingRow,
        BaseReferences<_$AppDatabase, $AppSettingsTable, SettingRow>,
      ),
      SettingRow,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$PokemonTableTableManager get pokemon =>
      $$PokemonTableTableManager(_db, _db.pokemon);
  $$PokeTypesTableTableManager get pokeTypes =>
      $$PokeTypesTableTableManager(_db, _db.pokeTypes);
  $$PokemonTypesTableTableManager get pokemonTypes =>
      $$PokemonTypesTableTableManager(_db, _db.pokemonTypes);
  $$TypeEfficacyTableTableManager get typeEfficacy =>
      $$TypeEfficacyTableTableManager(_db, _db.typeEfficacy);
  $$GenerationsTableTableManager get generations =>
      $$GenerationsTableTableManager(_db, _db.generations);
  $$VersionGroupsTableTableManager get versionGroups =>
      $$VersionGroupsTableTableManager(_db, _db.versionGroups);
  $$AbilitiesTableTableManager get abilities =>
      $$AbilitiesTableTableManager(_db, _db.abilities);
  $$PokemonAbilitiesTableTableManager get pokemonAbilities =>
      $$PokemonAbilitiesTableTableManager(_db, _db.pokemonAbilities);
  $$MovesTableTableManager get moves =>
      $$MovesTableTableManager(_db, _db.moves);
  $$PokemonMovesTableTableManager get pokemonMoves =>
      $$PokemonMovesTableTableManager(_db, _db.pokemonMoves);
  $$EvolutionsTableTableManager get evolutions =>
      $$EvolutionsTableTableManager(_db, _db.evolutions);
  $$FavoritesTableTableManager get favorites =>
      $$FavoritesTableTableManager(_db, _db.favorites);
  $$TriviaScoresTableTableManager get triviaScores =>
      $$TriviaScoresTableTableManager(_db, _db.triviaScores);
  $$AchievementsTableTableManager get achievements =>
      $$AchievementsTableTableManager(_db, _db.achievements);
  $$BattleRecordsTableTableManager get battleRecords =>
      $$BattleRecordsTableTableManager(_db, _db.battleRecords);
  $$SyncMetaTableTableManager get syncMeta =>
      $$SyncMetaTableTableManager(_db, _db.syncMeta);
  $$AppSettingsTableTableManager get appSettings =>
      $$AppSettingsTableTableManager(_db, _db.appSettings);
}
