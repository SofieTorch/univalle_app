import 'package:flutter/material.dart';
import 'package:univalle_app/models/place.dart';
import 'package:univalle_app/theme/theme.dart';

class SquarePlaceCard extends StatelessWidget {
  const SquarePlaceCard(this.place, {Key? key}) : super(key: key);

  final Place place;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1 / 1,
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              image: DecorationImage(
                image: (place.imageUrl.contains('image')
                    ? NetworkImage(place.imageUrl)
                    : const AssetImage(
                        'assets/illustrations/image_not_found.png',
                      )) as ImageProvider,
                fit: place.imageUrl.contains('image')
                    ? BoxFit.cover
                    : BoxFit.fitWidth,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              color: Colors.black54.withAlpha(60),
            ),
          ),
          Positioned(
            bottom: 12,
            left: 8,
            right: 8,
            child: Text(
              place.name,
              style: Theme.of(context)
                  .textTheme
                  .subtitle1!
                  .copyWith(color: AppColors.white),
            ),
          ),
        ],
      ),
    );
  }
}
