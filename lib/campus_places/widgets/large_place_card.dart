import 'package:flutter/material.dart';
import 'package:univalle_app/models/models.dart';
import 'package:univalle_app/theme/theme.dart';

class LargePlaceCard extends StatelessWidget {
  const LargePlaceCard(this.place, {Key? key}) : super(key: key);

  final Place place;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1 / 1.3,
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
            top: 12,
            left: 12,
            right: 12,
            child: Text(
              place.name,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context)
                  .textTheme
                  .headline2!
                  .copyWith(color: AppColors.white),
            ),
          ),
          Positioned(
            bottom: 14,
            right: 12,
            child: Text(
              place.campus.name,
              style: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(color: AppColors.white),
            ),
          ),
        ],
      ),
    );
  }
}
