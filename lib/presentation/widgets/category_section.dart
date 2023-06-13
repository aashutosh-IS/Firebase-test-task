import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_app/presentation/fetch_categories/fetch_categories_cubit.dart';
import 'package:demo_app/presentation/widgets/basic_widgets/custom_text.dart';
import 'package:demo_app/presentation/widgets/basic_widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../model/category_model.dart';

class CategorySection extends StatefulWidget {
  const CategorySection({super.key});

  @override
  State<CategorySection> createState() => _CategorySectionState();
}

class _CategorySectionState extends State<CategorySection> {
  List<CategoryModel> get categoryData =>
      context.read<FetchCategoriesCubit>().state.categories ?? [];

  int newIndex = 0;
  setTagCurrentIndex(int index, String name) {
    setState(() {
      newIndex = index;
    });

    if (newIndex == 0) {
      context.read<FetchCategoriesCubit>().restListOrShowAll();
    } else {
      context.read<FetchCategoriesCubit>().filter(subcategoryName: name);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12.0, top: 12.0, bottom: 12.0),
      child: SizedBox(
        height: 50,
        width: MediaQuery.of(context).size.width,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: categoryData.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: InkWell(
                onTap: () async {
                  setTagCurrentIndex(index, categoryData[index].name);
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: newIndex == index
                          ? Colors.tealAccent
                          : Colors.white12,
                      borderRadius: BorderRadius.circular(32.0)),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Center(
                      child: CustomTextWidget(
                        title: categoryData[index].name,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500,
                        color: newIndex == index ? Colors.black : Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
