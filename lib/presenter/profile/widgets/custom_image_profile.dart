import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomImageProfile extends StatefulWidget {
  final Function() onTap;
  final String imagePath;
  final bool isLoading;
  const CustomImageProfile({
    super.key,
    required this.onTap,
    this.imagePath = '',
    this.isLoading = false,
  });

  @override
  State<CustomImageProfile> createState() => _CustomImageProfileState();
}

class _CustomImageProfileState extends State<CustomImageProfile> {
  bool get _hasImage => widget.imagePath != '';

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
          if (widget.isLoading)
            const Center(
              child: CircularProgressIndicator(strokeWidth: 0.5, color: Colors.black),
            )
          else ...[
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
                      child: CachedNetworkImage(
                        placeholder: (context, url) => const CircularProgressIndicator(strokeWidth: 0.5, color: Colors.black),
                        imageUrl: widget.imagePath,
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
                : Icon(
                    Icons.camera_alt,
                    color: Colors.white.withOpacity(0.7),
                    size: 50,
                  ),
          ]
        ],
      ),
    );
  }
}
