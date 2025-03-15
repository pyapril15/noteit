// lib/ui/widgets/profile_picture_widget.dart
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:noteit/ui/widgets/loading_widget.dart';

import '../../data/models/user_model.dart';

class ProfilePictureWidget extends StatefulWidget {
  final UserModel? userModel;
  final Function(File?) onImageSelected;
  final Function(File?) onImageUpload;
  final bool isUploading;
  final File? image;

  const ProfilePictureWidget({
    super.key,
    required this.userModel,
    required this.onImageSelected,
    required this.onImageUpload,
    required this.isUploading,
    required this.image,
  });

  @override
  State<ProfilePictureWidget> createState() => _ProfilePictureWidgetState();
}

class _ProfilePictureWidgetState extends State<ProfilePictureWidget> {
  final picker = ImagePicker();

  Future<void> _getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final imageFile = File(pickedFile.path);
      widget.onImageSelected(imageFile);
      widget.onImageUpload(imageFile);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Stack(
        children: [
          CircleAvatar(
            radius: 70,
            backgroundColor: theme.colorScheme.surfaceContainerHighest,
            backgroundImage:
                widget.image != null
                    ? FileImage(widget.image!)
                    : widget.userModel?.profilePhoto != null
                    ? NetworkImage(widget.userModel!.profilePhoto!, scale: 1.0)
                    : null,
            child:
                widget.userModel?.profilePhoto != null && widget.image == null
                    ? Image.network(
                      widget.userModel!.profilePhoto!,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) {
                          return const SizedBox.shrink();
                        }
                        return Center(
                          child: LoadingWidget(text: "Image Loading"),
                        );
                      },
                      errorBuilder: (context, object, stackTrace) {
                        return Icon(
                          Icons.error,
                          size: 70,
                          color: theme.colorScheme.error,
                        );
                      },
                    )
                    : widget.isUploading
                    ? Center(child: LoadingWidget(text: "Image Uploading"))
                    : widget.image == null &&
                        widget.userModel?.profilePhoto == null
                    ? Icon(
                      Icons.person,
                      size: 70,
                      color: theme.colorScheme.onSurface,
                    )
                    : null,
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: theme.colorScheme.primary.withAlpha(204),
              ),
              child: IconButton(
                icon: Icon(
                  Icons.camera_alt,
                  color: theme.colorScheme.onPrimary,
                ),
                onPressed: _getImage,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
