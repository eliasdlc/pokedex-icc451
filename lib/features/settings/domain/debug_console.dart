class SyncRecord {
  const SyncRecord({
    required this.resource,
    required this.status,
    required this.lastSyncedAt,
  });
  final String resource;
  final String status;
  final DateTime? lastSyncedAt;
}

abstract interface class DebugConsole {
  Future<({List<String> rows, int? changed})> run(String statement);

  Stream<List<SyncRecord>> watchSyncRecords({int limit = 25});
}
