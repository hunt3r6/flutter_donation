import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_donation/resource/model/api_response.dart';
import 'package:flutter_donation/resource/model/campaign_model.dart';
import 'package:flutter_donation/resource/remote/home_remote_resource.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'campaign_state.dart';
part 'campaign_cubit.freezed.dart';

class CampaignCubit extends Cubit<CampaignState> {
  final HomeRemoteResource homeRemoteResource;
  CampaignCubit(this.homeRemoteResource) : super(CampaignState.initial());

  getCampaignsByCategory({String? slugCategory}) async {
    emit(CampaignState.loading());
    final result = await homeRemoteResource.getCampaignsByCategory(
      slugCategory ?? '',
    );
    result.fold(
      (error) => emit(CampaignState.error(error)),
      (campaigns) => emit(CampaignState.loaded(campaigns)),
    );
  }

  getCampaigns() async {
    emit(CampaignState.loading());
    final result = await homeRemoteResource.getCampaigns();
    result.fold(
      (error) => emit(CampaignState.error(error)),
      (campaigns) => emit(CampaignState.loaded(campaigns)),
    );
  }

  getDetailCampaign(String slug) async {
    emit(CampaignState.loading());
    final result = await homeRemoteResource.getDetailCampaign(slug);
    result.fold(
      (error) => emit(CampaignState.error(error)),
      (campaign) => emit(CampaignState.detailLoaded(campaign)),
    );
  }

  searchCampaigns(String query) async {
    emit(CampaignState.loading());
    final result = await homeRemoteResource.getCampaigns(query: query);
    result.fold(
      (error) => emit(CampaignState.error(error)),
      (campaigns) => emit(CampaignState.loaded(campaigns)),
    );
  }
}
