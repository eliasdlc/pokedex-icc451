import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/di/providers.dart';
import '../../../app/theme/app_tokens.dart';
import '../../../shared/l10n_x.dart';
import '../domain/debug_console.dart';
import '../../../shared/widgets/pokedex_header.dart';
import '../../../shared/widgets/pokedex_key.dart';
import '../../../shared/widgets/pokedex_switch.dart';

final _metaProvider = StreamProvider.autoDispose<List<SyncRecord>>(
  (ref) => ref.watch(debugConsoleProvider).watchSyncRecords(),
);

const _countStatement = 'SELECT COUNT(*) FROM pokemon;';
const _tamperStatement =
    "UPDATE pokemon SET name_es = 'Pikachuu' WHERE id = 25;";

/// Laboratorio de depuración: simula la caída de la API y altera la base a mano.
class LabScreen extends ConsumerStatefulWidget {
  const LabScreen({super.key});

  @override
  ConsumerState<LabScreen> createState() => _LabScreenState();
}

class _LabScreenState extends ConsumerState<LabScreen> {
  final _sql = TextEditingController();

  final _events = <String>[];

  @override
  void dispose() {
    _sql.dispose();
    super.dispose();
  }

  void _log(String line) => setState(() => _events.add(line));

  Future<void> _run(String statement) async {
    final statementText = statement.trim();
    if (statementText.isEmpty) return;
    final l10n = context.l10n;
    _log('[sql] $statementText');
    try {
      final result = await ref.read(debugConsoleProvider).run(statementText);
      if (result.changed == null) {
        _log('[sql] ${result.rows.join('\n')}');
        return;
      }
      _log('[sql] ${l10n.labSqlDone(result.changed!)}');
      // Tras alterar la base el vigilante corre ya, sin esperar sus 20 s.
      final tampered = await ref.read(syncServiceProvider).checkIntegrity();
      if (mounted) _log('[integridad] ${l10n.labIntegrityResult(tampered)}');
    } on Exception catch (e) {
      _log('[sql] $e');
    }
  }

  Future<void> _checkIntegrity() async {
    final l10n = context.l10n;
    final count = await ref.read(syncServiceProvider).checkIntegrity();
    if (mounted) _log('[integridad] ${l10n.labIntegrityResult(count)}');
  }

  void _syncNow() {
    _log('[sync] ${context.l10n.labSyncNow}');
    ref.read(syncServiceProvider).refresh(manual: true);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final t = context.tokens;
    final simulator = ref.watch(apiSimulatorProvider);
    final meta = ref.watch(_metaProvider).value ?? const [];
    return Scaffold(
      appBar: PokedexHeader(title: l10n.labTitle),
      body: ListView(
        padding: const EdgeInsets.all(Gaps.screen),
        children: [
          Container(
            padding: const EdgeInsets.all(Gaps.inside),
            decoration: BoxDecoration(
              color: t.sf,
              borderRadius: BorderRadius.circular(Radii.surface),
              border: Border.all(color: t.ln, width: 1.5),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ValueListenableBuilder<bool>(
                  valueListenable: simulator,
                  builder: (_, down, _) => MergeSemantics(
                    child: Semantics(
                      toggled: down,
                      child: InkWell(
                        onTap: () {
                          simulator.isApiDown = !down;
                          _log(
                            '[api] ${!down ? l10n.perfilLabApiDown : l10n.perfilLabApiUp}',
                          );
                        },
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(minHeight: 48),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      l10n.labSimulateApi,
                                      style: context.text.labelLarge,
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      l10n.labSimulateApiHint,
                                      style: context.text.labelSmall,
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: Gaps.row),
                              PokedexSwitch(value: down),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '--dart-define=SIMULATE_API_DOWN=true',
                  style: context.monoText.copyWith(fontSize: 12, color: t.mute),
                ),
              ],
            ),
          ),
          const SizedBox(height: Gaps.sibling),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
              PokedexKey(label: l10n.labSyncNow, onPressed: _syncNow),
              PokedexKey(
                label: l10n.labIntegrity,
                kind: PokedexKeyKind.outline,
                onPressed: _checkIntegrity,
              ),
            ],
          ),
          const SizedBox(height: Gaps.sibling),
          _EventConsole(events: _events, placeholder: l10n.perfilLabNoEvents),
          const SizedBox(height: Gaps.section),
          Text(
            l10n.labSql.toUpperCase(),
            style: context.text.labelMedium?.copyWith(letterSpacing: 0.72),
          ),
          const SizedBox(height: 8),
          _PresetQuery(
            statement: _countStatement,
            action: l10n.perfilLabCount,
            onRun: () => _run(_countStatement),
          ),
          const SizedBox(height: Gaps.sibling),
          _PresetQuery(
            statement: _tamperStatement,
            action: l10n.perfilLabTamper,
            onRun: () => _run(_tamperStatement),
          ),
          const SizedBox(height: Gaps.sibling),
          TextField(
            controller: _sql,
            minLines: 2,
            maxLines: 5,
            style: context.monoText.copyWith(color: t.ink),
            decoration: InputDecoration(
              hintText: l10n.labSqlHint,
              hintStyle: context.monoText.copyWith(color: t.mute),
            ),
          ),
          const SizedBox(height: 8),
          Align(
            alignment: Alignment.centerRight,
            child: PokedexKey(
              label: l10n.labRun,
              onPressed: () => _run(_sql.text),
            ),
          ),
          const SizedBox(height: Gaps.section),
          _MetaTable(title: l10n.labMeta, records: meta),
        ],
      ),
    );
  }
}

/// Fondo oscuro fijo: es una consola, no cambia con el tema.
class _EventConsole extends StatelessWidget {
  const _EventConsole({required this.events, required this.placeholder});

  final List<String> events;
  final String placeholder;

  static const _background = Color(0xFF111118);
  static const _text = Color(0xFFF2F3F7);

  @override
  Widget build(BuildContext context) {
    final style = context.monoText.copyWith(color: _text, fontSize: 12);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(Gaps.inside),
      decoration: BoxDecoration(
        color: _background,
        borderRadius: BorderRadius.circular(Radii.surface),
        border: Border.all(color: context.tokens.ln2),
      ),
      child: events.isEmpty
          ? Text(placeholder, style: style.copyWith(color: context.tokens.mute))
          : SelectableText(events.join('\n'), style: style),
    );
  }
}

class _PresetQuery extends StatelessWidget {
  const _PresetQuery({
    required this.statement,
    required this.action,
    required this.onRun,
  });

  final String statement;
  final String action;
  final VoidCallback onRun;

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: t.sf2,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              statement,
              style: context.monoText.copyWith(fontSize: 12, color: t.ink),
            ),
          ),
          const SizedBox(width: Gaps.row),
          PokedexKey(
            label: action,
            kind: PokedexKeyKind.outline,
            onPressed: onRun,
          ),
        ],
      ),
    );
  }
}

class _MetaTable extends StatelessWidget {
  const _MetaTable({required this.title, required this.records});

  final String title;
  final List<SyncRecord> records;

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    final l10n = context.l10n;
    final mono = context.monoText.copyWith(fontSize: 12, color: t.ink);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: t.sf2,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: mono.copyWith(color: t.mute)),
          const SizedBox(height: 4),
          for (final m in records)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 2),
              child: Row(
                children: [
                  Expanded(flex: 3, child: Text(m.resource, style: mono)),
                  Expanded(
                    flex: 2,
                    child: Text(
                      m.status,
                      style: mono.copyWith(
                        color: m.status == 'ok'
                            ? t.success
                            : m.status == 'stale'
                            ? t.warning
                            : t.acTexto,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Text(
                      timeAgo(l10n, m.lastSyncedAt),
                      textAlign: TextAlign.end,
                      style: mono.copyWith(color: t.mute),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
