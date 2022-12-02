import 'package:flutter/material.dart';
import 'pokedetail.dart';
import 'pokemon.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var url =
      "https://raw.githubusercontent.com/Azazel17/pokehub/master/pokehub.json";

  POKEMON Pokehub = POKEMON(pokemon: []);

  @override
  void initState() {
    super.initState();
    _fetchData();
    print("Descargando");
  }

  _fetchData() async {
    var result = await http.get(Uri.parse(url));
    print(result.body);
    var decodedJson = json.decode(result.body);
    Pokehub = POKEMON.fromJson(decodedJson);
    print(Pokehub.toJson());
    setState(() {});
  }

  /*Control de Busqueda*/
  String _searchText = "";
  final TextEditingController _search = TextEditingController();
  final Widget _appBarTitle = Text("Buscar Pokemon");
  bool _istyping = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: _istyping
              ? TextField(
                  autofocus: true,
                  controller: _search,
                  onChanged: (value) {
                    setState(() {
                      _searchText = value;
                      print("Buscando ${_search.text}");
                    });
                  },
                )
              : _appBarTitle,
          leading: IconButton(
            icon: Icon(_istyping ? Icons.done : Icons.search),
            onPressed: () {
              print("Buscando" + _search.text);
              setState(() {
                _istyping = !_istyping;
                //_search.text = "";
              });
            },
          ),
          centerTitle: true,
        ),
        body: Pokehub == null
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : OrientationBuilder(builder: (context, orientation) {
                return GridView.count(
                  crossAxisCount: orientation == Orientation.portrait ? 2 : 4,
                  children: Pokehub.pokemon
                      .where((poke) => poke.type!
                          .toList()
                          .toList()
                          .toString()
                          .toLowerCase()
                          .contains(_search.text.toLowerCase()))
                      .map((poke) => Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => pokedetails(
                                              pokemon: poke,
                                            )));
                              },
                              child: Hero(
                                tag: poke.img.toString(),
                                child: Card(
                                  elevation: 3.0,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Container(
                                        height: 95,
                                        width: 95,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: NetworkImage(
                                                  poke.img.toString())),
                                        ),
                                      ),
                                      Text(
                                        poke.name.toString(),
                                        style: const TextStyle(
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ))
                      .toList(),
                );
              }));
  }
}
