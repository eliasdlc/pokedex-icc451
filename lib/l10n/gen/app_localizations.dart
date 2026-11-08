import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'gen/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('es'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In es, this message translates to:
  /// **'Pokédex'**
  String get appTitle;

  /// No description provided for @navPokedex.
  ///
  /// In es, this message translates to:
  /// **'Pokédex'**
  String get navPokedex;

  /// No description provided for @navFavorites.
  ///
  /// In es, this message translates to:
  /// **'Favoritos'**
  String get navFavorites;

  /// No description provided for @navPlay.
  ///
  /// In es, this message translates to:
  /// **'Jugar'**
  String get navPlay;

  /// No description provided for @navSettings.
  ///
  /// In es, this message translates to:
  /// **'Ajustes'**
  String get navSettings;

  /// No description provided for @statusOnline.
  ///
  /// In es, this message translates to:
  /// **'En línea'**
  String get statusOnline;

  /// No description provided for @statusOffline.
  ///
  /// In es, this message translates to:
  /// **'Sin conexión'**
  String get statusOffline;

  /// No description provided for @statusUnavailable.
  ///
  /// In es, this message translates to:
  /// **'API caída'**
  String get statusUnavailable;

  /// No description provided for @statusSyncing.
  ///
  /// In es, this message translates to:
  /// **'Sincronizando'**
  String get statusSyncing;

  /// No description provided for @statusOnlineLong.
  ///
  /// In es, this message translates to:
  /// **'Conectado. Los datos se actualizan desde PokéAPI y se guardan en el dispositivo.'**
  String get statusOnlineLong;

  /// No description provided for @statusOfflineLong.
  ///
  /// In es, this message translates to:
  /// **'Sin conexión. Ves los datos guardados en el dispositivo.'**
  String get statusOfflineLong;

  /// No description provided for @statusUnavailableLong.
  ///
  /// In es, this message translates to:
  /// **'Hay red, pero PokéAPI no responde. Ves los datos guardados en el dispositivo.'**
  String get statusUnavailableLong;

  /// No description provided for @statusSyncingLong.
  ///
  /// In es, this message translates to:
  /// **'Descargando cambios en segundo plano. Puedes seguir usando la app.'**
  String get statusSyncingLong;

  /// No description provided for @originLive.
  ///
  /// In es, this message translates to:
  /// **'Origen: PokéAPI, guardado en el dispositivo'**
  String get originLive;

  /// No description provided for @originLocal.
  ///
  /// In es, this message translates to:
  /// **'Origen: solo datos del dispositivo'**
  String get originLocal;

  /// No description provided for @lastSync.
  ///
  /// In es, this message translates to:
  /// **'Última sincronización: {when}'**
  String lastSync(String when);

  /// No description provided for @neverSynced.
  ///
  /// In es, this message translates to:
  /// **'Aún no se ha sincronizado'**
  String get neverSynced;

  /// No description provided for @localCatalog.
  ///
  /// In es, this message translates to:
  /// **'{local} de {total} Pokémon en el dispositivo'**
  String localCatalog(int local, String total);

  /// No description provided for @pendingRepairs.
  ///
  /// In es, this message translates to:
  /// **'{count, plural, =1{1 registro alterado espera corrección} other{{count} registros alterados esperan corrección}}'**
  String pendingRepairs(int count);

  /// No description provided for @retryNow.
  ///
  /// In es, this message translates to:
  /// **'Reintentar ahora'**
  String get retryNow;

  /// No description provided for @close.
  ///
  /// In es, this message translates to:
  /// **'Cerrar'**
  String get close;

  /// No description provided for @indicatorSemantics.
  ///
  /// In es, this message translates to:
  /// **'Estado de conexión: {status}. Toca para ver detalles.'**
  String indicatorSemantics(String status);

  /// No description provided for @justNow.
  ///
  /// In es, this message translates to:
  /// **'hace un momento'**
  String get justNow;

  /// No description provided for @minutesAgo.
  ///
  /// In es, this message translates to:
  /// **'hace {n} min'**
  String minutesAgo(int n);

  /// No description provided for @hoursAgo.
  ///
  /// In es, this message translates to:
  /// **'hace {n} h'**
  String hoursAgo(int n);

  /// No description provided for @daysAgo.
  ///
  /// In es, this message translates to:
  /// **'hace {n} d'**
  String daysAgo(int n);

  /// No description provided for @searchHint.
  ///
  /// In es, this message translates to:
  /// **'Buscar por nombre o número'**
  String get searchHint;

  /// No description provided for @clearFilters.
  ///
  /// In es, this message translates to:
  /// **'Limpiar'**
  String get clearFilters;

  /// No description provided for @generationLabel.
  ///
  /// In es, this message translates to:
  /// **'Generación'**
  String get generationLabel;

  /// No description provided for @abilityLabel.
  ///
  /// In es, this message translates to:
  /// **'Habilidad'**
  String get abilityLabel;

  /// No description provided for @anyOption.
  ///
  /// In es, this message translates to:
  /// **'Cualquiera'**
  String get anyOption;

  /// No description provided for @favoritesOnly.
  ///
  /// In es, this message translates to:
  /// **'Solo favoritos'**
  String get favoritesOnly;

  /// No description provided for @sortAttack.
  ///
  /// In es, this message translates to:
  /// **'Ataque'**
  String get sortAttack;

  /// No description provided for @sortDefense.
  ///
  /// In es, this message translates to:
  /// **'Defensa'**
  String get sortDefense;

  /// No description provided for @sortSpeed.
  ///
  /// In es, this message translates to:
  /// **'Velocidad'**
  String get sortSpeed;

  /// No description provided for @ascending.
  ///
  /// In es, this message translates to:
  /// **'Ascendente'**
  String get ascending;

  /// No description provided for @descending.
  ///
  /// In es, this message translates to:
  /// **'Descendente'**
  String get descending;

  /// No description provided for @apply.
  ///
  /// In es, this message translates to:
  /// **'Aplicar'**
  String get apply;

  /// No description provided for @resultsCount.
  ///
  /// In es, this message translates to:
  /// **'{count, plural, =0{Ningún resultado} =1{1 Pokémon} other{{count} Pokémon}}'**
  String resultsCount(int count);

  /// No description provided for @partialCatalog.
  ///
  /// In es, this message translates to:
  /// **'Catálogo parcial: {local} de {total}. Sin conexión solo se busca en lo descargado.'**
  String partialCatalog(int local, int total);

  /// No description provided for @emptyFirstLoadTitle.
  ///
  /// In es, this message translates to:
  /// **'Preparando tu Pokédex'**
  String get emptyFirstLoadTitle;

  /// No description provided for @emptyFirstLoadBody.
  ///
  /// In es, this message translates to:
  /// **'Descargando el catálogo. Los primeros Pokémon aparecen en segundos.'**
  String get emptyFirstLoadBody;

  /// No description provided for @emptyResultsTitle.
  ///
  /// In es, this message translates to:
  /// **'Ningún Pokémon coincide'**
  String get emptyResultsTitle;

  /// No description provided for @emptyResultsBody.
  ///
  /// In es, this message translates to:
  /// **'Prueba otro nombre o quita algún filtro.'**
  String get emptyResultsBody;

  /// No description provided for @errorTitle.
  ///
  /// In es, this message translates to:
  /// **'Algo salió mal'**
  String get errorTitle;

  /// No description provided for @errorBody.
  ///
  /// In es, this message translates to:
  /// **'Los datos guardados siguen a salvo. Intenta de nuevo.'**
  String get errorBody;

  /// No description provided for @imageUnavailable.
  ///
  /// In es, this message translates to:
  /// **'Imagen no disponible sin conexión'**
  String get imageUnavailable;

  /// No description provided for @detailStats.
  ///
  /// In es, this message translates to:
  /// **'Estadísticas base'**
  String get detailStats;

  /// No description provided for @detailAbilities.
  ///
  /// In es, this message translates to:
  /// **'Habilidades'**
  String get detailAbilities;

  /// No description provided for @detailMoves.
  ///
  /// In es, this message translates to:
  /// **'Movimientos'**
  String get detailMoves;

  /// No description provided for @height.
  ///
  /// In es, this message translates to:
  /// **'Altura'**
  String get height;

  /// No description provided for @weight.
  ///
  /// In es, this message translates to:
  /// **'Peso'**
  String get weight;

  /// No description provided for @eggGroups.
  ///
  /// In es, this message translates to:
  /// **'Grupo huevo'**
  String get eggGroups;

  /// No description provided for @captureRate.
  ///
  /// In es, this message translates to:
  /// **'Captura'**
  String get captureRate;

  /// No description provided for @total.
  ///
  /// In es, this message translates to:
  /// **'Total'**
  String get total;

  /// No description provided for @weaknesses.
  ///
  /// In es, this message translates to:
  /// **'Débil contra'**
  String get weaknesses;

  /// No description provided for @resistances.
  ///
  /// In es, this message translates to:
  /// **'Resiste'**
  String get resistances;

  /// No description provided for @immunities.
  ///
  /// In es, this message translates to:
  /// **'Inmune a'**
  String get immunities;

  /// No description provided for @noEvolution.
  ///
  /// In es, this message translates to:
  /// **'No evoluciona'**
  String get noEvolution;

  /// No description provided for @legendary.
  ///
  /// In es, this message translates to:
  /// **'Legendario'**
  String get legendary;

  /// No description provided for @mythical.
  ///
  /// In es, this message translates to:
  /// **'Singular'**
  String get mythical;

  /// No description provided for @detailNotDownloaded.
  ///
  /// In es, this message translates to:
  /// **'El detalle de este Pokémon todavía no se descargó. Conéctate para verlo completo.'**
  String get detailNotDownloaded;

  /// No description provided for @tamperedBanner.
  ///
  /// In es, this message translates to:
  /// **'Los datos locales de este Pokémon no coinciden con lo sincronizado. Se corregirán desde PokéAPI.'**
  String get tamperedBanner;

  /// No description provided for @addFavorite.
  ///
  /// In es, this message translates to:
  /// **'Agregar a favoritos'**
  String get addFavorite;

  /// No description provided for @removeFavorite.
  ///
  /// In es, this message translates to:
  /// **'Quitar de favoritos'**
  String get removeFavorite;

  /// No description provided for @shiny.
  ///
  /// In es, this message translates to:
  /// **'Variocolor'**
  String get shiny;

  /// No description provided for @share.
  ///
  /// In es, this message translates to:
  /// **'Compartir tarjeta'**
  String get share;

  /// No description provided for @favoriteAdded.
  ///
  /// In es, this message translates to:
  /// **'Agregado a favoritos'**
  String get favoriteAdded;

  /// No description provided for @favoriteRemoved.
  ///
  /// In es, this message translates to:
  /// **'Quitado de favoritos'**
  String get favoriteRemoved;

  /// No description provided for @stat_hp.
  ///
  /// In es, this message translates to:
  /// **'PS'**
  String get stat_hp;

  /// No description provided for @stat_attack.
  ///
  /// In es, this message translates to:
  /// **'Ataque'**
  String get stat_attack;

  /// No description provided for @stat_defense.
  ///
  /// In es, this message translates to:
  /// **'Defensa'**
  String get stat_defense;

  /// No description provided for @stat_specialAttack.
  ///
  /// In es, this message translates to:
  /// **'At. esp.'**
  String get stat_specialAttack;

  /// No description provided for @stat_specialDefense.
  ///
  /// In es, this message translates to:
  /// **'Def. esp.'**
  String get stat_specialDefense;

  /// No description provided for @stat_speed.
  ///
  /// In es, this message translates to:
  /// **'Velocidad'**
  String get stat_speed;

  /// No description provided for @evoLevel.
  ///
  /// In es, this message translates to:
  /// **'Nivel {level}'**
  String evoLevel(int level);

  /// No description provided for @evoItem.
  ///
  /// In es, this message translates to:
  /// **'Con {item}'**
  String evoItem(String item);

  /// No description provided for @evoTrade.
  ///
  /// In es, this message translates to:
  /// **'Intercambio'**
  String get evoTrade;

  /// No description provided for @evoFriendship.
  ///
  /// In es, this message translates to:
  /// **'Amistad'**
  String get evoFriendship;

  /// No description provided for @evoTime.
  ///
  /// In es, this message translates to:
  /// **'De {time}'**
  String evoTime(String time);

  /// No description provided for @evoOther.
  ///
  /// In es, this message translates to:
  /// **'Condición especial'**
  String get evoOther;

  /// No description provided for @timeDay.
  ///
  /// In es, this message translates to:
  /// **'día'**
  String get timeDay;

  /// No description provided for @timeNight.
  ///
  /// In es, this message translates to:
  /// **'noche'**
  String get timeNight;

  /// No description provided for @favoritesTitle.
  ///
  /// In es, this message translates to:
  /// **'Favoritos'**
  String get favoritesTitle;

  /// No description provided for @playTitle.
  ///
  /// In es, this message translates to:
  /// **'Jugar'**
  String get playTitle;

  /// No description provided for @battleTitle.
  ///
  /// In es, this message translates to:
  /// **'Batalla Pokémon'**
  String get battleTitle;

  /// No description provided for @regionsTitle.
  ///
  /// In es, this message translates to:
  /// **'Regiones'**
  String get regionsTitle;

  /// No description provided for @achievementsTitle.
  ///
  /// In es, this message translates to:
  /// **'Logros'**
  String get achievementsTitle;

  /// No description provided for @start.
  ///
  /// In es, this message translates to:
  /// **'Empezar'**
  String get start;

  /// No description provided for @playAgain.
  ///
  /// In es, this message translates to:
  /// **'Jugar otra vez'**
  String get playAgain;

  /// No description provided for @triviaQuestion.
  ///
  /// In es, this message translates to:
  /// **'Pregunta {n} de {total}'**
  String triviaQuestion(int n, int total);

  /// No description provided for @triviaCorrect.
  ///
  /// In es, this message translates to:
  /// **'¡Correcto! Es {name}.'**
  String triviaCorrect(String name);

  /// No description provided for @triviaWrong.
  ///
  /// In es, this message translates to:
  /// **'Era {name}.'**
  String triviaWrong(String name);

  /// No description provided for @triviaTimeout.
  ///
  /// In es, this message translates to:
  /// **'Se acabó el tiempo. Era {name}.'**
  String triviaTimeout(String name);

  /// No description provided for @triviaFinished.
  ///
  /// In es, this message translates to:
  /// **'Ronda terminada'**
  String get triviaFinished;

  /// No description provided for @triviaResult.
  ///
  /// In es, this message translates to:
  /// **'{correct} de {total} aciertos'**
  String triviaResult(int correct, int total);

  /// No description provided for @newAchievement.
  ///
  /// In es, this message translates to:
  /// **'Logro desbloqueado: {name}'**
  String newAchievement(String name);

  /// No description provided for @ach_firstCorrect.
  ///
  /// In es, this message translates to:
  /// **'Primer acierto'**
  String get ach_firstCorrect;

  /// No description provided for @ach_streak5.
  ///
  /// In es, this message translates to:
  /// **'Racha de 5'**
  String get ach_streak5;

  /// No description provided for @ach_perfectRound.
  ///
  /// In es, this message translates to:
  /// **'Ronda perfecta'**
  String get ach_perfectRound;

  /// No description provided for @ach_score1000.
  ///
  /// In es, this message translates to:
  /// **'1000 puntos'**
  String get ach_score1000;

  /// No description provided for @ach_firstBattleWin.
  ///
  /// In es, this message translates to:
  /// **'Primera victoria'**
  String get ach_firstBattleWin;

  /// No description provided for @ach_fiveBattleWins.
  ///
  /// In es, this message translates to:
  /// **'Cinco victorias'**
  String get ach_fiveBattleWins;

  /// No description provided for @ach_collector10.
  ///
  /// In es, this message translates to:
  /// **'Coleccionista (10 favoritos)'**
  String get ach_collector10;

  /// No description provided for @ach_typeMaster.
  ///
  /// In es, this message translates to:
  /// **'Maestro de tipos (súper eficaz x4)'**
  String get ach_typeMaster;

  /// No description provided for @battleChoose.
  ///
  /// In es, this message translates to:
  /// **'Elige tu Pokémon'**
  String get battleChoose;

  /// No description provided for @battleChooseHint.
  ///
  /// In es, this message translates to:
  /// **'Solo aparecen Pokémon con detalle descargado.'**
  String get battleChooseHint;

  /// No description provided for @battleNeedDetails.
  ///
  /// In es, this message translates to:
  /// **'Abre la ficha de al menos 2 Pokémon con conexión para poder combatir sin ella.'**
  String get battleNeedDetails;

  /// No description provided for @battleYourTurn.
  ///
  /// In es, this message translates to:
  /// **'¿Qué hará {name}?'**
  String battleYourTurn(String name);

  /// No description provided for @battleUsed.
  ///
  /// In es, this message translates to:
  /// **'{attacker} usó {move}.'**
  String battleUsed(String attacker, String move);

  /// No description provided for @battleMissed.
  ///
  /// In es, this message translates to:
  /// **'¡Falló!'**
  String get battleMissed;

  /// No description provided for @battleSuper.
  ///
  /// In es, this message translates to:
  /// **'¡Es súper eficaz!'**
  String get battleSuper;

  /// No description provided for @battleNotVery.
  ///
  /// In es, this message translates to:
  /// **'No es muy eficaz…'**
  String get battleNotVery;

  /// No description provided for @battleNoEffect.
  ///
  /// In es, this message translates to:
  /// **'No tiene efecto.'**
  String get battleNoEffect;

  /// No description provided for @battleCritical.
  ///
  /// In es, this message translates to:
  /// **'¡Golpe crítico!'**
  String get battleCritical;

  /// No description provided for @battleWon.
  ///
  /// In es, this message translates to:
  /// **'¡Ganaste!'**
  String get battleWon;

  /// No description provided for @battleLost.
  ///
  /// In es, this message translates to:
  /// **'Perdiste'**
  String get battleLost;

  /// No description provided for @battleStats.
  ///
  /// In es, this message translates to:
  /// **'{won} victorias en {played} batallas'**
  String battleStats(int won, int played);

  /// No description provided for @settingsTitle.
  ///
  /// In es, this message translates to:
  /// **'Ajustes'**
  String get settingsTitle;

  /// No description provided for @themeLabel.
  ///
  /// In es, this message translates to:
  /// **'Tema'**
  String get themeLabel;

  /// No description provided for @themeLight.
  ///
  /// In es, this message translates to:
  /// **'Claro'**
  String get themeLight;

  /// No description provided for @themeDark.
  ///
  /// In es, this message translates to:
  /// **'Oscuro'**
  String get themeDark;

  /// No description provided for @languageLabel.
  ///
  /// In es, this message translates to:
  /// **'Idioma'**
  String get languageLabel;

  /// No description provided for @languageSystem.
  ///
  /// In es, this message translates to:
  /// **'Sistema'**
  String get languageSystem;

  /// No description provided for @labTitle.
  ///
  /// In es, this message translates to:
  /// **'Laboratorio'**
  String get labTitle;

  /// No description provided for @labSubtitle.
  ///
  /// In es, this message translates to:
  /// **'Herramientas para la defensa técnica'**
  String get labSubtitle;

  /// No description provided for @labSimulateApi.
  ///
  /// In es, this message translates to:
  /// **'Simular caída de la API'**
  String get labSimulateApi;

  /// No description provided for @labSimulateApiHint.
  ///
  /// In es, this message translates to:
  /// **'Las consultas fallan como un 503 aunque haya red (prueba PA-08).'**
  String get labSimulateApiHint;

  /// No description provided for @labSyncNow.
  ///
  /// In es, this message translates to:
  /// **'Sincronizar ahora'**
  String get labSyncNow;

  /// No description provided for @labIntegrity.
  ///
  /// In es, this message translates to:
  /// **'Verificar integridad ahora'**
  String get labIntegrity;

  /// No description provided for @labIntegrityResult.
  ///
  /// In es, this message translates to:
  /// **'{count, plural, =0{Sin alteraciones} =1{1 registro alterado} other{{count} registros alterados}}'**
  String labIntegrityResult(int count);

  /// No description provided for @labSql.
  ///
  /// In es, this message translates to:
  /// **'Consola SQL'**
  String get labSql;

  /// No description provided for @labSqlHint.
  ///
  /// In es, this message translates to:
  /// **'UPDATE pokemon SET name_es = \'Pikachu modificado\' WHERE id = 25'**
  String get labSqlHint;

  /// No description provided for @labRun.
  ///
  /// In es, this message translates to:
  /// **'Ejecutar'**
  String get labRun;

  /// No description provided for @labSqlDone.
  ///
  /// In es, this message translates to:
  /// **'Ejecutado. Filas: {rows}'**
  String labSqlDone(int rows);

  /// No description provided for @labMeta.
  ///
  /// In es, this message translates to:
  /// **'Metadatos de sincronización'**
  String get labMeta;

  /// No description provided for @onbTitle2.
  ///
  /// In es, this message translates to:
  /// **'Mira el indicador'**
  String get onbTitle2;

  /// No description provided for @onbBody2.
  ///
  /// In es, this message translates to:
  /// **'Arriba a la derecha verás si estás en línea, sin conexión, con la API caída o sincronizando. Tócalo para más detalles.'**
  String get onbBody2;

  /// No description provided for @next.
  ///
  /// In es, this message translates to:
  /// **'Siguiente'**
  String get next;

  /// No description provided for @getStarted.
  ///
  /// In es, this message translates to:
  /// **'Empezar'**
  String get getStarted;

  /// No description provided for @battleDamage.
  ///
  /// In es, this message translates to:
  /// **'Quitó {damage} PS.'**
  String battleDamage(int damage);

  /// No description provided for @detailForms.
  ///
  /// In es, this message translates to:
  /// **'Formas'**
  String get detailForms;

  /// No description provided for @formDefault.
  ///
  /// In es, this message translates to:
  /// **'Normal'**
  String get formDefault;

  /// No description provided for @movesVersion.
  ///
  /// In es, this message translates to:
  /// **'Versión del juego'**
  String get movesVersion;

  /// No description provided for @methodLevelUp.
  ///
  /// In es, this message translates to:
  /// **'Nivel'**
  String get methodLevelUp;

  /// No description provided for @methodMachine.
  ///
  /// In es, this message translates to:
  /// **'MT'**
  String get methodMachine;

  /// No description provided for @methodTutor.
  ///
  /// In es, this message translates to:
  /// **'Tutor'**
  String get methodTutor;

  /// No description provided for @methodEgg.
  ///
  /// In es, this message translates to:
  /// **'Huevo'**
  String get methodEgg;

  /// No description provided for @sortByLevel.
  ///
  /// In es, this message translates to:
  /// **'Por nivel'**
  String get sortByLevel;

  /// No description provided for @sortByName.
  ///
  /// In es, this message translates to:
  /// **'Por nombre'**
  String get sortByName;

  /// No description provided for @movesEmpty.
  ///
  /// In es, this message translates to:
  /// **'No aprende movimientos por este método en esta versión.'**
  String get movesEmpty;

  /// No description provided for @moveLevel.
  ///
  /// In es, this message translates to:
  /// **'Nv {level}'**
  String moveLevel(int level);

  /// No description provided for @regionLabel.
  ///
  /// In es, this message translates to:
  /// **'Región'**
  String get regionLabel;

  /// No description provided for @regionOpen.
  ///
  /// In es, this message translates to:
  /// **'Ver los Pokémon de {region} en el catálogo'**
  String regionOpen(String region);

  /// No description provided for @moveOnEvolution.
  ///
  /// In es, this message translates to:
  /// **'Evo'**
  String get moveOnEvolution;

  /// No description provided for @baseNavProfile.
  ///
  /// In es, this message translates to:
  /// **'Perfil'**
  String get baseNavProfile;

  /// No description provided for @baseContinue.
  ///
  /// In es, this message translates to:
  /// **'Continuar'**
  String get baseContinue;

  /// No description provided for @navegacionTypePickTitle.
  ///
  /// In es, this message translates to:
  /// **'Selecciona el tipo'**
  String get navegacionTypePickTitle;

  /// No description provided for @navegacionAllTypes.
  ///
  /// In es, this message translates to:
  /// **'Todos los tipos'**
  String get navegacionAllTypes;

  /// No description provided for @navegacionTypesCount.
  ///
  /// In es, this message translates to:
  /// **'{count} tipos'**
  String navegacionTypesCount(int count);

  /// No description provided for @navegacionApplyFilter.
  ///
  /// In es, this message translates to:
  /// **'Aplicar filtro'**
  String get navegacionApplyFilter;

  /// No description provided for @navegacionSortTitle.
  ///
  /// In es, this message translates to:
  /// **'Ordenar por'**
  String get navegacionSortTitle;

  /// No description provided for @navegacionSortNumberAsc.
  ///
  /// In es, this message translates to:
  /// **'Menor número'**
  String get navegacionSortNumberAsc;

  /// No description provided for @navegacionSortNumberDesc.
  ///
  /// In es, this message translates to:
  /// **'Mayor número'**
  String get navegacionSortNumberDesc;

  /// No description provided for @navegacionSortNameAsc.
  ///
  /// In es, this message translates to:
  /// **'A-Z'**
  String get navegacionSortNameAsc;

  /// No description provided for @navegacionSortNameDesc.
  ///
  /// In es, this message translates to:
  /// **'Z-A'**
  String get navegacionSortNameDesc;

  /// No description provided for @navegacionStatsSection.
  ///
  /// In es, this message translates to:
  /// **'Estadísticas base'**
  String get navegacionStatsSection;

  /// No description provided for @navegacionPartialNote.
  ///
  /// In es, this message translates to:
  /// **'Catálogo parcial: hay {local} de {total} guardados. El resto aparece al terminar la sincronización.'**
  String navegacionPartialNote(int local, int total);

  /// No description provided for @navegacionSavedNote.
  ///
  /// In es, this message translates to:
  /// **'Tu orden y tus filtros se guardan para la próxima vez.'**
  String get navegacionSavedNote;

  /// No description provided for @navegacionSeeResults.
  ///
  /// In es, this message translates to:
  /// **'{count, plural, =0{Sin resultados} =1{Ver 1 Pokémon} other{Ver {count} Pokémon}}'**
  String navegacionSeeResults(int count);

  /// No description provided for @navegacionApiDownTitle.
  ///
  /// In es, this message translates to:
  /// **'PokéAPI no está respondiendo'**
  String get navegacionApiDownTitle;

  /// No description provided for @navegacionApiDownBody.
  ///
  /// In es, this message translates to:
  /// **'Ves lo que ya está guardado. Vuelvo a intentarlo solo; si quieres, hazlo ahora.'**
  String get navegacionApiDownBody;

  /// No description provided for @navegacionEmptyDbTitle.
  ///
  /// In es, this message translates to:
  /// **'Tu Pokédex todavía está vacía'**
  String get navegacionEmptyDbTitle;

  /// No description provided for @navegacionEmptyDbBody.
  ///
  /// In es, this message translates to:
  /// **'Necesito Internet una sola vez para descargarla. Después todo funciona sin conexión.'**
  String get navegacionEmptyDbBody;

  /// No description provided for @navegacionRetry.
  ///
  /// In es, this message translates to:
  /// **'Reintentar'**
  String get navegacionRetry;

  /// No description provided for @navegacionCheckConnection.
  ///
  /// In es, this message translates to:
  /// **'Revisar mi conexión'**
  String get navegacionCheckConnection;

  /// No description provided for @navegacionFavEmptyTitle.
  ///
  /// In es, this message translates to:
  /// **'Todavía no guardas ningún Pokémon'**
  String get navegacionFavEmptyTitle;

  /// No description provided for @navegacionFavEmptyBody.
  ///
  /// In es, this message translates to:
  /// **'Toca el corazón de cualquier Pokémon y aparecerá aquí, aunque no tengas Internet.'**
  String get navegacionFavEmptyBody;

  /// No description provided for @navegacionGoToPokedex.
  ///
  /// In es, this message translates to:
  /// **'Ir a la Pokédex'**
  String get navegacionGoToPokedex;

  /// No description provided for @navegacionRemove.
  ///
  /// In es, this message translates to:
  /// **'Quitar'**
  String get navegacionRemove;

  /// No description provided for @navegacionRemovedFavorite.
  ///
  /// In es, this message translates to:
  /// **'Quitaste a {name} de favoritos'**
  String navegacionRemovedFavorite(String name);

  /// No description provided for @navegacionUndo.
  ///
  /// In es, this message translates to:
  /// **'Deshacer'**
  String get navegacionUndo;

  /// No description provided for @navegacionOnb1Title.
  ///
  /// In es, this message translates to:
  /// **'Todos los Pokémon en un solo lugar'**
  String get navegacionOnb1Title;

  /// No description provided for @navegacionOnb1Body.
  ///
  /// In es, this message translates to:
  /// **'Los 1025 Pokémon de las nueve generaciones, guardados en tu teléfono para verlos cuando quieras.'**
  String get navegacionOnb1Body;

  /// No description provided for @navegacionOnb3Title.
  ///
  /// In es, this message translates to:
  /// **'¿Listo para la aventura?'**
  String get navegacionOnb3Title;

  /// No description provided for @navegacionOnb3Body.
  ///
  /// In es, this message translates to:
  /// **'Todo lo que veas queda guardado: catálogo, favoritos y trivia funcionan aunque no tengas conexión.'**
  String get navegacionOnb3Body;

  /// No description provided for @navegacionSkip.
  ///
  /// In es, this message translates to:
  /// **'Saltar'**
  String get navegacionSkip;

  /// No description provided for @navegacionOnbPage.
  ///
  /// In es, this message translates to:
  /// **'Página {page} de {total}'**
  String navegacionOnbPage(int page, int total);

  /// No description provided for @detailTabAbout.
  ///
  /// In es, this message translates to:
  /// **'Sobre'**
  String get detailTabAbout;

  /// No description provided for @detailTabStats.
  ///
  /// In es, this message translates to:
  /// **'Estadísticas'**
  String get detailTabStats;

  /// No description provided for @detailTabEvolutions.
  ///
  /// In es, this message translates to:
  /// **'Evoluciones'**
  String get detailTabEvolutions;

  /// No description provided for @detailTabMoves.
  ///
  /// In es, this message translates to:
  /// **'Movimientos'**
  String get detailTabMoves;

  /// No description provided for @detailCryReplay.
  ///
  /// In es, this message translates to:
  /// **'Escuchar el grito'**
  String get detailCryReplay;

  /// No description provided for @detailCryUnavailable.
  ///
  /// In es, this message translates to:
  /// **'Grito no disponible'**
  String get detailCryUnavailable;

  /// No description provided for @detailArtPixel.
  ///
  /// In es, this message translates to:
  /// **'Pixel'**
  String get detailArtPixel;

  /// No description provided for @detailArtIllustration.
  ///
  /// In es, this message translates to:
  /// **'Ilustración'**
  String get detailArtIllustration;

  /// No description provided for @detailArt3d.
  ///
  /// In es, this message translates to:
  /// **'3D'**
  String get detailArt3d;

  /// No description provided for @detailArtFallback.
  ///
  /// In es, this message translates to:
  /// **'No hay {requested} para este Pokémon: se muestra {shown}.'**
  String detailArtFallback(String requested, String shown);

  /// No description provided for @detailHiddenAbility.
  ///
  /// In es, this message translates to:
  /// **'(oculta)'**
  String get detailHiddenAbility;

  /// No description provided for @detailSizeTitle.
  ///
  /// In es, this message translates to:
  /// **'Tamaño'**
  String get detailSizeTitle;

  /// No description provided for @detailSizeYou.
  ///
  /// In es, this message translates to:
  /// **'Tú, {height} m'**
  String detailSizeYou(String height);

  /// No description provided for @detailSizePokemon.
  ///
  /// In es, this message translates to:
  /// **'{name}, {height} m y {weight} kg'**
  String detailSizePokemon(String name, String height, String weight);

  /// No description provided for @detailWhereLives.
  ///
  /// In es, this message translates to:
  /// **'Ver dónde vive: {region}'**
  String detailWhereLives(String region);

  /// No description provided for @detailWhereLivesHint.
  ///
  /// In es, this message translates to:
  /// **'Lleva a la Pokédex filtrada por {region}.'**
  String detailWhereLivesHint(String region);

  /// No description provided for @detailFormsHint.
  ///
  /// In es, this message translates to:
  /// **'Cada forma cambia el sprite, los tipos y los movimientos.'**
  String get detailFormsHint;

  /// No description provided for @detailFormsNone.
  ///
  /// In es, this message translates to:
  /// **'{name} no tiene otras formas.'**
  String detailFormsNone(String name);

  /// No description provided for @detailShareTitle.
  ///
  /// In es, this message translates to:
  /// **'Tu carta'**
  String get detailShareTitle;

  /// No description provided for @detailShareAsImage.
  ///
  /// In es, this message translates to:
  /// **'Compartir como imagen'**
  String get detailShareAsImage;

  /// No description provided for @detailShareSave.
  ///
  /// In es, this message translates to:
  /// **'Guardar imagen'**
  String get detailShareSave;

  /// No description provided for @detailShareFailed.
  ///
  /// In es, this message translates to:
  /// **'No se pudo preparar la imagen de la carta.'**
  String get detailShareFailed;

  /// No description provided for @detailCardHp.
  ///
  /// In es, this message translates to:
  /// **'PS'**
  String get detailCardHp;

  /// No description provided for @detailCardStageBasic.
  ///
  /// In es, this message translates to:
  /// **'BÁSICO'**
  String get detailCardStageBasic;

  /// No description provided for @detailCardStage1.
  ///
  /// In es, this message translates to:
  /// **'FASE 1'**
  String get detailCardStage1;

  /// No description provided for @detailCardStage2.
  ///
  /// In es, this message translates to:
  /// **'FASE 2'**
  String get detailCardStage2;

  /// No description provided for @detailCardWeakness.
  ///
  /// In es, this message translates to:
  /// **'debilidad'**
  String get detailCardWeakness;

  /// No description provided for @detailCardResistance.
  ///
  /// In es, this message translates to:
  /// **'resistencia'**
  String get detailCardResistance;

  /// No description provided for @detailCardRetreat.
  ///
  /// In es, this message translates to:
  /// **'retirada'**
  String get detailCardRetreat;

  /// No description provided for @detailCardArtCredit.
  ///
  /// In es, this message translates to:
  /// **'Ilus. arte oficial, vía PokéAPI'**
  String get detailCardArtCredit;

  /// No description provided for @detailCardNoAttacks.
  ///
  /// In es, this message translates to:
  /// **'Sin movimientos descargados'**
  String get detailCardNoAttacks;

  /// No description provided for @detailCardClassPhysical.
  ///
  /// In es, this message translates to:
  /// **'Físico'**
  String get detailCardClassPhysical;

  /// No description provided for @detailCardClassSpecial.
  ///
  /// In es, this message translates to:
  /// **'Especial'**
  String get detailCardClassSpecial;

  /// No description provided for @detailCardClassStatus.
  ///
  /// In es, this message translates to:
  /// **'Estado'**
  String get detailCardClassStatus;

  /// No description provided for @detailCardAccuracy.
  ///
  /// In es, this message translates to:
  /// **'precisión {percent} %'**
  String detailCardAccuracy(int percent);

  /// No description provided for @detailWeaknesses.
  ///
  /// In es, this message translates to:
  /// **'Debilidades'**
  String get detailWeaknesses;

  /// No description provided for @detailResistances.
  ///
  /// In es, this message translates to:
  /// **'Resistencias'**
  String get detailResistances;

  /// No description provided for @detailImmunities.
  ///
  /// In es, this message translates to:
  /// **'Inmunidades'**
  String get detailImmunities;

  /// No description provided for @detailEvolutions.
  ///
  /// In es, this message translates to:
  /// **'Evoluciones'**
  String get detailEvolutions;

  /// No description provided for @gamesHubProgressTitle.
  ///
  /// In es, this message translates to:
  /// **'Tu Pokédex'**
  String get gamesHubProgressTitle;

  /// No description provided for @gamesHubProgressValue.
  ///
  /// In es, this message translates to:
  /// **'{saved} de {total} guardados'**
  String gamesHubProgressValue(int saved, int total);

  /// No description provided for @gamesTriviaCardBody.
  ///
  /// In es, this message translates to:
  /// **'Adivina la silueta del Pokémon.'**
  String get gamesTriviaCardBody;

  /// No description provided for @gamesBattleCardTitle.
  ///
  /// In es, this message translates to:
  /// **'Batalla'**
  String get gamesBattleCardTitle;

  /// No description provided for @gamesBattleCardBody.
  ///
  /// In es, this message translates to:
  /// **'1 contra 1 contra la CPU.'**
  String get gamesBattleCardBody;

  /// No description provided for @gamesEnter.
  ///
  /// In es, this message translates to:
  /// **'Entrar'**
  String get gamesEnter;

  /// No description provided for @gamesBack.
  ///
  /// In es, this message translates to:
  /// **'Volver'**
  String get gamesBack;

  /// No description provided for @gamesTriviaPrompt.
  ///
  /// In es, this message translates to:
  /// **'¿Quién es ese Pokémon?'**
  String get gamesTriviaPrompt;

  /// No description provided for @gamesTriviaTime.
  ///
  /// In es, this message translates to:
  /// **'Tiempo restante: {seconds} s'**
  String gamesTriviaTime(int seconds);

  /// No description provided for @gamesTriviaPoints.
  ///
  /// In es, this message translates to:
  /// **'{score} pts'**
  String gamesTriviaPoints(int score);

  /// No description provided for @gamesTriviaOfflineNote.
  ///
  /// In es, this message translates to:
  /// **'La partida se guarda en el teléfono aunque no tengas Internet.'**
  String get gamesTriviaOfflineNote;

  /// No description provided for @gamesTriviaNewAchievements.
  ///
  /// In es, this message translates to:
  /// **'Logros nuevos'**
  String get gamesTriviaNewAchievements;

  /// No description provided for @gamesTriviaRankingTitle.
  ///
  /// In es, this message translates to:
  /// **'Ranking en este teléfono'**
  String get gamesTriviaRankingTitle;

  /// No description provided for @gamesTriviaFinalScore.
  ///
  /// In es, this message translates to:
  /// **'{score} puntos'**
  String gamesTriviaFinalScore(int score);

  /// No description provided for @gamesNoDataTitle.
  ///
  /// In es, this message translates to:
  /// **'Faltan Pokémon para jugar'**
  String get gamesNoDataTitle;

  /// No description provided for @gamesNoDataBody.
  ///
  /// In es, this message translates to:
  /// **'Necesito al menos {needed} guardados y tienes {have}. Conéctate un momento para descargar más; después la trivia funciona sin Internet.'**
  String gamesNoDataBody(int needed, int have);

  /// No description provided for @gamesNoDataEs.
  ///
  /// In es, this message translates to:
  /// **'Faltan Pokémon guardados para jugar la trivia: se necesitan al menos {needed} y hay {have}. Conéctate para descargar más.'**
  String gamesNoDataEs(int needed, int have);

  /// No description provided for @gamesNoDataEn.
  ///
  /// In es, this message translates to:
  /// **'Not enough saved Pokémon to play trivia: at least {needed} are needed and there are {have}. Connect to download more.'**
  String gamesNoDataEn(int needed, int have);

  /// No description provided for @gamesRetryDownload.
  ///
  /// In es, this message translates to:
  /// **'Reintentar la descarga'**
  String get gamesRetryDownload;

  /// No description provided for @gamesViewPokedex.
  ///
  /// In es, this message translates to:
  /// **'Ver mi Pokédex'**
  String get gamesViewPokedex;

  /// No description provided for @gamesBattleSummary.
  ///
  /// In es, this message translates to:
  /// **'CPU, 1 contra 1'**
  String get gamesBattleSummary;

  /// No description provided for @gamesBattleLevel.
  ///
  /// In es, this message translates to:
  /// **'Nv. {level}'**
  String gamesBattleLevel(int level);

  /// No description provided for @gamesBattleHp.
  ///
  /// In es, this message translates to:
  /// **'PS {hp} / {max}'**
  String gamesBattleHp(int hp, int max);

  /// No description provided for @gamesBattleHpSemantics.
  ///
  /// In es, this message translates to:
  /// **'{name}: {percent} % de PS'**
  String gamesBattleHpSemantics(String name, int percent);

  /// No description provided for @gamesBattlePower.
  ///
  /// In es, this message translates to:
  /// **'Poder {power}'**
  String gamesBattlePower(int power);

  /// No description provided for @gamesBattleMoveSemantics.
  ///
  /// In es, this message translates to:
  /// **'{name}, tipo {type}, poder {power}'**
  String gamesBattleMoveSemantics(String name, String type, int power);

  /// No description provided for @gamesTriviaCardTitle.
  ///
  /// In es, this message translates to:
  /// **'Trivia'**
  String get gamesTriviaCardTitle;

  /// No description provided for @perfilTrainerDefaultName.
  ///
  /// In es, this message translates to:
  /// **'Entrenador'**
  String get perfilTrainerDefaultName;

  /// No description provided for @perfilCardTitle.
  ///
  /// In es, this message translates to:
  /// **'FICHA DE ENTRENADOR'**
  String get perfilCardTitle;

  /// No description provided for @perfilCardName.
  ///
  /// In es, this message translates to:
  /// **'NOMBRE'**
  String get perfilCardName;

  /// No description provided for @perfilCardPokedex.
  ///
  /// In es, this message translates to:
  /// **'POKéDEX'**
  String get perfilCardPokedex;

  /// No description provided for @perfilCardTrivia.
  ///
  /// In es, this message translates to:
  /// **'TRIVIA'**
  String get perfilCardTrivia;

  /// No description provided for @perfilCardWins.
  ///
  /// In es, this message translates to:
  /// **'VICTORIAS'**
  String get perfilCardWins;

  /// No description provided for @perfilCardAchievements.
  ///
  /// In es, this message translates to:
  /// **'LOGROS'**
  String get perfilCardAchievements;

  /// No description provided for @perfilCardMedals.
  ///
  /// In es, this message translates to:
  /// **'MEDALLAS'**
  String get perfilCardMedals;

  /// No description provided for @perfilCardSemantics.
  ///
  /// In es, this message translates to:
  /// **'Ficha de entrenador de {name}: {saved} Pokémon guardados, {earned} de {total} medallas'**
  String perfilCardSemantics(String name, int saved, int earned, int total);

  /// No description provided for @perfilAchDone.
  ///
  /// In es, this message translates to:
  /// **'Conseguido'**
  String get perfilAchDone;

  /// No description provided for @perfilAchPending.
  ///
  /// In es, this message translates to:
  /// **'Pendiente'**
  String get perfilAchPending;

  /// No description provided for @perfilAchDesc_firstCorrect.
  ///
  /// In es, this message translates to:
  /// **'Adivina tu primera silueta en la trivia'**
  String get perfilAchDesc_firstCorrect;

  /// No description provided for @perfilAchDesc_streak5.
  ///
  /// In es, this message translates to:
  /// **'5 respuestas seguidas en la trivia'**
  String get perfilAchDesc_streak5;

  /// No description provided for @perfilAchDesc_perfectRound.
  ///
  /// In es, this message translates to:
  /// **'Una ronda de trivia sin ningún fallo'**
  String get perfilAchDesc_perfectRound;

  /// No description provided for @perfilAchDesc_score1000.
  ///
  /// In es, this message translates to:
  /// **'Suma 1000 puntos en una ronda de trivia'**
  String get perfilAchDesc_score1000;

  /// No description provided for @perfilAchDesc_firstBattleWin.
  ///
  /// In es, this message translates to:
  /// **'Gana tu primera batalla'**
  String get perfilAchDesc_firstBattleWin;

  /// No description provided for @perfilAchDesc_fiveBattleWins.
  ///
  /// In es, this message translates to:
  /// **'Gana cinco batallas'**
  String get perfilAchDesc_fiveBattleWins;

  /// No description provided for @perfilAchDesc_collector10.
  ///
  /// In es, this message translates to:
  /// **'Marca 10 Pokémon como favoritos'**
  String get perfilAchDesc_collector10;

  /// No description provided for @perfilAchDesc_typeMaster.
  ///
  /// In es, this message translates to:
  /// **'Usa un movimiento súper eficaz x4 en una batalla'**
  String get perfilAchDesc_typeMaster;

  /// No description provided for @perfilRegionGeneration.
  ///
  /// In es, this message translates to:
  /// **'{n}.ª generación'**
  String perfilRegionGeneration(int n);

  /// No description provided for @perfilRegionProgress.
  ///
  /// In es, this message translates to:
  /// **'{saved} de {size} guardados'**
  String perfilRegionProgress(int saved, int size);

  /// No description provided for @perfilRegionEmptyTitle.
  ///
  /// In es, this message translates to:
  /// **'Aún no hay Pokémon de esta región'**
  String get perfilRegionEmptyTitle;

  /// No description provided for @perfilRegionEmptyBody.
  ///
  /// In es, this message translates to:
  /// **'Conéctate una vez para descargarlos. Después se ven sin conexión.'**
  String get perfilRegionEmptyBody;

  /// No description provided for @perfilThemeAuto.
  ///
  /// In es, this message translates to:
  /// **'Automático'**
  String get perfilThemeAuto;

  /// No description provided for @perfilArtMode.
  ///
  /// In es, this message translates to:
  /// **'Arte de los Pokémon'**
  String get perfilArtMode;

  /// No description provided for @perfilArtByGeneration.
  ///
  /// In es, this message translates to:
  /// **'Por generación'**
  String get perfilArtByGeneration;

  /// No description provided for @perfilArtByGenerationHint.
  ///
  /// In es, this message translates to:
  /// **'Pixel en la 1 a la 5, 3D en la 6 a la 9'**
  String get perfilArtByGenerationHint;

  /// No description provided for @perfilArtPixel.
  ///
  /// In es, this message translates to:
  /// **'Pixel'**
  String get perfilArtPixel;

  /// No description provided for @perfilArtIllustration.
  ///
  /// In es, this message translates to:
  /// **'Ilustración'**
  String get perfilArtIllustration;

  /// No description provided for @perfilArt3d.
  ///
  /// In es, this message translates to:
  /// **'3D'**
  String get perfilArt3d;

  /// No description provided for @perfilSectionPokedex.
  ///
  /// In es, this message translates to:
  /// **'Pokédex'**
  String get perfilSectionPokedex;

  /// No description provided for @perfilSectionAppearance.
  ///
  /// In es, this message translates to:
  /// **'Apariencia'**
  String get perfilSectionAppearance;

  /// No description provided for @perfilSectionData.
  ///
  /// In es, this message translates to:
  /// **'Datos'**
  String get perfilSectionData;

  /// No description provided for @perfilReduceMotion.
  ///
  /// In es, this message translates to:
  /// **'Reducir movimiento'**
  String get perfilReduceMotion;

  /// No description provided for @perfilReduceMotionHint.
  ///
  /// In es, this message translates to:
  /// **'Sin la caída del sprite ni movimientos de adorno'**
  String get perfilReduceMotionHint;

  /// No description provided for @perfilCryOnOpen.
  ///
  /// In es, this message translates to:
  /// **'Grito al abrir el detalle'**
  String get perfilCryOnOpen;

  /// No description provided for @perfilCryOnOpenHint.
  ///
  /// In es, this message translates to:
  /// **'Suena una vez al abrir la ficha'**
  String get perfilCryOnOpenHint;

  /// No description provided for @perfilAppLanguage.
  ///
  /// In es, this message translates to:
  /// **'Idioma de la aplicación'**
  String get perfilAppLanguage;

  /// No description provided for @perfilSyncNow.
  ///
  /// In es, this message translates to:
  /// **'Sincronizar'**
  String get perfilSyncNow;

  /// No description provided for @perfilLabNoEvents.
  ///
  /// In es, this message translates to:
  /// **'Sin eventos todavía. Lo que hagas aquí se anota en esta consola.'**
  String get perfilLabNoEvents;

  /// No description provided for @perfilLabCount.
  ///
  /// In es, this message translates to:
  /// **'Contar filas'**
  String get perfilLabCount;

  /// No description provided for @perfilLabTamper.
  ///
  /// In es, this message translates to:
  /// **'Alterar dato'**
  String get perfilLabTamper;

  /// No description provided for @perfilLabApiDown.
  ///
  /// In es, this message translates to:
  /// **'caída simulada'**
  String get perfilLabApiDown;

  /// No description provided for @perfilLabApiUp.
  ///
  /// In es, this message translates to:
  /// **'servicio normal'**
  String get perfilLabApiUp;

  /// No description provided for @perfilLastSync.
  ///
  /// In es, this message translates to:
  /// **'Última sincronización'**
  String get perfilLastSync;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'es'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
