import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../l10n/localization_context.dart';

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
        title: Text(context.l10n.selectImageSource),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, ImageSource.camera),
            child: Text(context.l10n.camera),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, ImageSource.gallery),
            child: Text(context.l10n.gallery),
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
      appBar: AppBar(title: Text(context.l10n.selectCheckpointImage)),
      body: Center(
        child: _pickedImage == null
            ? Text(context.l10n.nothingSelected)
            : Image.file(_pickedImage!, fit: BoxFit.contain),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _pickImage,
        tooltip: context.l10n.chooseImage,
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
                child: Text(context.l10n.cancel),
              ),
              const SizedBox(width: 8),
              FilledButton(
                onPressed: () => Navigator.pop(context, _pickedImage),
                child: Text(context.l10n.select),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
