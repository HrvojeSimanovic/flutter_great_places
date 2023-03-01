import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart' as syspaths;
import 'package:path/path.dart' as path;

class ImageInput extends StatefulWidget {
  final Function onSelectImage;

  const ImageInput(this.onSelectImage, {Key? key}) : super(key: key);

  @override
  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File? _storedImage;

  Future<void> _takePictureHandler() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? imageFile = await _picker.pickImage(
      source: ImageSource.camera,
      maxWidth: 600,
    );
    if (imageFile == null) {
      return;
    }
    setState(() {
      _storedImage = File(imageFile.path);
    });
    final addDir = await syspaths.getApplicationDocumentsDirectory();
    final fileName = path.basename(_storedImage!.path);
    final savedImage = await _storedImage!.copy('${addDir.path}/$fileName');
    widget.onSelectImage(savedImage);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 200.0,
          height: 150.0,
          decoration: BoxDecoration(
            border: Border.all(width: 1),
            color: Colors.grey[400],
          ),
          child: _storedImage != null
              ? Image.file(
                  _storedImage!,
                  width: double.infinity,
                  fit: BoxFit.cover,
                )
              : const Text('No image taken'),
          alignment: Alignment.center,
        ),
        const SizedBox(width: 10),
        Expanded(
          child: TextButton.icon(
            onPressed: _takePictureHandler,
            icon: const Icon(Icons.camera),
            label: const Text('take photo'),
          ),
        ),
      ],
    );
  }
}
