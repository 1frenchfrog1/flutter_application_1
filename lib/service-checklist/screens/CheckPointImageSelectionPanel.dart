import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CheckPointImageSelectionPanel extends StatefulWidget {
  static const String routeName = '/editCheckPointImage';

  const CheckPointImageSelectionPanel({super.key});

  @override
  State<CheckPointImageSelectionPanel> createState() =>
      _CheckPointImageSelectionPanelState();
}

class _CheckPointImageSelectionPanelState
    extends State<CheckPointImageSelectionPanel> {
  final ImagePicker _picker = ImagePicker();
  File? _pickedImage;

  Future<void> _pickImage() async {
    final source = await showDialog<ImageSource>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Select image source'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, ImageSource.camera),
            child: const Text('Camera'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, ImageSource.gallery),
            child: const Text('Gallery'),
          ),
        ],
      ),
    );
    if (source == null) return;

    final image = await _picker.pickImage(
      source: source,
      maxHeight: 800,
      maxWidth: 800,
    );
    if (image != null && mounted) {
      setState(() => _pickedImage = File(image.path));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[600],
      appBar: AppBar(title: const Text('Select checkpoint image')),
      body: Center(
        child: _pickedImage == null
            ? const Text('Nothing selected')
            : Image.file(_pickedImage!, fit: BoxFit.contain),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _pickImage,
        tooltip: 'Choose image',
        child: const Icon(Icons.image),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
              const SizedBox(width: 8),
              FilledButton(
                onPressed: () => Navigator.pop(context, _pickedImage),
                child: const Text('Select'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
