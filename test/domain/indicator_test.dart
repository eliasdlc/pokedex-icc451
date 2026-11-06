import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex/core/connectivity/connectivity_state.dart';
import 'package:pokedex/core/error/failures.dart';
import 'package:pokedex/core/network/retry.dart';

void main() {
  group('composeIndicator', () {
    const idle = SyncState();
    const syncing = SyncState(activity: SyncActivity.syncing);

    test('los cuatro estados', () {
      expect(
        composeIndicator(ServiceAvailability.online, idle).status,
        IndicatorStatus.online,
      );
      expect(
        composeIndicator(ServiceAvailability.online, syncing).status,
        IndicatorStatus.syncing,
      );
      expect(
        composeIndicator(ServiceAvailability.offline, idle).status,
        IndicatorStatus.offline,
      );
      expect(
        composeIndicator(ServiceAvailability.serviceUnavailable, idle).status,
        IndicatorStatus.serviceUnavailable,
      );
    });

    test('nunca "sincronizando" sin servicio', () {
      expect(
        composeIndicator(ServiceAvailability.offline, syncing).status,
        IndicatorStatus.offline,
      );
    });

    test('origen de los datos', () {
      expect(
        composeIndicator(ServiceAvailability.online, idle).origin,
        DataOrigin.liveAndLocal,
      );
      expect(
        composeIndicator(ServiceAvailability.offline, idle).origin,
        DataOrigin.localOnly,
      );
    });
  });

  group('retryWithBackoff', () {
    test(
      'reintenta fallos transitorios con espera exponencial y se rinde',
      () async {
        final waits = <Duration>[];
        var attempts = 0;
        await expectLater(
          retryWithBackoff<void>(() async {
            attempts++;
            throw const ServiceUnavailableFailure();
          }, sleep: (d) async => waits.add(d)),
          throwsA(isA<ServiceUnavailableFailure>()),
        );
        expect(attempts, 4);
        expect(waits.length, 3);
        expect(waits[1].inMilliseconds, greaterThan(waits[0].inMilliseconds));
      },
    );

    test('no reintenta un error permanente', () async {
      var attempts = 0;
      await expectLater(
        retryWithBackoff<void>(() async {
          attempts++;
          throw const GraphQLFailure('campo inválido');
        }),
        throwsA(isA<GraphQLFailure>()),
      );
      expect(attempts, 1);
    });
  });
}
