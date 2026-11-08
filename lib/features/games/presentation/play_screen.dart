import 'package:flutter/material.dart';

class PlayScreen extends StatelessWidget {
  const PlayScreen({super.key, this.onOpenCatalog});

  final VoidCallback? onOpenCatalog;

  @override
  Widget build(BuildContext context) => const Center(child: Text('Jugar'));
}
