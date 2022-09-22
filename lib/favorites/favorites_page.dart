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
      child: Widgets.containerWithBinaryBackground(
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
    return ListView.builder(
      itemCount: favorites.length,
      itemBuilder: (context, index) {
        return _buildCard(favorites[index]);
      },
    );
  }

  Widget _build2() {
    return GridView.builder(
      itemCount: favorites.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisExtent: 250
      ),
      itemBuilder: (context, index) {
        return _buildCard2(favorites[index]);
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red.shade700,
      appBar: Widgets.appBar(context),
      body: isLoaded ? _build2() : const Center(child: CircularProgressIndicator()),
    );
  }
}
