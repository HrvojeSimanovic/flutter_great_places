import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/great_places.dart';
import '../screens/places_list_screen.dart';
import '../screens/add_place_screen.dart';
import '../screens/place_detail_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = ThemeData();
    return ChangeNotifierProvider(
      create: (context) => GreatPlaces(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Great Places',
        theme: ThemeData(
          primarySwatch: Colors.indigo,
          colorScheme: theme.colorScheme.copyWith(secondary: Colors.amber),
        ),
        home: const PlacesListScreen(),
        routes: {
          AddPlaceScreen.routeName: (context) => const AddPlaceScreen(),
          PlaceDetailScreen.routeName: (context) => const PlaceDetailScreen(),
        },
      ),
    );
  }
}
