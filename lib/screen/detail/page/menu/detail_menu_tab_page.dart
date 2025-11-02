import 'package:flutter/material.dart';

class MenuSection {
  final String title;
  final List<String> items;

  MenuSection({required this.title, required this.items});
}

class DetailMenuTabPage extends StatelessWidget {
  const DetailMenuTabPage({super.key, required this.sections});

  final List<MenuSection> sections;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        for (final section in sections) ...[
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: Text(
                section.title,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
          ),

          SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              final item = section.items[index];
              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 4,
                ),
                child: Text(
                  item,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              );
            }, childCount: section.items.length),
          ),
        ],
      ],
    );
  }
}
