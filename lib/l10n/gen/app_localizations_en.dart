// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Pokédex';

  @override
  String get navPokedex => 'Pokédex';

  @override
  String get navFavorites => 'Favorites';

  @override
  String get navPlay => 'Play';

  @override
  String get navSettings => 'Settings';

  @override
  String get statusOnline => 'Online';

  @override
  String get statusOffline => 'Offline';

  @override
  String get statusUnavailable => 'API down';

  @override
  String get statusSyncing => 'Syncing';

  @override
  String get statusOnlineLong =>
      'Connected. Data is refreshed from PokéAPI and saved on this device.';

  @override
  String get statusOfflineLong =>
      'No connection. You are seeing data saved on this device.';

  @override
  String get statusUnavailableLong =>
      'The network is up, but PokéAPI is not responding. You are seeing data saved on this device.';

  @override
  String get statusSyncingLong =>
      'Downloading changes in the background. You can keep using the app.';

  @override
  String get originLive => 'Source: PokéAPI, saved on this device';

  @override
  String get originLocal => 'Source: device data only';

  @override
  String lastSync(String when) {
    return 'Last sync: $when';
  }

  @override
  String get neverSynced => 'Not synced yet';

  @override
  String localCatalog(int local, String total) {
    return '$local of $total Pokémon on this device';
  }

  @override
  String pendingRepairs(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count altered records await correction',
      one: '1 altered record awaits correction',
    );
    return '$_temp0';
  }

  @override
  String get retryNow => 'Retry now';

  @override
  String get close => 'Close';

  @override
  String indicatorSemantics(String status) {
    return 'Connection status: $status. Tap for details.';
  }

  @override
  String get justNow => 'just now';

  @override
  String minutesAgo(int n) {
    return '$n min ago';
  }

  @override
  String hoursAgo(int n) {
    return '$n h ago';
  }

  @override
  String daysAgo(int n) {
    return '$n d ago';
  }

  @override
  String get searchHint => 'Search by name or number';

  @override
  String get clearFilters => 'Clear';

  @override
  String get generationLabel => 'Generation';

  @override
  String get abilityLabel => 'Ability';

  @override
  String get anyOption => 'Any';

  @override
  String get favoritesOnly => 'Favorites only';

  @override
  String get sortAttack => 'Attack';

  @override
  String get sortDefense => 'Defense';

  @override
  String get sortSpeed => 'Speed';

  @override
  String get ascending => 'Ascending';

  @override
  String get descending => 'Descending';

  @override
  String get apply => 'Apply';

  @override
  String resultsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Pokémon',
      one: '1 Pokémon',
      zero: 'No results',
    );
    return '$_temp0';
  }

  @override
  String partialCatalog(int local, int total) {
    return 'Partial catalog: $local of $total. Offline, search only covers what was downloaded.';
  }

  @override
  String get emptyFirstLoadTitle => 'Preparing your Pokédex';

  @override
  String get emptyFirstLoadBody =>
      'Downloading the catalog. The first Pokémon appear in seconds.';

  @override
  String get emptyResultsTitle => 'No Pokémon match';

  @override
  String get emptyResultsBody => 'Try another name or remove a filter.';

  @override
  String get errorTitle => 'Something went wrong';

  @override
  String get errorBody => 'Your saved data is safe. Please try again.';

  @override
  String get imageUnavailable => 'Image unavailable offline';

  @override
  String get detailStats => 'Base stats';

  @override
  String get detailAbilities => 'Abilities';

  @override
  String get detailMoves => 'Moves';

  @override
  String get height => 'Height';

  @override
  String get weight => 'Weight';

  @override
  String get eggGroups => 'Egg group';

  @override
  String get captureRate => 'Catch rate';

  @override
  String get total => 'Total';

  @override
  String get weaknesses => 'Weak to';

  @override
  String get resistances => 'Resists';

  @override
  String get immunities => 'Immune to';

  @override
  String get noEvolution => 'Does not evolve';

  @override
  String get legendary => 'Legendary';

  @override
  String get mythical => 'Mythical';

  @override
  String get detailNotDownloaded =>
      'This Pokémon\'s detail has not been downloaded yet. Connect to see it in full.';

  @override
  String get tamperedBanner =>
      'This Pokémon\'s local data does not match what was synced. It will be corrected from PokéAPI.';

  @override
  String get addFavorite => 'Add to favorites';

  @override
  String get removeFavorite => 'Remove from favorites';

  @override
  String get shiny => 'Shiny';

  @override
  String get share => 'Share card';

  @override
  String get favoriteAdded => 'Added to favorites';

  @override
  String get favoriteRemoved => 'Removed from favorites';

  @override
  String get stat_hp => 'HP';

  @override
  String get stat_attack => 'Attack';

  @override
  String get stat_defense => 'Defense';

  @override
  String get stat_specialAttack => 'Sp. Atk';

  @override
  String get stat_specialDefense => 'Sp. Def';

  @override
  String get stat_speed => 'Speed';

  @override
  String evoLevel(int level) {
    return 'Level $level';
  }

  @override
  String evoItem(String item) {
    return 'With $item';
  }

  @override
  String get evoTrade => 'Trade';

  @override
  String get evoFriendship => 'Friendship';

  @override
  String evoTime(String time) {
    return 'During the $time';
  }

  @override
  String get evoOther => 'Special condition';

  @override
  String get timeDay => 'day';

  @override
  String get timeNight => 'night';

  @override
  String get favoritesTitle => 'Favorites';

  @override
  String get playTitle => 'Play';

  @override
  String get battleTitle => 'Pokémon battle';

  @override
  String get regionsTitle => 'Regions';

  @override
  String get achievementsTitle => 'Achievements';

  @override
  String get start => 'Start';

  @override
  String get playAgain => 'Play again';

  @override
  String triviaQuestion(int n, int total) {
    return 'Question $n of $total';
  }

  @override
  String triviaCorrect(String name) {
    return 'Correct! It\'s $name.';
  }

  @override
  String triviaWrong(String name) {
    return 'It was $name.';
  }

  @override
  String triviaTimeout(String name) {
    return 'Time\'s up. It was $name.';
  }

  @override
  String get triviaFinished => 'Round complete';

  @override
  String triviaResult(int correct, int total) {
    return '$correct of $total correct';
  }

  @override
  String newAchievement(String name) {
    return 'Achievement unlocked: $name';
  }

  @override
  String get ach_firstCorrect => 'First correct answer';

  @override
  String get ach_streak5 => 'Streak of 5';

  @override
  String get ach_perfectRound => 'Perfect round';

  @override
  String get ach_score1000 => '1000 points';

  @override
  String get ach_firstBattleWin => 'First win';

  @override
  String get ach_fiveBattleWins => 'Five wins';

  @override
  String get ach_collector10 => 'Collector (10 favorites)';

  @override
  String get ach_typeMaster => 'Type master (4x super effective)';

  @override
  String get battleChoose => 'Choose your Pokémon';

  @override
  String get battleChooseHint => 'Only Pokémon with downloaded detail appear.';

  @override
  String get battleNeedDetails =>
      'Open at least 2 Pokémon pages while online to battle offline.';

  @override
  String battleYourTurn(String name) {
    return 'What will $name do?';
  }

  @override
  String battleUsed(String attacker, String move) {
    return '$attacker used $move.';
  }

  @override
  String get battleMissed => 'It missed!';

  @override
  String get battleSuper => 'It\'s super effective!';

  @override
  String get battleNotVery => 'It\'s not very effective…';

  @override
  String get battleNoEffect => 'It had no effect.';

  @override
  String get battleCritical => 'A critical hit!';

  @override
  String get battleWon => 'You won!';

  @override
  String get battleLost => 'You lost';

  @override
  String battleStats(int won, int played) {
    return '$won wins in $played battles';
  }

  @override
  String get settingsTitle => 'Settings';

  @override
  String get themeLabel => 'Theme';

  @override
  String get themeLight => 'Light';

  @override
  String get themeDark => 'Dark';

  @override
  String get languageLabel => 'Language';

  @override
  String get languageSystem => 'System';

  @override
  String get labTitle => 'Lab';

  @override
  String get labSubtitle => 'Tools for the technical defense';

  @override
  String get labSimulateApi => 'Simulate API outage';

  @override
  String get labSimulateApiHint =>
      'Requests fail like a 503 even with network (test PA-08).';

  @override
  String get labSyncNow => 'Sync now';

  @override
  String get labIntegrity => 'Check integrity now';

  @override
  String labIntegrityResult(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count altered records',
      one: '1 altered record',
      zero: 'No alterations',
    );
    return '$_temp0';
  }

  @override
  String get labSql => 'SQL console';

  @override
  String get labSqlHint =>
      'UPDATE pokemon SET name_en = \'Edited Pikachu\' WHERE id = 25';

  @override
  String get labRun => 'Run';

  @override
  String labSqlDone(int rows) {
    return 'Done. Rows: $rows';
  }

  @override
  String get labMeta => 'Sync metadata';

  @override
  String get onbTitle2 => 'Watch the indicator';

  @override
  String get onbBody2 =>
      'Top right shows whether you are online, offline, facing an API outage or syncing. Tap it for details.';

  @override
  String get next => 'Next';

  @override
  String get getStarted => 'Get started';

  @override
  String battleDamage(int damage) {
    return 'It dealt $damage HP.';
  }

  @override
  String get detailForms => 'Forms';

  @override
  String get formDefault => 'Default';

  @override
  String get movesVersion => 'Game version';

  @override
  String get methodLevelUp => 'Level up';

  @override
  String get methodMachine => 'TM';

  @override
  String get methodTutor => 'Tutor';

  @override
  String get methodEgg => 'Egg';

  @override
  String get sortByLevel => 'By level';

  @override
  String get sortByName => 'By name';

  @override
  String get movesEmpty => 'No moves by this method in this version.';

  @override
  String moveLevel(int level) {
    return 'Lv $level';
  }

  @override
  String get regionLabel => 'Region';

  @override
  String regionOpen(String region) {
    return 'See Pokémon from $region in the catalog';
  }

  @override
  String get moveOnEvolution => 'Evo';

  @override
  String get baseNavProfile => 'Profile';

  @override
  String get baseContinue => 'Continue';

  @override
  String get navegacionTypePickTitle => 'Pick a type';

  @override
  String get navegacionAllTypes => 'All types';

  @override
  String navegacionTypesCount(int count) {
    return '$count types';
  }

  @override
  String get navegacionApplyFilter => 'Apply filter';

  @override
  String get navegacionSortTitle => 'Sort by';

  @override
  String get navegacionSortNumberAsc => 'Lowest number';

  @override
  String get navegacionSortNumberDesc => 'Highest number';

  @override
  String get navegacionSortNameAsc => 'A-Z';

  @override
  String get navegacionSortNameDesc => 'Z-A';

  @override
  String get navegacionStatsSection => 'Base stats';

  @override
  String navegacionPartialNote(int local, int total) {
    return 'Partial catalog: $local of $total saved. The rest appears when the sync finishes.';
  }

  @override
  String get navegacionSavedNote =>
      'Your order and filters are saved for next time.';

  @override
  String navegacionSeeResults(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'See $count Pokémon',
      one: 'See 1 Pokémon',
      zero: 'No results',
    );
    return '$_temp0';
  }

  @override
  String get navegacionApiDownTitle => 'PokéAPI is not responding';

  @override
  String get navegacionApiDownBody =>
      'You see what is already saved. I will retry on my own; or do it now if you like.';

  @override
  String get navegacionEmptyDbTitle => 'Your Pokédex is still empty';

  @override
  String get navegacionEmptyDbBody =>
      'I need the Internet just once to download it. After that everything works offline.';

  @override
  String get navegacionRetry => 'Retry';

  @override
  String get navegacionCheckConnection => 'Check my connection';

  @override
  String get navegacionFavEmptyTitle => 'You have not saved any Pokémon yet';

  @override
  String get navegacionFavEmptyBody =>
      'Tap the heart on any Pokémon and it will show up here, even without Internet.';

  @override
  String get navegacionGoToPokedex => 'Go to the Pokédex';

  @override
  String get navegacionRemove => 'Remove';

  @override
  String navegacionRemovedFavorite(String name) {
    return 'You removed $name from favorites';
  }

  @override
  String get navegacionUndo => 'Undo';

  @override
  String get navegacionOnb1Title => 'Every Pokémon in one place';

  @override
  String get navegacionOnb1Body =>
      'All 1025 Pokémon from the nine generations, saved on your phone so you can see them whenever you want.';

  @override
  String get navegacionOnb3Title => 'Ready for the adventure?';

  @override
  String get navegacionOnb3Body =>
      'Everything you see is saved: catalog, favorites and trivia work even without a connection.';

  @override
  String get navegacionSkip => 'Skip';

  @override
  String navegacionOnbPage(int page, int total) {
    return 'Page $page of $total';
  }

  @override
  String get detailTabAbout => 'About';

  @override
  String get detailTabStats => 'Stats';

  @override
  String get detailTabEvolutions => 'Evolutions';

  @override
  String get detailTabMoves => 'Moves';

  @override
  String get detailCryReplay => 'Play the cry';

  @override
  String get detailCryUnavailable => 'Cry not available';

  @override
  String get detailArtPixel => 'Pixel';

  @override
  String get detailArtIllustration => 'Illustration';

  @override
  String get detailArt3d => '3D';

  @override
  String detailArtFallback(String requested, String shown) {
    return 'No $requested art for this Pokémon: showing $shown.';
  }

  @override
  String get detailHiddenAbility => '(hidden)';

  @override
  String get detailSizeTitle => 'Size';

  @override
  String detailSizeYou(String height) {
    return 'You, $height m';
  }

  @override
  String detailSizePokemon(String name, String height, String weight) {
    return '$name, $height m and $weight kg';
  }

  @override
  String detailWhereLives(String region) {
    return 'See where it lives: $region';
  }

  @override
  String detailWhereLivesHint(String region) {
    return 'Opens the Pokédex filtered by $region.';
  }

  @override
  String get detailFormsHint =>
      'Each form changes the sprite, the types and the moves.';

  @override
  String detailFormsNone(String name) {
    return '$name has no other forms.';
  }

  @override
  String get detailShareTitle => 'Your card';

  @override
  String get detailShareAsImage => 'Share as image';

  @override
  String get detailShareSave => 'Save image';

  @override
  String get detailShareFailed => 'Could not prepare the card image.';

  @override
  String get detailCardHp => 'HP';

  @override
  String get detailCardStageBasic => 'BASIC';

  @override
  String get detailCardStage1 => 'STAGE 1';

  @override
  String get detailCardStage2 => 'STAGE 2';

  @override
  String get detailCardWeakness => 'weakness';

  @override
  String get detailCardResistance => 'resistance';

  @override
  String get detailCardRetreat => 'retreat';

  @override
  String get detailCardArtCredit => 'Art: official artwork, via PokéAPI';

  @override
  String get detailCardNoAttacks => 'No moves downloaded yet';

  @override
  String get detailCardClassPhysical => 'Physical';

  @override
  String get detailCardClassSpecial => 'Special';

  @override
  String get detailCardClassStatus => 'Status';

  @override
  String detailCardAccuracy(int percent) {
    return 'accuracy $percent%';
  }

  @override
  String get detailWeaknesses => 'Weaknesses';

  @override
  String get detailResistances => 'Resistances';

  @override
  String get detailImmunities => 'Immunities';

  @override
  String get detailEvolutions => 'Evolutions';

  @override
  String get gamesHubProgressTitle => 'Your Pokédex';

  @override
  String gamesHubProgressValue(int saved, int total) {
    return '$saved of $total saved';
  }

  @override
  String get gamesTriviaCardBody => 'Guess the Pokémon from its silhouette.';

  @override
  String get gamesBattleCardTitle => 'Battle';

  @override
  String get gamesBattleCardBody => '1 vs 1 against the CPU.';

  @override
  String get gamesEnter => 'Enter';

  @override
  String get gamesBack => 'Back';

  @override
  String get gamesTriviaPrompt => 'Who\'s that Pokémon?';

  @override
  String gamesTriviaTime(int seconds) {
    return 'Time left: $seconds s';
  }

  @override
  String gamesTriviaPoints(int score) {
    return '$score pts';
  }

  @override
  String get gamesTriviaOfflineNote =>
      'Your game is saved on the phone even without Internet.';

  @override
  String get gamesTriviaNewAchievements => 'New achievements';

  @override
  String get gamesTriviaRankingTitle => 'Ranking on this phone';

  @override
  String gamesTriviaFinalScore(int score) {
    return '$score points';
  }

  @override
  String get gamesNoDataTitle => 'Not enough Pokémon to play';

  @override
  String gamesNoDataBody(int needed, int have) {
    return 'I need at least $needed saved and you have $have. Connect for a moment to download more; after that, trivia works without Internet.';
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
  String get gamesRetryDownload => 'Retry the download';

  @override
  String get gamesViewPokedex => 'See my Pokédex';

  @override
  String get gamesBattleSummary => 'CPU, 1 vs 1';

  @override
  String gamesBattleLevel(int level) {
    return 'Lv. $level';
  }

  @override
  String gamesBattleHp(int hp, int max) {
    return 'HP $hp / $max';
  }

  @override
  String gamesBattleHpSemantics(String name, int percent) {
    return '$name: $percent % HP';
  }

  @override
  String gamesBattlePower(int power) {
    return 'Power $power';
  }

  @override
  String gamesBattleMoveSemantics(String name, String type, int power) {
    return '$name, $type type, power $power';
  }

  @override
  String get gamesTriviaCardTitle => 'Trivia';

  @override
  String get perfilTrainerDefaultName => 'Trainer';

  @override
  String get perfilCardTitle => 'TRAINER CARD';

  @override
  String get perfilCardName => 'NAME';

  @override
  String get perfilCardPokedex => 'POKéDEX';

  @override
  String get perfilCardTrivia => 'TRIVIA';

  @override
  String get perfilCardWins => 'WINS';

  @override
  String get perfilCardAchievements => 'AWARDS';

  @override
  String get perfilCardMedals => 'MEDALS';

  @override
  String perfilCardSemantics(String name, int saved, int earned, int total) {
    return '$name\'s trainer card: $saved Pokémon saved, $earned of $total medals';
  }

  @override
  String get perfilAchDone => 'Earned';

  @override
  String get perfilAchPending => 'Pending';

  @override
  String get perfilAchDesc_firstCorrect =>
      'Guess your first silhouette in the trivia';

  @override
  String get perfilAchDesc_streak5 =>
      '5 correct answers in a row in the trivia';

  @override
  String get perfilAchDesc_perfectRound => 'A trivia round with no mistakes';

  @override
  String get perfilAchDesc_score1000 => 'Score 1000 points in one trivia round';

  @override
  String get perfilAchDesc_firstBattleWin => 'Win your first battle';

  @override
  String get perfilAchDesc_fiveBattleWins => 'Win five battles';

  @override
  String get perfilAchDesc_collector10 => 'Mark 10 Pokémon as favorites';

  @override
  String get perfilAchDesc_typeMaster =>
      'Land a x4 super effective move in a battle';

  @override
  String perfilRegionGeneration(int n) {
    return 'Generation $n';
  }

  @override
  String perfilRegionProgress(int saved, int size) {
    return '$saved of $size saved';
  }

  @override
  String get perfilRegionEmptyTitle => 'No Pokémon from this region yet';

  @override
  String get perfilRegionEmptyBody =>
      'Connect once to download them. After that they work offline.';

  @override
  String get perfilThemeAuto => 'Automatic';

  @override
  String get perfilArtMode => 'Pokémon art';

  @override
  String get perfilArtByGeneration => 'By generation';

  @override
  String get perfilArtByGenerationHint => 'Pixel for 1 to 5, 3D for 6 to 9';

  @override
  String get perfilArtPixel => 'Pixel';

  @override
  String get perfilArtIllustration => 'Illustration';

  @override
  String get perfilArt3d => '3D';

  @override
  String get perfilSectionPokedex => 'Pokédex';

  @override
  String get perfilSectionAppearance => 'Appearance';

  @override
  String get perfilSectionData => 'Data';

  @override
  String get perfilReduceMotion => 'Reduce motion';

  @override
  String get perfilReduceMotionHint =>
      'No sprite drop and no decorative movement';

  @override
  String get perfilCryOnOpen => 'Cry when opening the detail';

  @override
  String get perfilCryOnOpenHint => 'Plays once when the detail opens';

  @override
  String get perfilAppLanguage => 'App language';

  @override
  String get perfilSyncNow => 'Sync';

  @override
  String get perfilLabNoEvents =>
      'No events yet. What you do here is logged in this console.';

  @override
  String get perfilLabCount => 'Count rows';

  @override
  String get perfilLabTamper => 'Tamper data';

  @override
  String get perfilLabApiDown => 'simulated outage';

  @override
  String get perfilLabApiUp => 'normal service';

  @override
  String get perfilLastSync => 'Last sync';
}
