library;

enum ServiceAvailability { checking, online, offline, serviceUnavailable }

enum SyncActivity { idle, syncing }

class SyncState {
  const SyncState({
    this.activity = SyncActivity.idle,
    this.lastSyncedAt,
    this.lastError,
    this.localCount = 0,
    this.remoteTotal,
    this.pendingRepairs = 0,
  });

  final SyncActivity activity;
  final DateTime? lastSyncedAt;
  final String? lastError;
  final int localCount;
  final int? remoteTotal;

  /// Registros alterados a mano que esperan corrección desde la API.
  final int pendingRepairs;

  bool get isPartial => remoteTotal != null && localCount < remoteTotal!;

  SyncState copyWith({
    SyncActivity? activity,
    DateTime? lastSyncedAt,
    String? lastError,
    bool clearError = false,
    int? localCount,
    int? remoteTotal,
    int? pendingRepairs,
  }) => SyncState(
    activity: activity ?? this.activity,
    lastSyncedAt: lastSyncedAt ?? this.lastSyncedAt,
    lastError: clearError ? null : (lastError ?? this.lastError),
    localCount: localCount ?? this.localCount,
    remoteTotal: remoteTotal ?? this.remoteTotal,
    pendingRepairs: pendingRepairs ?? this.pendingRepairs,
  );
}

enum IndicatorStatus { online, offline, serviceUnavailable, syncing }

enum DataOrigin { liveAndLocal, localOnly }

class IndicatorView {
  const IndicatorView({
    required this.status,
    required this.origin,
    required this.lastSyncedAt,
    required this.isPartial,
    required this.localCount,
    required this.remoteTotal,
  });

  final IndicatorStatus status;
  final DataOrigin origin;
  final DateTime? lastSyncedAt;
  final bool isPartial;
  final int localCount;
  final int? remoteTotal;
}

IndicatorView composeIndicator(
  ServiceAvailability availability,
  SyncState sync,
) {
  final status = switch (availability) {
    ServiceAvailability.offline => IndicatorStatus.offline,
    ServiceAvailability.serviceUnavailable =>
      IndicatorStatus.serviceUnavailable,
    ServiceAvailability.checking => IndicatorStatus.offline,
    ServiceAvailability.online =>
      sync.activity == SyncActivity.syncing
          ? IndicatorStatus.syncing
          : IndicatorStatus.online,
  };
  return IndicatorView(
    status: status,
    origin: availability == ServiceAvailability.online
        ? DataOrigin.liveAndLocal
        : DataOrigin.localOnly,
    lastSyncedAt: sync.lastSyncedAt,
    isPartial: sync.isPartial,
    localCount: sync.localCount,
    remoteTotal: sync.remoteTotal,
  );
}

abstract interface class ConnectivityService {
  Stream<ServiceAvailability> watch();
  ServiceAvailability get current;

  Future<ServiceAvailability> recheck();

  void reportServiceFailure();
}
