part of 'fetch_categories_cubit.dart';

class FetchCategoriesState extends Equatable {
  final StateStatus? stateStatus;
  final StateStatus? filterStatus;
  final dynamic error;
  final List<CategoryModel>? categories;
  final List<SubcategoryModel>? filteredList;
  final int? currentIndex;

  const FetchCategoriesState({
    this.filterStatus,
    this.stateStatus = StateStatus.initial,
    this.categories = const [],
    this.error,
    this.currentIndex = 0,
    this.filteredList= const [],
  });

  @override
  List<Object> get props => [
        stateStatus ?? StateStatus.initial,
        filterStatus ?? StateStatus.initial,
        categories ?? [],
        filteredList ?? [],
        currentIndex!,
      ];

  FetchCategoriesState copyWith({
    StateStatus? stateStatus,
    StateStatus? filterStatus,
    dynamic? error,
    List<CategoryModel>? categories,
    List<SubcategoryModel>? filteredList,
    int? currentIndex,
  }) {
    return FetchCategoriesState(
      stateStatus: stateStatus ?? this.stateStatus,
      filterStatus: filterStatus ?? this.filterStatus,
      error: error ?? this.error,
      categories: categories ?? this.categories,
      filteredList: filteredList ?? this.filteredList,
      currentIndex: currentIndex ?? this.currentIndex,
    );
  }
}
