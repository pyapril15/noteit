// lib/ui/screens/profile_screen.dart
import 'dart:developer' as developer;
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app/routes.dart';
import '../../controllers/auth_controller.dart';
import '../../controllers/preferences_controller.dart';
import '../../controllers/user_controller.dart';
import '../../data/models/user_model.dart';
import '../../secondary_firebase/firebase_secondary_service.dart';
import '../../utils/validators.dart';
import '../widgets/app_snackbar.dart';
import '../widgets/detail_row_widget.dart';
import '../widgets/dob_picker_widget.dart';
import '../widgets/email_status_widget.dart';
import '../widgets/profile_picture_widget.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final PreferencesController _preferencesController =
      Get.find<PreferencesController>();
  final UserController _userController = Get.find<UserController>();
  final AuthController _authController = Get.find<AuthController>();
  User? _firebaseUser;
  UserModel? _userModel;
  FirebaseApp? _secondaryApp;

  final _nameController = TextEditingController();
  final _dobController = TextEditingController();
  final _stateController = TextEditingController();
  final _cityController = TextEditingController();

  File? _image;
  bool _isUploading = false;
  String? _imageUrl;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _initSecondaryApp();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _initUserData();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _dobController.dispose();
    _stateController.dispose();
    _cityController.dispose();
    super.dispose();
  }

  Future<void> _initUserData() async {
    _firebaseUser = FirebaseAuth.instance.currentUser;
    _userModel = _userController.user.value;

    _nameController.text = _firebaseUser?.displayName ?? '';

    _userModel ??= UserModel(
      uid: _firebaseUser?.uid ?? '',
      name: _firebaseUser?.displayName ?? '',
      email: _firebaseUser?.email ?? '',
      profilePhoto: _firebaseUser?.photoURL ?? '',
    );

    _dobController.text = _userModel!.dob ?? '';
    _stateController.text = _userModel!.state ?? '';
    _cityController.text = _userModel!.city ?? '';
  }

  Future<void> _initSecondaryApp() async {
    try {
      _secondaryApp =
          await FirebaseSecondaryService.initializeSecondaryFirebaseApp();
    } catch (e, stackTrace) {
      developer.log(
        'ProfileScreen - Initialize Secondary App Error',
        error: e,
        stackTrace: stackTrace,
      ); // Log error
      if (mounted) {
        AppSnackbar.show(
          'Error',
          'Failed to initialize secondary app',
          isError: true,
        );
      }
    }
  }

  Future<void> _uploadImage(File? image) async {
    if (image == null || _secondaryApp == null) return;
    setState(() {
      _isUploading = true;
    });
    try {
      final ref = FirebaseSecondaryService.getSecondaryStorage().ref().child(
        'noteit/${_userModel!.uid}/profile_image/${_userModel!.name}.jpg',
      );
      await ref.putFile(image);
      _imageUrl = await ref.getDownloadURL();
      setState(() {
        _isUploading = false;
      });
      if (mounted) {
        AppSnackbar.show('Success', 'Profile image uploaded.');
      }
    } catch (e, stackTrace) {
      setState(() {
        _isUploading = false;
      });
      developer.log(
        'ProfileScreen - Upload Image Error',
        error: e,
        stackTrace: stackTrace,
      );
      if (mounted) {
        AppSnackbar.show('Error', 'Failed to upload image.', isError: true);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => _showLogoutDialog(context),
          ),
        ],
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: ProfilePictureWidget(
                    userModel: _userModel,
                    onImageSelected: (file) {
                      setState(() {
                        _image = file;
                      });
                    },
                    onImageUpload: _uploadImage,
                    isUploading: _isUploading,
                    image: _image,
                  ),
                ),
                const SizedBox(height: 32),
                DetailRowWidget(
                  label: 'Name',
                  controller: _nameController,
                  icon: Icons.person,
                  validator: validateCharactersOnly,
                ),
                DOBPickerWidget(controller: _dobController),
                DetailRowWidget(
                  label: 'State',
                  controller: _stateController,
                  icon: Icons.location_city,
                  validator: validateCharactersOnly,
                ),
                DetailRowWidget(
                  label: 'City',
                  controller: _cityController,
                  icon: Icons.location_on,
                  validator: validateCharactersOnly,
                ),
                EmailStatusWidget(firebaseUser: _firebaseUser),
                const SizedBox(height: 32),
                ListTile(
                  tileColor: Colors.transparent,
                  title: const Text('Theme Switch'),
                  trailing: Switch(
                    value: _preferencesController.isDarkMode.value,
                    onChanged: (value) => _preferencesController.toggleTheme(),
                  ),
                ),
                const SizedBox(height: 120),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SizedBox(
                width: double.infinity,
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child:
                      _isSaving
                          ? const Center(child: CircularProgressIndicator())
                          : ElevatedButton(
                            onPressed: () {
                              _updateProfile();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  Theme.of(context).colorScheme.primary,
                              foregroundColor:
                                  Theme.of(context).colorScheme.onPrimary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              elevation: 4,
                              padding: const EdgeInsets.symmetric(
                                vertical: 16,
                                horizontal: 24,
                              ),
                            ),
                            child: const Text(
                              'Save Profile',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _updateProfile() async {
    setState(() {
      _isSaving = true;
    });
    try {
      await _updateUserDetail();
      final updatedUser = UserModel(
        uid: _userModel!.uid,
        name: _nameController.text,
        email: _userModel!.email,
        dob: _dobController.text,
        state: _stateController.text,
        city: _cityController.text,
        profilePhoto: _imageUrl ?? _userModel!.profilePhoto,
      );
      await _userController.updateUserData(updatedUser);
      setState(() {
        _isSaving = false;
      });
      if (mounted) {
        AppSnackbar.show(
          'Success',
          'Profile updated successfully',
        ); // Use AppSnackbar
      }
    } catch (e, stackTrace) {
      setState(() {
        _isSaving = false;
      });
      developer.log(
        'ProfileScreen - Update Profile Error',
        error: e,
        stackTrace: stackTrace,
      );
      if (mounted) AppSnackbar.show('Error', 'Failed to update profile: $e');
    }
  }

  Future<void> _updateUserDetail() async {
    _firebaseUser?.updateDisplayName(_nameController.text);
    _firebaseUser?.updatePhotoURL(_imageUrl ?? _userModel!.profilePhoto);
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Logout'),
          content: const Text('Are you sure you want to logout?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              onPressed: () {
                _authController.logout();
                _userController.clearUserData();
                Get.offAllNamed(Routes.login);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.error,
                foregroundColor: Theme.of(context).colorScheme.onError,
              ),
              child: const Text('Logout'),
            ),
          ],
        );
      },
    );
  }
}
