part of 'sliders_cubit.dart';

@freezed
class SlidersState with _$SlidersState {
  const factory SlidersState.initial() = SliderInitial;
  const factory SlidersState.loading() = SliderLoading;
  const factory SlidersState.loaded(List<SliderModel> sliders) = SliderLoaded;
  const factory SlidersState.error(String message) = SliderError;
}
