import 'package:flutter/material.dart';
import 'package:nam_ip_museum/components_details/component_image.dart';
import 'package:nam_ip_museum/components_details/datasheet.dart';
import 'package:nam_ip_museum/data/db_helper.dart';
import 'package:nam_ip_museum/utils/functions.dart';
import 'package:nam_ip_museum/utils/my_shared_preferences.dart';
import 'package:nam_ip_museum/utils/widgets.dart';

import '../models/component.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {

  late final List<Component> favorites;
  bool isLoaded = false;

  @override
  void initState() {
    loadData();
    super.initState();
  }

  Future<void> loadData() async {
    DBHelper dbHelper = DBHelper();
    favorites = await dbHelper.getComponentByIDList(MySharedPreferences.favorites);
    setState(() {isLoaded = true;});
  }

  Widget _buildCard(Component component) {
    return Card(
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/binaryBackground.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: ListTile(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => Datasheet.fromComponent(component: component,)));
          },
          leading: GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => ComponentImage(img: component.logo)));
            },
            child: Image.asset(component.logo)
          ),
          title: Text(component.name, style: const TextStyle(color: Colors.white)),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(Functions.getDescComponent(component: component), style: const TextStyle(color: Colors.white), overflow: TextOverflow.ellipsis, maxLines: 4,),
          ),
          contentPadding: const EdgeInsets.all(8),
          trailing: GestureDetector(
            onTap: () async {
              await MySharedPreferences.removeFavorite(component.id);
              setState(() {
                favorites.remove(component);
              });
            },
            child: const Icon(Icons.favorite)
          ),
        ),
      ),
    );
  }

  Widget _buildCard2(Component component) {
    return Card(
      child: Widgets.containerWithBinaryBackground(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => Datasheet.fromComponent(component: component,)));
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => ComponentImage(img: component.logo)));
                  },
                  child: Image.asset(component.logo, height: 100,)
                ),
                const SizedBox(height: 8,),
                Text(component.name, style: const TextStyle(color: Colors.white, fontSize: 17),),
                const SizedBox(height: 8,),
                Text(Functions.getDescComponent(component: component), style: const TextStyle(color: Colors.white, fontSize: 15), overflow: TextOverflow.ellipsis, maxLines: 4,),
                const SizedBox(height: 8,),
              ],
            ),
          ),
        )
      ),
    );
  }

  Widget _build1() {
    return favorites.isNotEmpty ? ListView.builder(
      itemCount: favorites.length,
      itemBuilder: (context, index) {
        return _buildCard(favorites[index]);
      },
    ) : const Center(child: Text('Aucun favoris', style: TextStyle(fontSize: 20, color: Colors.white),));
  }

  Widget _build2() {
    return favorites.isNotEmpty ? GridView.builder(
      itemCount: favorites.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisExtent: 250
      ),
      itemBuilder: (context, index) {
        return _buildCard2(favorites[index]);
      },
    ) : const Center(child: Text('Aucun favoris', style: TextStyle(fontSize: 20, color: Colors.white),));
  }

  int buildItem = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red.shade700,
      appBar: Widgets.appBar(context),
      body: isLoaded ? (buildItem == 1 ? _build1() : _build2()) : const Center(child: CircularProgressIndicator()),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            buildItem = buildItem == 1 ? 2 : 1;
          });
        },
        child: const Icon(Icons.repeat),
      ),
    );
  }
}
