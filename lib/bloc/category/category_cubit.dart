import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_donation/resource/model/category_model.dart';
import 'package:flutter_donation/resource/remote/home_remote_resource.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'category_state.dart';
part 'category_cubit.freezed.dart';

class CategoryCubit extends Cubit<CategoryState> {
  final HomeRemoteResource homeRemoteResource;
  CategoryCubit(this.homeRemoteResource) : super(CategoryState.initial());

  getCategories() async {
    emit(CategoryState.loading());
    final result = await homeRemoteResource.getCategories();
    result.fold(
      (error) => emit(CategoryState.error(error)),
      (categories) => emit(CategoryState.loaded(categories)),
    );
  }
}
