import '../../../core/database/app_database.dart';
import '../domain/gamification_repository.dart';

class DriftGamificationRepository implements GamificationRepository {
  DriftGamificationRepository(this.db);
  final AppDatabase db;
}
