enum CatalogSort { number, name, total, attack, defense, speed }

/// Búsqueda, filtros y orden del catálogo. Inmutable: cada cambio crea una
/// consulta nueva, que Riverpod compara con para decidir si reconsultar.
class CatalogQuery {
  const CatalogQuery({
    this.search = '',
    this.typeIds = const {},
    this.generationId,
    this.abilityId,
    this.sort = CatalogSort.number,
    this.ascending = true,
    this.favoritesOnly = false,
  });

  final String search;
  final Set<int> typeIds;
  final int? generationId;
  final int? abilityId;
  final CatalogSort sort;
  final bool ascending;
  final bool favoritesOnly;

  bool get hasFilters =>
      typeIds.isNotEmpty ||
      generationId != null ||
      abilityId != null ||
      favoritesOnly;

  CatalogQuery copyWith({
    String? search,
    Set<int>? typeIds,
    int? Function()? generationId,
    int? Function()? abilityId,
    CatalogSort? sort,
    bool? ascending,
    bool? favoritesOnly,
  }) => CatalogQuery(
    search: search ?? this.search,
    typeIds: typeIds ?? this.typeIds,
    generationId: generationId != null ? generationId() : this.generationId,
    abilityId: abilityId != null ? abilityId() : this.abilityId,
    sort: sort ?? this.sort,
    ascending: ascending ?? this.ascending,
    favoritesOnly: favoritesOnly ?? this.favoritesOnly,
  );

  Map<String, Object?> toJson() => {
    'search': search,
    'typeIds': typeIds.toList()..sort(),
    'generationId': generationId,
    'abilityId': abilityId,
    'sort': sort.name,
    'ascending': ascending,
    'favoritesOnly': favoritesOnly,
  };

  factory CatalogQuery.fromJson(Map<String, Object?> json) => CatalogQuery(
    search: json['search'] as String? ?? '',
    typeIds: {...(json['typeIds'] as List<Object?>? ?? const []).cast<int>()},
    generationId: json['generationId'] as int?,
    abilityId: json['abilityId'] as int?,
    sort: CatalogSort.values.asNameMap()[json['sort']] ?? CatalogSort.number,
    ascending: json['ascending'] as bool? ?? true,
    favoritesOnly: json['favoritesOnly'] as bool? ?? false,
  );

  @override
  bool operator ==(Object other) =>
      other is CatalogQuery &&
      other.search == search &&
      other.typeIds.length == typeIds.length &&
      other.typeIds.containsAll(typeIds) &&
      other.generationId == generationId &&
      other.abilityId == abilityId &&
      other.sort == sort &&
      other.ascending == ascending &&
      other.favoritesOnly == favoritesOnly;

  @override
  int get hashCode => Object.hash(
    search,
    Object.hashAllUnordered(typeIds),
    generationId,
    abilityId,
    sort,
    ascending,
    favoritesOnly,
  );
}
