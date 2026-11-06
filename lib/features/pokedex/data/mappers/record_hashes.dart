import '../../../../core/utils/content_hash.dart';

// Las dos huellas que guarda sync_meta. Se calculan con los MISMOS campos
// desde el DTO remoto y desde la fila local, si difieren hubo un cambio
// remoto o una alteración local.

String summaryHash({
  required int id,
  required String slug,
  required String nameEs,
  required String nameEn,
  required int generationId,
  required List<int> stats,
  required List<int> typeIdsBySlot,
}) => contentHash([
  id,
  slug,
  nameEs,
  nameEn,
  generationId,
  ...stats,
  typeIdsBySlot,
]);

String detailHash({
  required int? height,
  required int? weight,
  required String? flavorEs,
  required String? flavorEn,
  required String? eggGroups,
  required int? captureRate,
  required bool isLegendary,
  required bool isMythical,
}) => contentHash([
  height,
  weight,
  flavorEs,
  flavorEn,
  eggGroups,
  captureRate,
  isLegendary,
  isMythical,
]);

String summaryResource(int id) => 'pokemon:$id';
String detailResource(int id) => 'detail:$id';
const staticResource = 'static';
const catalogResource = 'catalog';
