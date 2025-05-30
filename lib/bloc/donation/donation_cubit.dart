import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_donation/resource/model/donation_model.dart';
import 'package:flutter_donation/resource/remote/donation_remote_resource.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'donation_state.dart';
part 'donation_cubit.freezed.dart';

class DonationCubit extends Cubit<DonationState> {
  final DonationRemoteResource donationRemoteResource;
  DonationCubit(this.donationRemoteResource) : super(DonationState.initial());
  int _currentPage = 1;
  bool _isFetching = false;
  bool _hasMore = true;
  List<DonationModel> donations = [];

  void fetchDonations({bool isRefresh = false}) async {
    if (_isFetching || (!_hasMore && !isRefresh)) return;

    _isFetching = true;

    if (isRefresh) {
      _currentPage = 1;
      donations.clear();
      emit(DonationState.loading());
    }

    try {
      final result = await donationRemoteResource.fecthDonations(
        page: _currentPage,
      );
      result.fold((error) => emit(DonationState.error(error)), (paging) async {
        donations.addAll(paging.data as List<DonationModel>);
        _hasMore = paging.nextPageUrl != null;
        _currentPage++;
        _isFetching = false;
        emit(DonationState.loaded(List.from(donations), hasMore: _hasMore));
      });
    } catch (e) {
      emit(DonationState.error('Failed to fetch donations $e'));
    }
  }
}
