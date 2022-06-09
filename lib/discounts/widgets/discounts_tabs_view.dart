import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:univalle_app/discounts/discounts.dart';
import 'package:univalle_app/models/models.dart';
import 'package:univalle_app/theme/app_colors.dart';

class DiscountsTabsView extends StatefulWidget {
  const DiscountsTabsView(this.categories, {Key? key}) : super(key: key);
  final Map<String, List<Discount>> categories;

  @override
  State<DiscountsTabsView> createState() => _DiscountsTabsViewState();
}

class _DiscountsTabsViewState extends State<DiscountsTabsView>
    with TickerProviderStateMixin {
  final _itemScrollController = ItemScrollController();
  final _itemPositionsListener = ItemPositionsListener.create();
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(
      length: widget.categories.length,
      vsync: this,
    );

    _itemPositionsListener.itemPositions.addListener(_updateTabBar);
    super.initState();
  }

  @override
  void dispose() {
    _itemPositionsListener.itemPositions.removeListener(_updateTabBar);
    _tabController.dispose();
    super.dispose();
  }

  void _updateTabBar() {
    if (_tabController.indexIsChanging) return;
    final positions = _itemPositionsListener.itemPositions.value;
    if (positions.first.index == _tabController.index) return;

    _tabController.animateTo(positions.first.index);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: TabBar(
            indicator: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: AppColors.shiraz.shade300,
            ),
            labelColor: AppColors.white,
            unselectedLabelColor: AppColors.gray.shade400,
            controller: _tabController,
            tabs: widget.categories.keys
                .map((key) => Tab(text: key, height: 32))
                .toList(),
            isScrollable: true,
            onTap: (index) {
              _itemScrollController.scrollTo(
                index: index,
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeInOutCubic,
              );
            },
          ),
        ),
        Expanded(
          child: ScrollablePositionedList.builder(
            padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
            itemCount: widget.categories.length,
            itemBuilder: (_, index) => DiscountCategoryList(
              widget.categories.keys.toList()[index],
              widget.categories.values.toList()[index],
            ),
            itemScrollController: _itemScrollController,
            itemPositionsListener: _itemPositionsListener,
          ),
        ),
      ],
    );
  }
}
