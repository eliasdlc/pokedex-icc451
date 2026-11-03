// ignore_for_file: avoid_print
import 'package:pokedex/features/pokedex/domain/entities/catalog_query.dart';
import 'package:pokedex/features/pokedex/domain/entities/poke_type.dart';
import 'package:pokedex/features/pokedex/domain/usecases/compute_matchups.dart';

void main() {
  const roca = PokeType(id: 6, slug: 'rock', nameEs: 'Roca', nameEn: 'Rock');
  const fuego = PokeType(id: 10, slug: 'fire', nameEs: 'Fuego', nameEn: 'Fire');
  const agua = PokeType(id: 11, slug: 'water', nameEs: 'Agua', nameEn: 'Water');
  final m = computeMatchups(
    defenderTypes: [fuego, roca],
    allTypes: [agua, fuego],
    efficacy: {(11, 10): 200, (11, 6): 200, (10, 10): 50, (10, 6): 50},
  );
  print('Agua contra Fuego/Roca: x${m.multipliers[agua]}');
  print('Fuego contra Fuego/Roca: x${m.multipliers[fuego]}');

  const q = CatalogQuery(generationId: 4);
  final sinGen = q.copyWith(generationId: () => null);
  print('antes: ${q.generationId}, después: ${sinGen.generationId}');
  print('iguales: ${q.copyWith() == q}');
}
