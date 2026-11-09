import 'package:flutter_riverpod/flutter_riverpod.dart';

final homeTabProvider = NotifierProvider<HomeTab, int>(HomeTab.new);

class HomeTab extends Notifier<int> {
  @override
  int build() => 0;

  void show(int index) => state = index;
}
