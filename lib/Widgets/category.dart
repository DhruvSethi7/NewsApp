import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:newsapp2/Provider/newsprovider.dart';
class Category extends ConsumerWidget {
  final mediaobj;
  const Category({super.key, required this.mediaobj});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categories=ref.read(newsCategoryProvider);
    return Container(
        margin: EdgeInsets.only(top: mediaobj.height * 0.12),
        height: mediaobj.height * 0.06,
        width: double.infinity,
        padding: EdgeInsets.only(top: mediaobj.height * 0.03),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return GestureDetector(
                onTap: () {
                 ref.read(selectedCategoryProvider.notifier).state=categories[index];
                },
                child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      categories[index],
                      style: TextStyle(
                          fontFamily: 'Nunito',
                          fontSize: 20,
                          fontWeight:ref.watch(selectedCategoryProvider)==categories[index]
                              ? FontWeight.w900
                              : FontWeight.w700),
                    )));
          },
          itemCount: categories.length,
        ));
  }
}