import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/place.dart';
import '../provider/great_places.dart';
import '../widgets/image_input.dart';
import '../widgets/location_input.dart';

class AddPlaceScreen extends StatefulWidget {
  const AddPlaceScreen({Key? key}) : super(key: key);
  static const routeName = '/add-place';

  @override
  _AddPlaceScreenState createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  final _titleController = TextEditingController();
  File? _pickedImage;
  PlaceLocation? _pickedLoacation;

  void _onSelectImage(File pickedImage) {
    _pickedImage = pickedImage;
  }

  void _onSelectPlace(double lat, double long) {
    _pickedLoacation =
        PlaceLocation(latitude: lat, longitude: long, address: '');
  }

  void _savePlace() {
    if (_titleController.text.isEmpty ||
        _pickedImage == null ||
        _pickedLoacation == null) {
      return;
    }
    context
        .read<GreatPlaces>()
        .addPlace(_titleController.text, _pickedImage!, _pickedLoacation!);
    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add new place'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    TextField(
                      decoration: const InputDecoration(label: Text('title')),
                      controller: _titleController,
                    ),
                    const SizedBox(height: 10),
                    ImageInput(_onSelectImage),
                    const SizedBox(height: 10),
                    LocationInput(_onSelectPlace),
                  ],
                ),
              ),
            ),
          ),
          ElevatedButton.icon(
            onPressed: _savePlace,
            icon: const Icon(Icons.add, color: Colors.black),
            label: const Text(
              'Add place',
              style: TextStyle(color: Colors.black),
            ),
            style: ElevatedButton.styleFrom(
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              primary: Theme.of(context).colorScheme.secondary,
            ),
          ),
        ],
      ),
    );
  }
}
