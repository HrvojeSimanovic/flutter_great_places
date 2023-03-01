import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/great_places.dart';
import '../screens/place_detail_screen.dart';

class PlacesListScreen extends StatelessWidget {
  const PlacesListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your places'),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/add-place');
            },
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: FutureBuilder(
        future: context.read<GreatPlaces>().fetchAndSetPlaces(),
        builder: (context, snapShot) =>
            snapShot.connectionState == ConnectionState.waiting
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Consumer<GreatPlaces>(
                    child: const Center(child: Text('No places')),
                    builder: (context, greatPlaces, childWidget) =>
                        greatPlaces.items.isEmpty
                            ? childWidget!
                            : ListView.builder(
                                itemCount: greatPlaces.items.length,
                                itemBuilder: (context, i) => ListTile(
                                  leading: CircleAvatar(
                                    backgroundImage:
                                        FileImage(greatPlaces.items[i].image),
                                  ),
                                  title: Text(greatPlaces.items[i].title),
                                  subtitle: Text(
                                    greatPlaces.items[i].location.address,
                                  ),
                                  onTap: () {
                                    Navigator.of(context).pushNamed(
                                      PlaceDetailScreen.routeName,
                                      arguments: greatPlaces.items[i].id,
                                    );
                                  },
                                ),
                              ),
                  ),
      ),
    );
  }
}
