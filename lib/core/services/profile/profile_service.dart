import 'dart:convert';

import 'package:minamitra_pembudidaya_mobile/core/injections/injection.dart';
import 'package:minamitra_pembudidaya_mobile/core/network/header_provider.dart';
import 'package:minamitra_pembudidaya_mobile/core/network/http_client.dart';
import 'package:minamitra_pembudidaya_mobile/core/repositories/meta_response.dart';
import 'package:minamitra_pembudidaya_mobile/core/services/profile/profile_endpoint.dart';
import 'package:minamitra_pembudidaya_mobile/feature/profile_member/repositories/profile_response.dart';
import 'package:minamitra_pembudidaya_mobile/feature/profile_member/repositories/update_profile_payload.dart';

abstract class ProfileService {
  Future<BaseResponse<ProfileResponse>> detailProfile();
  Future<BaseResponse<bool>> updateProfile(UpdateProfilePayload payload);
  Future<BaseResponse<bool>> updatePassword(
    String oldPassword,
    String newPassword,
  );
}

class ProfileServiceImpl implements ProfileService {
  final HttpClient httpClient;
  final HeaderProvider headerProvider;
  final ProfileEndpoint endpoint;

  ProfileServiceImpl({
    required this.httpClient,
    required this.headerProvider,
    required this.endpoint,
  });

  factory ProfileServiceImpl.create() {
    return ProfileServiceImpl(
      httpClient: Injection.httpClient,
      headerProvider: Injection.headerProvider,
      endpoint: ProfileEndpoint(),
    );
  }

  @override
  Future<BaseResponse<ProfileResponse>> detailProfile() async {
    final url = endpoint.detailProfile();
    final header = await headerProvider.headers;
    final response = await httpClient.get(url, header);
    final MetaResponse metaResponse = MetaResponse.fromJson(response.body);
    final ProfileResponse profileResponse =
        ProfileResponse.fromMap(metaResponse.result!);
    return BaseResponse(meta: metaResponse, data: profileResponse);
  }

  @override
  Future<BaseResponse<bool>> updateProfile(UpdateProfilePayload payload) async {
    final url = endpoint.updateProfile();
    final header = await headerProvider.headers;
    final response = await httpClient.post(
      url,
      header,
      payload.toJson(),
    );
    final MetaResponse metaResponse = MetaResponse.fromJson(response.body);
    return BaseResponse(meta: metaResponse, data: true);
  }

  @override
  Future<BaseResponse<bool>> updatePassword(
    String oldPassword,
    String newPassword,
  ) async {
    final url = endpoint.postUpdatePassword();
    final header = await headerProvider.headers;
    final repsonse = await httpClient.post(
      url,
      header,
      json.encode({
        "old_password": oldPassword,
        "new_password": newPassword,
      }),
    );
    final MetaResponse meta = MetaResponse.fromJson(repsonse.body);
    return BaseResponse(meta: meta, data: true);
  }
}
