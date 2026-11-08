import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key, required this.pokemonId});
  final int pokemonId;

  static Future open(BuildContext context, int id) =>
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (_) => DetailScreen(pokemonId: id)));

  @override
  Widget build(BuildContext context) =>
      Scaffold(body: Center(child: Text('#$pokemonId: la ficha llega en 4.5')));
}
