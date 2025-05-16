import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_donation/resource/model/slider_model.dart';
import 'package:flutter_donation/resource/remote/home_remote_resource.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'sliders_state.dart';
part 'sliders_cubit.freezed.dart';

class SlidersCubit extends Cubit<SlidersState> {
  final HomeRemoteResource homeRemoteResource;
  SlidersCubit(this.homeRemoteResource) : super(SlidersState.initial());

  getSliders() async {
    emit(SlidersState.loading());
    final result = await homeRemoteResource.getSliders();
    result.fold(
      (error) => emit(SlidersState.error(error)),
      (sliders) => emit(SlidersState.loaded(sliders)),
    );
  }
}
