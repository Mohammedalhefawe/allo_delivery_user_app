import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/features/category/domain/models/new_category_model.dart';

class NewCategoriesWidget extends StatelessWidget {
  final List<NewCategoryModel> categories;
  final int selectedCategory;
  final void Function(int) press;

  const NewCategoriesWidget({
    super.key,
    required this.categories,
    required this.selectedCategory,
    required this.press,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ...List.generate(
            categories.length,
            (index) => Padding(
              padding: EdgeInsetsDirectional.only(
                  start: index == 0 ? 8 : 8 / 2,
                  end: index == categories.length - 1 ? 8 : 0),
              child: CategoryBtn(
                category: index == 0 ? 'الكل' : categories[index].name,
                isActive: selectedCategory == categories[index].id,
                press: () => press(categories[index].id),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CategoryBtn extends StatelessWidget {
  const CategoryBtn({
    super.key,
    required this.category,
    required this.isActive,
    required this.press,
  });

  final String category;
  final bool isActive;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: press,
      borderRadius: const BorderRadius.all(Radius.circular(30)),
      child: Container(
        height: 36,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: isActive ? const Color(0xFF535353) : Colors.transparent,
          border:
              Border.all(color: isActive ? Colors.transparent : Colors.black12),
          borderRadius: const BorderRadius.all(Radius.circular(30)),
        ),
        child: Row(
          children: [
            Text(
              category,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: isActive
                    ? Colors.white
                    : Theme.of(context).textTheme.bodyLarge!.color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
