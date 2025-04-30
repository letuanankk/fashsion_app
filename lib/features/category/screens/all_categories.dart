import 'package:flutter/material.dart';
import '../../../common/helper/images/image_display.dart';
import '../../../common/helper/navigator/app_navigator.dart';
import '../../../common/widgets/appbar/app_bar.dart';
import '../../../core/configs/theme/app_colors.dart';
import '../../../data/category/entity/category.dart';
import 'category_products.dart';

class AllCategoriesPage extends StatelessWidget {
  final List<CategoryEntity> categories;
  const AllCategoriesPage({super.key, required this.categories});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BasicAppbar(hideBack: false),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _shopByCategories(),
            const SizedBox(height: 10),
            _categories(categories),
          ],
        ),
      ),
    );
  }

  Widget _shopByCategories() {
    return const Text(
      'Shop by Categories',
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
    );
  }

  Widget _categories(List<CategoryEntity> categories) {
    return ListView.separated(
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            AppNavigator.push(
              context,
              CategoryProductsPage(categoryEntity: categories[index]),
            );
          },
          child: Container(
            height: 70,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.secondBackground,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: NetworkImage(
                        ImageDisplayHelper.generateCategoryImageURL(
                          categories[index].image,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 15),
                Text(
                  categories[index].title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        );
      },
      separatorBuilder: (context, index) => const SizedBox(height: 10),
      itemCount: categories.length,
    );
  }
}
