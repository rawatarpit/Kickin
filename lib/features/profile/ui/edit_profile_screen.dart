import 'dart:io';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/theme/kickin_spacing.dart';
import '../../../core/widgets/buttons/primary_button.dart';
import '../../../core/utils/image_picker_helper.dart';
import '../../../core/media/cloudinary_service.dart';
import '../../../core/supabase/profile_service.dart';

class EditProfileScreen extends StatefulWidget {
  final Map<String, dynamic> profile;

  const EditProfileScreen({super.key, required this.profile});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late TextEditingController _name;
  File? _image;
  bool _loading = false;

  final _client = Supabase.instance.client;

  @override
  void initState() {
    super.initState();
    _name = TextEditingController(text: widget.profile['name']);
  }

  Future<void> _save() async {
    setState(() => _loading = true);

    String? imageUrl = widget.profile['profile_image'];

    if (_image != null) {
      imageUrl = await CloudinaryService.uploadImage(_image!);
    }

    await ProfileService.updateProfile(
      userId: _client.auth.currentUser!.id,
      name: _name.text.trim(),
      profileImageUrl: imageUrl,
    );

    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit profile')),
      body: Padding(
        padding: const EdgeInsets.all(KickinSpacing.lg),
        child: Column(
          children: [
            GestureDetector(
              onTap: () async {
                final img = await ImagePickerHelper.pickFromGallery();
                if (img != null) setState(() => _image = img);
              },
              child: CircleAvatar(
                radius: 44,
                backgroundImage:
                    _image != null
                        ? FileImage(_image!)
                        : widget.profile['profile_image'] != null
                        ? NetworkImage(widget.profile['profile_image'])
                        : null,
                child:
                    _image == null && widget.profile['profile_image'] == null
                        ? const Icon(Icons.camera_alt)
                        : null,
              ),
            ),
            const SizedBox(height: 24),
            TextField(
              controller: _name,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            const Spacer(),
            PrimaryButton(label: 'Save', loading: _loading, onTap: _save),
          ],
        ),
      ),
    );
  }
}
