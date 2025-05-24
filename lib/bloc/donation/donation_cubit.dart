import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_donation/resource/model/donation_model.dart';
import 'package:flutter_donation/resource/remote/donation_remote_resource.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'donation_state.dart';
part 'donation_cubit.freezed.dart';

class DonationCubit extends Cubit<DonationState> {
  final DonationRemoteResource donationRemoteResource;
  DonationCubit(this.donationRemoteResource) : super(DonationState.initial());

  fetchDonations() async {
    emit(DonationState.loading());
    try {
      final result = await donationRemoteResource.fecthDonations();
      result.fold(
        (error) => emit(DonationState.error(error)),
        (donations) => emit(DonationState.loaded(donations)),
      );
    } catch (e) {
      emit(DonationState.error('Failed to fetch donations $e'));
    }
  }
}
