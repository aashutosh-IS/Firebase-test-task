import 'package:demo_app/const/helper.dart';
import 'package:demo_app/presentation/fetch_categories/fetch_categories_cubit.dart';
import 'package:demo_app/presentation/screen/detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../model/category_model.dart';
import 'basic_widgets/custom_text.dart';

class ContentSection extends StatefulWidget {
  const ContentSection({super.key});

  @override
  State<ContentSection> createState() => _ContentSectionState();
}

class _ContentSectionState extends State<ContentSection> {
  late SubcategoryModel subcategory;
  List<CategoryModel> get categoryData =>
      context.read<FetchCategoriesCubit>().state.categories ?? [];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount:
          context.watch<FetchCategoriesCubit>().state.filteredList!.isNotEmpty
              ? context.watch<FetchCategoriesCubit>().state.filteredList!.length
              : categoryData.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final category = categoryData[index];
        if (category.name == "All") {
          return const SizedBox.shrink();
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ///display category title  section
            if (context
                .watch<FetchCategoriesCubit>()
                .state
                .filteredList!
                .isEmpty) ...[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomTextWidget(
                  title: category.name,
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ] else ...[
              const SizedBox(
                height: 30.0,
              ),
            ],

            ///display subcategories data section
            SizedBox(
              height: 200,
              child: ListView.builder(
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: context
                        .watch<FetchCategoriesCubit>()
                        .state
                        .filteredList!
                        .isNotEmpty
                    ? context
                        .watch<FetchCategoriesCubit>()
                        .state
                        .filteredList!
                        .length
                    : category.subcategories!.length,
                itemBuilder: (context, subIndex) {
                  if (context
                      .watch<FetchCategoriesCubit>()
                      .state
                      .filteredList!
                      .isEmpty) {
                    subcategory = category.subcategories![subIndex];
                  } else {
                    subcategory = context
                        .watch<FetchCategoriesCubit>()
                        .state
                        .filteredList![subIndex];
                  }
                  return InkWell(
                    onTap: () {
                      SubcategoryModel subcategoryModel;
                      if (context
                          .read<FetchCategoriesCubit>()
                          .state
                          .filteredList!
                          .isEmpty) {
                        subcategoryModel =
                            categoryData[index].subcategories![subIndex];
                      } else {
                        subcategoryModel = (context
                            .read<FetchCategoriesCubit>()
                            .state
                            .filteredList![subIndex]);
                      }

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailScreen(
                              subCategory: subcategoryModel,
                            ),
                          ));
                    },
                    child: Container(
                      margin: const EdgeInsets.only(right: 14.0),
                      decoration: BoxDecoration(
                          border: Border.all(
                            width: 2,
                            color: Colors.white30,
                          ),
                          borderRadius: const BorderRadius.all(
                              Radius.elliptical(12, 12))),
                      width: 180,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 10.0, top: 12.0, right: 10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 60,
                              width: 60,
                              decoration: const BoxDecoration(
                                  color: Colors.white10,
                                  borderRadius: BorderRadius.all(
                                      Radius.elliptical(20, 20))),
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Image.asset(
                                  HelperClass.fetchAssetsFromSubCategoryName(
                                      subcategory.name),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 4.0,
                            ),
                            CustomTextWidget(
                              title: subcategory.name,
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                            const SizedBox(
                              height: 6.0,
                            ),
                            Expanded(
                              child: Text(
                                subcategory.description,
                                textAlign: TextAlign.start,
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
