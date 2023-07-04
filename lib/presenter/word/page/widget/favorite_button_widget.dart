import 'package:flutter/material.dart';

class FavoriteButtonWidget extends StatelessWidget {
  final bool isLoading;
  final bool isFavorite;
  final Function() onTap;
  const FavoriteButtonWidget({super.key, this.isFavorite = false, required this.onTap, this.isLoading = false});

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const SizedBox(
            width: 50,
            height: 50,
            child: Center(
              child: SizedBox(
                width: 30,
                height: 30,
                child: CircularProgressIndicator(),
              ),
            ),
          )
        : SizedBox(
            width: 50,
            height: 50,
            child: InkWell(
              onTap: onTap,
              child: Icon(
                isFavorite ? Icons.favorite : Icons.favorite_border,
                color: isFavorite ? Colors.red : Colors.grey,
                size: 30,
              ),
            ),
          );
  }
}
