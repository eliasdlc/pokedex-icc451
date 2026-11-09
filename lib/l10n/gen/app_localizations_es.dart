// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'Pokédex';

  @override
  String get navPokedex => 'Pokédex';

  @override
  String get navFavorites => 'Favoritos';

  @override
  String get navPlay => 'Jugar';

  @override
  String get navSettings => 'Ajustes';

  @override
  String get statusOnline => 'En línea';

  @override
  String get statusOffline => 'Sin conexión';

  @override
  String get statusUnavailable => 'API caída';

  @override
  String get statusSyncing => 'Sincronizando';

  @override
  String get statusOnlineLong =>
      'Conectado. Los datos se actualizan desde PokéAPI y se guardan en el dispositivo.';

  @override
  String get statusOfflineLong =>
      'Sin conexión. Ves los datos guardados en el dispositivo.';

  @override
  String get statusUnavailableLong =>
      'Hay red, pero PokéAPI no responde. Ves los datos guardados en el dispositivo.';

  @override
  String get statusSyncingLong =>
      'Descargando cambios en segundo plano. Puedes seguir usando la app.';

  @override
  String get originLive => 'Origen: PokéAPI, guardado en el dispositivo';

  @override
  String get originLocal => 'Origen: solo datos del dispositivo';

  @override
  String lastSync(String when) {
    return 'Última sincronización: $when';
  }

  @override
  String get neverSynced => 'Aún no se ha sincronizado';

  @override
  String localCatalog(int local, String total) {
    return '$local de $total Pokémon en el dispositivo';
  }

  @override
  String pendingRepairs(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count registros alterados esperan corrección',
      one: '1 registro alterado espera corrección',
    );
    return '$_temp0';
  }

  @override
  String get retryNow => 'Reintentar ahora';

  @override
  String get close => 'Cerrar';

  @override
  String indicatorSemantics(String status) {
    return 'Estado de conexión: $status. Toca para ver detalles.';
  }

  @override
  String get justNow => 'hace un momento';

  @override
  String minutesAgo(int n) {
    return 'hace $n min';
  }

  @override
  String hoursAgo(int n) {
    return 'hace $n h';
  }

  @override
  String daysAgo(int n) {
    return 'hace $n d';
  }

  @override
  String get searchHint => 'Buscar por nombre o número';

  @override
  String get clearFilters => 'Limpiar';

  @override
  String get generationLabel => 'Generación';

  @override
  String get abilityLabel => 'Habilidad';

  @override
  String get anyOption => 'Cualquiera';

  @override
  String get favoritesOnly => 'Solo favoritos';

  @override
  String get sortAttack => 'Ataque';

  @override
  String get sortDefense => 'Defensa';

  @override
  String get sortSpeed => 'Velocidad';

  @override
  String get ascending => 'Ascendente';

  @override
  String get descending => 'Descendente';

  @override
  String get apply => 'Aplicar';

  @override
  String resultsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Pokémon',
      one: '1 Pokémon',
      zero: 'Ningún resultado',
    );
    return '$_temp0';
  }

  @override
  String partialCatalog(int local, int total) {
    return 'Catálogo parcial: $local de $total. Sin conexión solo se busca en lo descargado.';
  }

  @override
  String get emptyFirstLoadTitle => 'Preparando tu Pokédex';

  @override
  String get emptyFirstLoadBody =>
      'Descargando el catálogo. Los primeros Pokémon aparecen en segundos.';

  @override
  String get emptyResultsTitle => 'Ningún Pokémon coincide';

  @override
  String get emptyResultsBody => 'Prueba otro nombre o quita algún filtro.';

  @override
  String get errorTitle => 'Algo salió mal';

  @override
  String get errorBody =>
      'Los datos guardados siguen a salvo. Intenta de nuevo.';

  @override
  String get imageUnavailable => 'Imagen no disponible sin conexión';

  @override
  String get detailStats => 'Estadísticas base';

  @override
  String get detailAbilities => 'Habilidades';

  @override
  String get detailMoves => 'Movimientos';

  @override
  String get height => 'Altura';

  @override
  String get weight => 'Peso';

  @override
  String get eggGroups => 'Grupo huevo';

  @override
  String get captureRate => 'Captura';

  @override
  String get total => 'Total';

  @override
  String get weaknesses => 'Débil contra';

  @override
  String get resistances => 'Resiste';

  @override
  String get immunities => 'Inmune a';

  @override
  String get noEvolution => 'No evoluciona';

  @override
  String get legendary => 'Legendario';

  @override
  String get mythical => 'Singular';

  @override
  String get detailNotDownloaded =>
      'El detalle de este Pokémon todavía no se descargó. Conéctate para verlo completo.';

  @override
  String get tamperedBanner =>
      'Los datos locales de este Pokémon no coinciden con lo sincronizado. Se corregirán desde PokéAPI.';

  @override
  String get addFavorite => 'Agregar a favoritos';

  @override
  String get removeFavorite => 'Quitar de favoritos';

  @override
  String get shiny => 'Variocolor';

  @override
  String get share => 'Compartir tarjeta';

  @override
  String get favoriteAdded => 'Agregado a favoritos';

  @override
  String get favoriteRemoved => 'Quitado de favoritos';

  @override
  String get stat_hp => 'PS';

  @override
  String get stat_attack => 'Ataque';

  @override
  String get stat_defense => 'Defensa';

  @override
  String get stat_specialAttack => 'At. esp.';

  @override
  String get stat_specialDefense => 'Def. esp.';

  @override
  String get stat_speed => 'Velocidad';

  @override
  String evoLevel(int level) {
    return 'Nivel $level';
  }

  @override
  String evoItem(String item) {
    return 'Con $item';
  }

  @override
  String get evoTrade => 'Intercambio';

  @override
  String get evoFriendship => 'Amistad';

  @override
  String evoTime(String time) {
    return 'De $time';
  }

  @override
  String get evoOther => 'Condición especial';

  @override
  String get timeDay => 'día';

  @override
  String get timeNight => 'noche';

  @override
  String get favoritesTitle => 'Favoritos';

  @override
  String get playTitle => 'Jugar';

  @override
  String get battleTitle => 'Batalla Pokémon';

  @override
  String get regionsTitle => 'Regiones';

  @override
  String get achievementsTitle => 'Logros';

  @override
  String get start => 'Empezar';

  @override
  String get playAgain => 'Jugar otra vez';

  @override
  String triviaQuestion(int n, int total) {
    return 'Pregunta $n de $total';
  }

  @override
  String triviaCorrect(String name) {
    return '¡Correcto! Es $name.';
  }

  @override
  String triviaWrong(String name) {
    return 'Era $name.';
  }

  @override
  String triviaTimeout(String name) {
    return 'Se acabó el tiempo. Era $name.';
  }

  @override
  String get triviaFinished => 'Ronda terminada';

  @override
  String triviaResult(int correct, int total) {
    return '$correct de $total aciertos';
  }

  @override
  String newAchievement(String name) {
    return 'Logro desbloqueado: $name';
  }

  @override
  String get ach_firstCorrect => 'Primer acierto';

  @override
  String get ach_streak5 => 'Racha de 5';

  @override
  String get ach_perfectRound => 'Ronda perfecta';

  @override
  String get ach_score1000 => '1000 puntos';

  @override
  String get ach_firstBattleWin => 'Primera victoria';

  @override
  String get ach_fiveBattleWins => 'Cinco victorias';

  @override
  String get ach_collector10 => 'Coleccionista (10 favoritos)';

  @override
  String get ach_typeMaster => 'Maestro de tipos (súper eficaz x4)';

  @override
  String get battleChoose => 'Elige tu Pokémon';

  @override
  String get battleChooseHint =>
      'Solo aparecen Pokémon con detalle descargado.';

  @override
  String get battleNeedDetails =>
      'Abre la ficha de al menos 2 Pokémon con conexión para poder combatir sin ella.';

  @override
  String battleYourTurn(String name) {
    return '¿Qué hará $name?';
  }

  @override
  String battleUsed(String attacker, String move) {
    return '$attacker usó $move.';
  }

  @override
  String get battleMissed => '¡Falló!';

  @override
  String get battleSuper => '¡Es súper eficaz!';

  @override
  String get battleNotVery => 'No es muy eficaz…';

  @override
  String get battleNoEffect => 'No tiene efecto.';

  @override
  String get battleCritical => '¡Golpe crítico!';

  @override
  String get battleWon => '¡Ganaste!';

  @override
  String get battleLost => 'Perdiste';

  @override
  String battleStats(int won, int played) {
    return '$won victorias en $played batallas';
  }

  @override
  String get settingsTitle => 'Ajustes';

  @override
  String get themeLabel => 'Tema';

  @override
  String get themeLight => 'Claro';

  @override
  String get themeDark => 'Oscuro';

  @override
  String get languageLabel => 'Idioma';

  @override
  String get languageSystem => 'Sistema';

  @override
  String get labTitle => 'Laboratorio';

  @override
  String get labSubtitle => 'Herramientas para la defensa técnica';

  @override
  String get labSimulateApi => 'Simular caída de la API';

  @override
  String get labSimulateApiHint =>
      'Las consultas fallan como un 503 aunque haya red (prueba PA-08).';

  @override
  String get labSyncNow => 'Sincronizar ahora';

  @override
  String get labIntegrity => 'Verificar integridad ahora';

  @override
  String labIntegrityResult(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count registros alterados',
      one: '1 registro alterado',
      zero: 'Sin alteraciones',
    );
    return '$_temp0';
  }

  @override
  String get labSql => 'Consola SQL';

  @override
  String get labSqlHint =>
      'UPDATE pokemon SET name_es = \'Pikachu modificado\' WHERE id = 25';

  @override
  String get labRun => 'Ejecutar';

  @override
  String labSqlDone(int rows) {
    return 'Ejecutado. Filas: $rows';
  }

  @override
  String get labMeta => 'Metadatos de sincronización';

  @override
  String get onbTitle2 => 'Mira el indicador';

  @override
  String get onbBody2 =>
      'Arriba a la derecha verás si estás en línea, sin conexión, con la API caída o sincronizando. Tócalo para más detalles.';

  @override
  String get next => 'Siguiente';

  @override
  String get getStarted => 'Empezar';

  @override
  String battleDamage(int damage) {
    return 'Quitó $damage PS.';
  }

  @override
  String get detailForms => 'Formas';

  @override
  String get formDefault => 'Normal';

  @override
  String get movesVersion => 'Versión del juego';

  @override
  String get methodLevelUp => 'Nivel';

  @override
  String get methodMachine => 'MT';

  @override
  String get methodTutor => 'Tutor';

  @override
  String get methodEgg => 'Huevo';

  @override
  String get sortByLevel => 'Por nivel';

  @override
  String get sortByName => 'Por nombre';

  @override
  String get movesEmpty =>
      'No aprende movimientos por este método en esta versión.';

  @override
  String moveLevel(int level) {
    return 'Nv $level';
  }

  @override
  String get regionLabel => 'Región';

  @override
  String regionOpen(String region) {
    return 'Ver los Pokémon de $region en el catálogo';
  }

  @override
  String get moveOnEvolution => 'Evo';

  @override
  String get baseNavProfile => 'Perfil';

  @override
  String get baseContinue => 'Continuar';

  @override
  String get navegacionTypePickTitle => 'Selecciona el tipo';

  @override
  String get navegacionAllTypes => 'Todos los tipos';

  @override
  String navegacionTypesCount(int count) {
    return '$count tipos';
  }

  @override
  String get navegacionApplyFilter => 'Aplicar filtro';

  @override
  String get navegacionSortTitle => 'Ordenar por';

  @override
  String get navegacionSortNumberAsc => 'Menor número';

  @override
  String get navegacionSortNumberDesc => 'Mayor número';

  @override
  String get navegacionSortNameAsc => 'A-Z';

  @override
  String get navegacionSortNameDesc => 'Z-A';

  @override
  String get navegacionStatsSection => 'Estadísticas base';

  @override
  String navegacionPartialNote(int local, int total) {
    return 'Catálogo parcial: hay $local de $total guardados. El resto aparece al terminar la sincronización.';
  }

  @override
  String get navegacionSavedNote =>
      'Tu orden y tus filtros se guardan para la próxima vez.';

  @override
  String navegacionSeeResults(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Ver $count Pokémon',
      one: 'Ver 1 Pokémon',
      zero: 'Sin resultados',
    );
    return '$_temp0';
  }

  @override
  String get navegacionApiDownTitle => 'PokéAPI no está respondiendo';

  @override
  String get navegacionApiDownBody =>
      'Ves lo que ya está guardado. Vuelvo a intentarlo solo; si quieres, hazlo ahora.';

  @override
  String get navegacionEmptyDbTitle => 'Tu Pokédex todavía está vacía';

  @override
  String get navegacionEmptyDbBody =>
      'Necesito Internet una sola vez para descargarla. Después todo funciona sin conexión.';

  @override
  String get navegacionRetry => 'Reintentar';

  @override
  String get navegacionCheckConnection => 'Revisar mi conexión';

  @override
  String get navegacionFavEmptyTitle => 'Todavía no guardas ningún Pokémon';

  @override
  String get navegacionFavEmptyBody =>
      'Toca el corazón de cualquier Pokémon y aparecerá aquí, aunque no tengas Internet.';

  @override
  String get navegacionGoToPokedex => 'Ir a la Pokédex';

  @override
  String get navegacionRemove => 'Quitar';

  @override
  String navegacionRemovedFavorite(String name) {
    return 'Quitaste a $name de favoritos';
  }

  @override
  String get navegacionUndo => 'Deshacer';

  @override
  String get navegacionOnb1Title => 'Todos los Pokémon en un solo lugar';

  @override
  String get navegacionOnb1Body =>
      'Los 1025 Pokémon de las nueve generaciones, guardados en tu teléfono para verlos cuando quieras.';

  @override
  String get navegacionOnb3Title => '¿Listo para la aventura?';

  @override
  String get navegacionOnb3Body =>
      'Todo lo que veas queda guardado: catálogo, favoritos y trivia funcionan aunque no tengas conexión.';

  @override
  String get navegacionSkip => 'Saltar';

  @override
  String navegacionOnbPage(int page, int total) {
    return 'Página $page de $total';
  }

  @override
  String get detailTabAbout => 'Sobre';

  @override
  String get detailTabStats => 'Estadísticas';

  @override
  String get detailTabEvolutions => 'Evoluciones';

  @override
  String get detailTabMoves => 'Movimientos';

  @override
  String get detailCryReplay => 'Escuchar el grito';

  @override
  String get detailCryUnavailable => 'Grito no disponible';

  @override
  String get detailArtPixel => 'Pixel';

  @override
  String get detailArtIllustration => 'Ilustración';

  @override
  String get detailArt3d => '3D';

  @override
  String detailArtFallback(String requested, String shown) {
    return 'No hay $requested para este Pokémon: se muestra $shown.';
  }

  @override
  String get detailHiddenAbility => '(oculta)';

  @override
  String get detailSizeTitle => 'Tamaño';

  @override
  String detailSizeYou(String height) {
    return 'Tú, $height m';
  }

  @override
  String detailSizePokemon(String name, String height, String weight) {
    return '$name, $height m y $weight kg';
  }

  @override
  String detailWhereLives(String region) {
    return 'Ver dónde vive: $region';
  }

  @override
  String detailWhereLivesHint(String region) {
    return 'Lleva a la Pokédex filtrada por $region.';
  }

  @override
  String get detailFormsHint =>
      'Cada forma cambia el sprite, los tipos y los movimientos.';

  @override
  String detailFormsNone(String name) {
    return '$name no tiene otras formas.';
  }

  @override
  String get detailShareTitle => 'Tu carta';

  @override
  String get detailShareAsImage => 'Compartir como imagen';

  @override
  String get detailShareSave => 'Guardar imagen';

  @override
  String get detailShareFailed => 'No se pudo preparar la imagen de la carta.';

  @override
  String get detailCardHp => 'PS';

  @override
  String get detailCardStageBasic => 'BÁSICO';

  @override
  String get detailCardStage1 => 'FASE 1';

  @override
  String get detailCardStage2 => 'FASE 2';

  @override
  String get detailCardWeakness => 'debilidad';

  @override
  String get detailCardResistance => 'resistencia';

  @override
  String get detailCardRetreat => 'retirada';

  @override
  String get detailCardArtCredit => 'Ilus. arte oficial, vía PokéAPI';

  @override
  String get detailCardNoAttacks => 'Sin movimientos descargados';

  @override
  String get detailCardClassPhysical => 'Físico';

  @override
  String get detailCardClassSpecial => 'Especial';

  @override
  String get detailCardClassStatus => 'Estado';

  @override
  String detailCardAccuracy(int percent) {
    return 'precisión $percent %';
  }

  @override
  String get detailWeaknesses => 'Debilidades';

  @override
  String get detailResistances => 'Resistencias';

  @override
  String get detailImmunities => 'Inmunidades';

  @override
  String get detailEvolutions => 'Evoluciones';

  @override
  String get gamesHubProgressTitle => 'Tu Pokédex';

  @override
  String gamesHubProgressValue(int saved, int total) {
    return '$saved de $total guardados';
  }

  @override
  String get gamesTriviaCardBody => 'Adivina la silueta del Pokémon.';

  @override
  String get gamesBattleCardTitle => 'Batalla';

  @override
  String get gamesBattleCardBody => '1 contra 1 contra la CPU.';

  @override
  String get gamesEnter => 'Entrar';

  @override
  String get gamesBack => 'Volver';

  @override
  String get gamesTriviaPrompt => '¿Quién es ese Pokémon?';

  @override
  String gamesTriviaTime(int seconds) {
    return 'Tiempo restante: $seconds s';
  }

  @override
  String gamesTriviaPoints(int score) {
    return '$score pts';
  }

  @override
  String get gamesTriviaOfflineNote =>
      'La partida se guarda en el teléfono aunque no tengas Internet.';

  @override
  String get gamesTriviaNewAchievements => 'Logros nuevos';

  @override
  String get gamesTriviaRankingTitle => 'Ranking en este teléfono';

  @override
  String gamesTriviaFinalScore(int score) {
    return '$score puntos';
  }

  @override
  String get gamesNoDataTitle => 'Faltan Pokémon para jugar';

  @override
  String gamesNoDataBody(int needed, int have) {
    return 'Necesito al menos $needed guardados y tienes $have. Conéctate un momento para descargar más; después la trivia funciona sin Internet.';
  }

  @override
  String gamesNoDataEs(int needed, int have) {
    return 'Faltan Pokémon guardados para jugar la trivia: se necesitan al menos $needed y hay $have. Conéctate para descargar más.';
  }

  @override
  String gamesNoDataEn(int needed, int have) {
    return 'Not enough saved Pokémon to play trivia: at least $needed are needed and there are $have. Connect to download more.';
  }

  @override
  String get gamesRetryDownload => 'Reintentar la descarga';

  @override
  String get gamesViewPokedex => 'Ver mi Pokédex';

  @override
  String get gamesBattleSummary => 'CPU, 1 contra 1';

  @override
  String gamesBattleLevel(int level) {
    return 'Nv. $level';
  }

  @override
  String gamesBattleHp(int hp, int max) {
    return 'PS $hp / $max';
  }

  @override
  String gamesBattleHpSemantics(String name, int percent) {
    return '$name: $percent % de PS';
  }

  @override
  String gamesBattlePower(int power) {
    return 'Poder $power';
  }

  @override
  String gamesBattleMoveSemantics(String name, String type, int power) {
    return '$name, tipo $type, poder $power';
  }

  @override
  String get gamesTriviaCardTitle => 'Trivia';

  @override
  String get perfilTrainerDefaultName => 'Entrenador';

  @override
  String get perfilCardTitle => 'FICHA DE ENTRENADOR';

  @override
  String get perfilCardName => 'NOMBRE';

  @override
  String get perfilCardPokedex => 'POKéDEX';

  @override
  String get perfilCardTrivia => 'TRIVIA';

  @override
  String get perfilCardWins => 'VICTORIAS';

  @override
  String get perfilCardAchievements => 'LOGROS';

  @override
  String get perfilCardMedals => 'MEDALLAS';

  @override
  String perfilCardSemantics(String name, int saved, int earned, int total) {
    return 'Ficha de entrenador de $name: $saved Pokémon guardados, $earned de $total medallas';
  }

  @override
  String get perfilAchDone => 'Conseguido';

  @override
  String get perfilAchPending => 'Pendiente';

  @override
  String get perfilAchDesc_firstCorrect =>
      'Adivina tu primera silueta en la trivia';

  @override
  String get perfilAchDesc_streak5 => '5 respuestas seguidas en la trivia';

  @override
  String get perfilAchDesc_perfectRound =>
      'Una ronda de trivia sin ningún fallo';

  @override
  String get perfilAchDesc_score1000 =>
      'Suma 1000 puntos en una ronda de trivia';

  @override
  String get perfilAchDesc_firstBattleWin => 'Gana tu primera batalla';

  @override
  String get perfilAchDesc_fiveBattleWins => 'Gana cinco batallas';

  @override
  String get perfilAchDesc_collector10 => 'Marca 10 Pokémon como favoritos';

  @override
  String get perfilAchDesc_typeMaster =>
      'Usa un movimiento súper eficaz x4 en una batalla';

  @override
  String perfilRegionGeneration(int n) {
    return '$n.ª generación';
  }

  @override
  String perfilRegionProgress(int saved, int size) {
    return '$saved de $size guardados';
  }

  @override
  String get perfilRegionEmptyTitle => 'Aún no hay Pokémon de esta región';

  @override
  String get perfilRegionEmptyBody =>
      'Conéctate una vez para descargarlos. Después se ven sin conexión.';

  @override
  String get perfilThemeAuto => 'Automático';

  @override
  String get perfilArtMode => 'Arte de los Pokémon';

  @override
  String get perfilArtByGeneration => 'Por generación';

  @override
  String get perfilArtByGenerationHint =>
      'Pixel en la 1 a la 5, 3D en la 6 a la 9';

  @override
  String get perfilArtPixel => 'Pixel';

  @override
  String get perfilArtIllustration => 'Ilustración';

  @override
  String get perfilArt3d => '3D';

  @override
  String get perfilSectionPokedex => 'Pokédex';

  @override
  String get perfilSectionAppearance => 'Apariencia';

  @override
  String get perfilSectionData => 'Datos';

  @override
  String get perfilReduceMotion => 'Reducir movimiento';

  @override
  String get perfilReduceMotionHint =>
      'Sin la caída del sprite ni movimientos de adorno';

  @override
  String get perfilCryOnOpen => 'Grito al abrir el detalle';

  @override
  String get perfilCryOnOpenHint => 'Suena una vez al abrir la ficha';

  @override
  String get perfilAppLanguage => 'Idioma de la aplicación';

  @override
  String get perfilSyncNow => 'Sincronizar';

  @override
  String get perfilLabNoEvents =>
      'Sin eventos todavía. Lo que hagas aquí se anota en esta consola.';

  @override
  String get perfilLabCount => 'Contar filas';

  @override
  String get perfilLabTamper => 'Alterar dato';

  @override
  String get perfilLabApiDown => 'caída simulada';

  @override
  String get perfilLabApiUp => 'servicio normal';

  @override
  String get perfilLastSync => 'Última sincronización';
}
