import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  XFile? _imageFile;

  // Pick an image
  Future pickImage() async {
    final ImagePicker picker = ImagePicker();

    // Pick an image from the gallery
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _imageFile = image; // Use XFile for web compatibility
      });
    }
  }

  // Upload image to Supabase
  Future uploadImage() async {
    if (_imageFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("No image selected.")),
      );
      return;
    }

    try {
      // Generate a unique file path
      final fileName = DateTime.now().millisecondsSinceEpoch.toString();
      final path = 'upload/$fileName.jpg';

      // Read the file as bytes
      final Uint8List fileBytes = await _imageFile!.readAsBytes();

      // Upload image to Supabase storage
      await Supabase.instance.client.storage
          .from('Profile_images')
          .uploadBinary(path, fileBytes);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Image upload successful!")),
      );
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Image upload failed: $error")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Welcome Text
            const Center(
              child: Text(
                'Welcome to the Home Page!',
                style: TextStyle(fontSize: 20),
              ),
            ),
            const SizedBox(height: 16),
            // Image preview
            _imageFile != null
                ? Image.network(
                    _imageFile!.path, // Display image using path
                    height: 200,
                  )
                : const Text("No image selected.."),
            const SizedBox(height: 16),
            // Pick image button
            ElevatedButton(
              onPressed: pickImage,
              child: const Text('Pick Image'),
            ),
            // Upload button
            ElevatedButton(
              onPressed: uploadImage,
              child: const Text("Upload"),
            ),
          ],
        ),
      ),
    );
  }
}
