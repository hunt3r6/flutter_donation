part of 'category_cubit.dart';

@freezed
class CategoryState with _$CategoryState {
  const factory CategoryState.initial() = CategoryInitial;
  const factory CategoryState.loading() = CategoryLoading;
  const factory CategoryState.loaded(List<CategoryModel> categories) =
      CategoryLoaded;
  const factory CategoryState.error(String message) = CategoryError;
}
