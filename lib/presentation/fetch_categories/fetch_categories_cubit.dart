import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

import '../../const/enums.dart';
import '../../model/category_model.dart';

part 'fetch_categories_state.dart';

class FetchCategoriesCubit extends Cubit<FetchCategoriesState> {
  FetchCategoriesCubit() : super(const FetchCategoriesState());

  final CollectionReference categoriesCollection =
      FirebaseFirestore.instance.collection('categories');

  FutureOr<void> fetchData() async {
    try {
      emit(state.copyWith(stateStatus: StateStatus.loading));
      final QuerySnapshot snapshot = await categoriesCollection.get();
      final categories = snapshot.docs.map((doc) {
        final categoryData = doc.data() as Map<String, dynamic>;
        final categoryName = categoryData['name'] as String;
        final subcategoriesData =
            categoryData['subcategories'] as List<dynamic>;
        final subCategories = subcategoriesData.map((subcatData) {
          final subcatName = subcatData['name'] as String;
          final subcatDescription = subcatData['description'] as String;
          return SubcategoryModel(
              name: subcatName, description: subcatDescription);
        }).toList();
        return CategoryModel(name: categoryName, subcategories: subCategories);
      }).toList();
      emit(
        state.copyWith(
          stateStatus: StateStatus.success,
          categories: [
            CategoryModel(name: "All"),
            ...categories,
          ],
        ),
      );
    } catch (e) {
      emit(state.copyWith(
        error: e,
        stateStatus: StateStatus.failure,
      ));
    }
  }

  Future<void> filter({String? subcategoryName}) async {
    try {
      emit(state.copyWith(filterStatus: StateStatus.loading));

      final List<SubcategoryModel> flist = [];
      final stateList = List.of(state.categories!);
      for (var li in stateList) {
        if (li.name == subcategoryName!.trim()) {
          flist.addAll(li.subcategories!);
        }
      }
      emit(state.copyWith(
          filteredList: flist, filterStatus: StateStatus.success));
    } catch (e) {
      print("Error in cubit $e");
    }
  }

  void restListOrShowAll() {
    emit(state.copyWith(filteredList: []));
  }
}
