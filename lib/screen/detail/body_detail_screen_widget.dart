import 'package:eateryhub/data/model/detail_restaurant.dart';
import 'package:eateryhub/screen/detail/page/menu/detail_menu_tab_page.dart';
import 'package:eateryhub/screen/detail/page/review/detail_review_tab_page.dart';
import 'package:flutter/material.dart';

class BodyOfDetailScreenWidget extends StatelessWidget {
  final DetailRestaurant detailRestaurant;

  const BodyOfDetailScreenWidget({super.key, required this.detailRestaurant});

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      headerSliverBuilder: (context, innerBoxIsScrolled) => [
        SliverToBoxAdapter(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                width: double.infinity,
                height: 300,
                fit: BoxFit.cover,
                "https://restaurant-api.dicoding.dev/images/large/${detailRestaurant.pictureId}",
              ),
              Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          detailRestaurant.name,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        Spacer(),
                        Icon(Icons.star, size: 20),
                        Text(
                          "${detailRestaurant.rating} / 5.0",
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                      ],
                    ),
                    SizedBox.square(dimension: 8),
                    Row(
                      children: [
                        Icon(Icons.location_pin, size: 20),
                        Text(
                          "${detailRestaurant.address}, ${detailRestaurant.city}",
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                    SizedBox.square(dimension: 8),
                    Text(
                      detailRestaurant.description,
                      style: Theme.of(context).textTheme.bodyMedium,
                      textAlign: TextAlign.justify,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SliverPersistentHeader(
          pinned: true,
          delegate: _SliverTabBarDelegate(
            TabBar(
              tabs: [
                Tab(text: "Menu"),
                Tab(text: "Reviews"),
              ],
            ),
          ),
        ),
      ],
      body: TabBarView(children: [DetailMenuTabPage(), DetailReviewTabPage()]),
    );
  }
}

class _SliverTabBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar _tabbar;
  _SliverTabBarDelegate(this._tabbar);
  
  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: _tabbar,
    );
  }
  
  @override
  double get maxExtent => _tabbar.preferredSize.height;
  
  @override
  double get minExtent => _tabbar.preferredSize.height;
  
  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) => false;
}