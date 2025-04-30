import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_shop_app/common/widgets/loading/loading.dart';
import 'package:my_shop_app/features/category/controller/category_controller.dart';
import '../../category/screens/category_products.dart';
import '/../../common/helper/images/image_display.dart';
import '/../../common/helper/navigator/app_navigator.dart';
import '../../category/screens/all_categories.dart';
import 'package:flutter/material.dart';

import '../../../data/category/entity/category.dart';

class Categories extends ConsumerWidget {
  const Categories({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder(
      future: ref.read(categoryControllerProvider).getCategories(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Loader();
        }
        List<CategoryEntity> categories = snapshot.data!;
        return Column(
          children: [
            _seaAll(context, categories),
            const SizedBox(height: 20),

            _categories(categories, context),
          ],
        );
      },
    );
  }
}

Widget _seaAll(BuildContext context, List<CategoryEntity> categories) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Categories',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        GestureDetector(
          onTap: () {
            AppNavigator.push(
              context,
              AllCategoriesPage(categories: categories),
            );
          },
          child: const Text(
            'See All',
            style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
          ),
        ),
      ],
    ),
  );
}

Widget _categories(List<CategoryEntity> categories, BuildContext context) {
  return SizedBox(
    height: 100,
    child: ListView.separated(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemBuilder: (contetx, index) {
        return GestureDetector(
          onTap: () {
            AppNavigator.push(
              context,
              CategoryProductsPage(categoryEntity: categories[index]),
            );
          },
          child: Column(
            children: [
              Container(
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: NetworkImage(
                      ImageDisplayHelper.generateCategoryImageURL(
                        categories[index].image,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                categories[index].title,
                style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        );
      },
      separatorBuilder: (context, index) => const SizedBox(width: 15),
      itemCount: categories.length,
    ),
  );
}
