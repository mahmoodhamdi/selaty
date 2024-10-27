import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class BestValueItem extends StatelessWidget {
  final String imageUrl; // Accept the image URL as a parameter
  static const String _urlPrefix =
      'https://marketappmaster.com/uploads/'; // URL prefix

  const BestValueItem({
    super.key,
    required this.imageUrl, // Require the image URL
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0),
      child: Container(
        clipBehavior: Clip.hardEdge,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        child: CachedNetworkImage(
          imageUrl:
              '$_urlPrefix$imageUrl', // Append the URL prefix to the image URL
          fit: BoxFit.cover,

          errorWidget: (context, url, error) => Icon(
            Icons.error,
            color: Theme.of(context).colorScheme.error,
          ),
        ),
      ),
    );
  }
}
