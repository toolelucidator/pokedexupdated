import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'pokemon.dart';

class pokedetails extends StatelessWidget {
  final Pokemon pokemon;

  pokedetails({required this.pokemon});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(pokemon.name.toString()),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Positioned(
            height: MediaQuery.of(context).size.height / 1.5,
            width: MediaQuery.of(context).size.width - 20,
            left: 10.0,
            top: MediaQuery.of(context).size.height * 0.1,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const SizedBox(
                    height: 70,
                  ),
                  Text(
                    pokemon.name.toString(),
                    style: const TextStyle(fontSize: 25),
                  ),
                  Text("Weight: ${pokemon.weight}"),
                  Text("Height: ${pokemon.height}"),
                  const Text(
                    "Types: ",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: pokemon.type!
                        .map((ty) => FilterChip(
                            backgroundColor: Colors.amberAccent,
                            label: Text(ty),
                            onSelected: (b) {}))
                        .toList(),
                  ),
                  const Text(
                    "Weakness:",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: pokemon.weaknesses!
                        .map((ty) => FilterChip(
                            backgroundColor: Colors.redAccent,
                            label: Text(ty),
                            onSelected: (b) {}))
                        .toList(),
                  ),
                  const Text(
                    "Next evolution:",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: pokemon.nextEvolution!
                        .map((ty) => FilterChip(
                            backgroundColor: Colors.redAccent,
                            label: Text(ty.name),
                            onSelected: (b) {}))
                        .toList(),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Hero(
              tag: pokemon.img.toString(),
              child: Container(
                height: 200,
                width: 200,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(pokemon.img.toString()))),
              ),
            ),
          )
        ],
      ),
    );
  }
}
