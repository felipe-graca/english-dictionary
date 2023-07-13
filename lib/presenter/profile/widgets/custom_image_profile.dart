import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomImageProfile extends StatefulWidget {
  final Function() onTap;
  final File? imageFile;
  const CustomImageProfile({
    super.key,
    required this.onTap,
    this.imageFile,
  });

  @override
  State<CustomImageProfile> createState() => _CustomImageProfileState();
}

class _CustomImageProfileState extends State<CustomImageProfile> {
  bool get _hasImage => widget.imageFile != null;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey.withOpacity(0.8),
            ),
            child: Opacity(
              opacity: 0.3,
              child: SvgPicture.asset(
                'assets/icons/profile.svg',
              ),
            ),
          ),
          _hasImage
              ? Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white.withOpacity(0.5),
                      width: 2,
                    ),
                  ),
                  width: 120,
                  height: 120,
                  child: ClipOval(
                    child: Image.file(
                      widget.imageFile!,
                      fit: BoxFit.cover,
                    ),
                  ),
                )
              : Icon(
                  Icons.camera_alt,
                  color: Colors.white.withOpacity(0.7),
                  size: 50,
                ),
        ],
      ),
    );
  }
}
