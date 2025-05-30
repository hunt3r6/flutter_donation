import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_donation/resource/model/api_response.dart';
import 'package:flutter_donation/resource/model/campaign_model.dart';
import 'package:flutter_donation/resource/remote/home_remote_resource.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'campaign_state.dart';
part 'campaign_cubit.freezed.dart';

class CampaignCubit extends Cubit<CampaignState> {
  final HomeRemoteResource homeRemoteResource;
  int _currentPage = 1;
  bool _isFetching = false;
  bool _hasMore = true;
  List<CampaignModel> campaigns = [];

  CampaignCubit(this.homeRemoteResource) : super(CampaignState.initial());

  getCampaignsByCategory({String? slugCategory}) async {
    emit(CampaignState.loading());
    final result = await homeRemoteResource.getCampaignsByCategory(
      slugCategory ?? '',
    );
    result.fold(
      (error) => emit(CampaignState.error(error)),
      (campaigns) => emit(CampaignState.loaded(campaigns, hasMore: _hasMore)),
    );
  }

  void getCampaigns({bool isRefresh = false}) async {
    if (_isFetching || (!_hasMore && !isRefresh)) return;

    _isFetching = true;

    if (isRefresh) {
      _currentPage = 1;
      campaigns.clear();
      emit(CampaignState.loading());
    }

    final result = await homeRemoteResource.getCampaigns(page: _currentPage);
    result.fold((error) => emit(CampaignState.error(error)), (paging) {
      campaigns.addAll(paging.data as List<CampaignModel>);
      _hasMore = paging.nextPageUrl != null;
      _currentPage++;
      _isFetching = false;
      emit(CampaignState.loaded(List.from(campaigns), hasMore: _hasMore));
    });
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
    result.fold((error) => emit(CampaignState.error(error)), (paging) {
      campaigns = paging.data as List<CampaignModel>;
      emit(CampaignState.loaded(campaigns, hasMore: false));
    });
  }
}
