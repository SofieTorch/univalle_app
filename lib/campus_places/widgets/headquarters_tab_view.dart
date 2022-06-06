import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:univalle_app/campus_places/campus_places.dart';
import 'package:univalle_app/theme/app_colors.dart';

class HeadquartersTabView extends StatelessWidget {
  const HeadquartersTabView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final places = context.read<PlaceListBloc>().state.otherPlaces;

    return SizedBox(
      height: 250,
      child: DefaultTabController(
        length: places.length,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TabBar(
              indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: AppColors.shiraz.shade300,
              ),
              labelColor: AppColors.white,
              unselectedLabelColor: AppColors.gray.shade400,
              isScrollable: true,
              tabs: places.keys
                  .map((e) => Tab(text: e.department, height: 28))
                  .toList(),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: TabBarView(
                children: places.values
                    .map(
                      (e) => ListView.separated(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        primary: false,
                        itemCount: e.length,
                        itemBuilder: (_, index) => SquarePlaceCard(e[index]),
                        separatorBuilder: (_, index) =>
                            const SizedBox(width: 16),
                      ),
                    )
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
