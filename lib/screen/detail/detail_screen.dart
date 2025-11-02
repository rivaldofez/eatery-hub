import 'package:eateryhub/screen/detail/detail_menu_tab_page.dart';
import 'package:eateryhub/screen/detail/detail_review_tab_page.dart';
import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(title: Text("Detail Restaurant")),
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(
                    width: double.infinity,
                    height: 200,
                    fit: BoxFit.cover,
                    "https://upload.wikimedia.org/wikipedia/commons/thumb/9/91/Pizza-3007395.jpg/1200px-Pizza-3007395.jpg",
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
                              "Bella Italia Trattoria",
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            Spacer(),
                            Icon(Icons.star, size: 20),
                            Text(
                              "4.5",
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                          ],
                        ),
                        SizedBox.square(dimension: 8),
                        Row(
                          children: [
                            Icon(Icons.location_pin, size: 20),
                            Text(
                              "Jl Medan Merdeka Selatan, Jakarta",
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ],
                        ),
                        SizedBox.square(dimension: 8),
                        Text(
                          "Experience authentic Italian cuisine in a cozy, rustic setting. Our trattoria offers classic dishes made with the freshest local ingredients, perfect for a romantic dinner or a family gathering",
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
                  labelColor: Colors.black,
                  unselectedLabelColor: Colors.grey,
                  tabs: [
                    Tab(text: "Menu"),
                    Tab(text: "Reviews")
                  ],
                )
              ),
            )
          ],
          body: TabBarView(
            children: [
              DetailMenuTabPage(),
              DetailReviewTabPage()
            ],
          ),
        ),
      ),
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