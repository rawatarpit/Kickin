import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../core/theme/kickin_spacing.dart';
import '../../../core/theme/kickin_colors.dart';
import '../../../core/widgets/buttons/primary_button.dart';
import '../../../core/utils/image_picker_helper.dart';
import '../../../core/models/sb_profile.dart';
import '../../../core/supabase/profile_service.dart';
import '../../../core/media/cloudinary_service.dart';

enum UserType { player, coach, academy, scout }

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();

  DateTime? _dob;
  UserType? _userType;
  File? _profileImage;

  bool _loading = false;
  String? _error;

  bool get _canContinue =>
      !_loading &&
      _nameController.text.trim().isNotEmpty &&
      _dob != null &&
      _userType != null &&
      _profileImage != null;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final image = await ImagePickerHelper.pickFromGallery();
    if (image != null) {
      setState(() => _profileImage = image);
    }
  }

  Future<void> _submitProfile() async {
    if (!_canContinue) return;

    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    setState(() {
      _loading = true;
      _error = null;
    });

    try {
      // Upload image to Cloudinary
      final imageUrl = await CloudinaryService.uploadProfileImage(
        _profileImage!,
      );

      final profile = SbProfile(
        firebaseUid: user.uid,
        name: _nameController.text.trim(),
        email:
            _emailController.text.trim().isEmpty
                ? null
                : _emailController.text.trim(),
        dob: _dob!,
        userType: _userType!.name,
        profileImageUrl: imageUrl,
      );

      await ProfileService.createProfile(profile);

      // ✅ IdentityGate will auto-route after profile creation
    } catch (e) {
      setState(() {
        _error = 'Failed to create profile. Please try again.';
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(
            KickinSpacing.lg,
            KickinSpacing.xl,
            KickinSpacing.lg,
            KickinSpacing.lg,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Create your profile', style: textTheme.headlineLarge),
              const SizedBox(height: KickinSpacing.sm),
              Text(
                'This helps others recognize and connect with you.',
                style: textTheme.bodyMedium,
              ),

              const SizedBox(height: KickinSpacing.xl),

              Center(
                child: GestureDetector(
                  onTap: _pickImage,
                  child: CircleAvatar(
                    radius: 44,
                    backgroundColor: KickinColors.surface,
                    backgroundImage:
                        _profileImage != null
                            ? FileImage(_profileImage!)
                            : null,
                    child:
                        _profileImage == null
                            ? const Icon(
                              Icons.camera_alt,
                              color: KickinColors.textMuted,
                            )
                            : null,
                  ),
                ),
              ),

              const SizedBox(height: KickinSpacing.xl),

              TextField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Full name'),
                onChanged: (_) => setState(() {}),
              ),

              const SizedBox(height: KickinSpacing.md),

              TextField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email (optional)',
                ),
              ),

              const SizedBox(height: KickinSpacing.md),

              GestureDetector(
                onTap: () async {
                  final picked = await showDatePicker(
                    context: context,
                    firstDate: DateTime(1960),
                    lastDate: DateTime.now(),
                    initialDate: DateTime(2005),
                  );
                  if (picked != null) {
                    setState(() => _dob = picked);
                  }
                },
                child: InputDecorator(
                  decoration: const InputDecoration(labelText: 'Date of birth'),
                  child: Text(
                    _dob == null
                        ? 'Select date'
                        : '${_dob!.day}/${_dob!.month}/${_dob!.year}',
                  ),
                ),
              ),

              const SizedBox(height: KickinSpacing.lg),

              Text('Who are you?', style: textTheme.bodyMedium),
              const SizedBox(height: KickinSpacing.sm),

              Wrap(
                spacing: 10,
                runSpacing: 10,
                children:
                    UserType.values.map((type) {
                      final selected = _userType == type;
                      return ChoiceChip(
                        label: Text(type.name),
                        selected: selected,
                        onSelected: (_) {
                          setState(() => _userType = type);
                        },
                      );
                    }).toList(),
              ),

              if (_error != null) ...[
                const SizedBox(height: KickinSpacing.md),
                Text(
                  _error!,
                  style: textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.error,
                  ),
                ),
              ],

              const SizedBox(height: KickinSpacing.xl),

              PrimaryButton(
                label: 'Continue',
                enabled: _canContinue,
                loading: _loading,
                onTap: _submitProfile,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
