import 'package:flutter/material.dart';
import 'package:univalle_app/models/discount.dart';
import 'package:univalle_app/theme/theme.dart';

class DiscountCategoryList extends StatelessWidget {
  const DiscountCategoryList(
    this.category,
    this.discounts, {
    Key? key,
  }) : super(key: key);
  final String category;
  final List<Discount> discounts;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8),
        Text(
          category,
          style: Theme.of(context).textTheme.headline3,
        ),
        const SizedBox(height: 12),
        GridView.builder(
          primary: false,
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 24,
            mainAxisSpacing: 24,
          ),
          itemCount: discounts.length,
          itemBuilder: (_, index) {
            return Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    image: DecorationImage(
                      image: NetworkImage(
                        discounts[index].establishmentImageUrl,
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    gradient: const LinearGradient(
                      colors: [
                        Colors.transparent,
                        Colors.transparent,
                        Colors.black12,
                        Colors.black54,
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 12,
                  left: 12,
                  right: 12,
                  child: Tooltip(
                    message: discounts[index].establishmentName,
                    child: Text(
                      discounts[index].establishmentName,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context)
                          .textTheme
                          .subtitle2!
                          .copyWith(color: AppColors.white),
                    ),
                  ),
                )
              ],
            );
          },
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
