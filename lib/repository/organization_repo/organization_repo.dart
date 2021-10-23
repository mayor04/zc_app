import 'dart:io';

import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:zurichat/models/organization_model.dart';
import 'package:zurichat/models/user_search_model.dart';
import 'package:zurichat/services/core_services/api_service.dart';
import 'package:zurichat/utilities/constants/app_constants.dart';
import 'package:zurichat/app/app.logger.dart';
import 'package:zurichat/utilities/failures.dart';

import 'i_organization_repo.dart';

class OrganizationRepo extends IOrganizationRepo {
  final ApiService _service = ApiService();
  final log = getLogger('OrganizationRepo');

  /// Fetches a list of organizations that exist in the Zuri database
  /// This does not fetch the Organization the user belongs to
  /// To implement that use `getJoinedOrganizations()`
  @override
  Future<List<OrganizationModel>> fetchListOfOrganizations(token) async {
    try {
      final res = await _service.get(
        '$apiBaseUrl/organizations',
        headers: {'Authorization': 'Bearer $token'},
      );
      log.i(res);
      return (res?['data'] as List)
          .map((e) => OrganizationModel.fromJson(e))
          .toList();
    } on Failure catch (e) {
      log.w(e.toString());
      rethrow;
    } catch (e) {
      log.w(e.toString());
      throw UnknownFailure(errorMessage: e.toString());
    }
  }

  ///Get the list of Organization the user has joined
  @override
  Future<List<OrganizationModel>> getJoinedOrganizations(
      token, String email) async {
    try {
      final res = await _service.get(
        '$channelsBaseUrl/users/$email/organizations',
        headers: {'Authorization': 'Bearer $token'},
      );
      log.i("RESPONSE !!$res");
      return (res?['data'] as List)
          .map((e) => OrganizationModel.fromJson(e))
          .toList();
    } on Failure catch (e) {
      log.w(e.toString());
      rethrow;
    } catch (e) {
      log.w(e.toString());
      throw UnknownFailure(errorMessage: e.toString());
    }
  }

  /// Fetches information on a particular Organization. It takes a parameter
  /// `id` which is the id of the organization
  @override
  Future fetchOrganizationInfo(String id, token) async {
    try {
      final res = await _service.get(
        '$channelsBaseUrl/organizations/$id',
        headers: {'Authorization': 'Bearer $token'},
      );
      log.i(res);
      return OrganizationModel.fromJson(res?['data']);
    } on Failure catch (e) {
      log.w(e.toString());
      rethrow;
    } catch (e) {
      log.w(e.toString());
      throw UnknownFailure(errorMessage: e.toString());
    }
  }

  /// takes in a `url` and returns a Organization that matches the url
  /// use this url for testing `Zurichat-fsp1856.Zurichat.com`
  @override
  Future fetchOrganizationByUrl(String url, token) async {
    try {
      final res = await _service.get('/organizations/url/$url',
          headers: {'Authorization': 'Bearer $token'});
      log.i(res);
      return OrganizationModel.fromJson(res['data']);
    } on Failure catch (e) {
      log.w(e.toString());
      rethrow;
    } catch (e) {
      log.w(e.toString());
      throw UnknownFailure(errorMessage: e.toString());
    }
  }

  ///Limited to the admin who created the org
  ///
  ///This should be used to add users to an organization by the admin user alone
  /// takes in a `Organization id` and joins the Organization
  @override
  Future<bool> joinOrganization(String orgId, String email, token) async {
    final res = await _service.post(
      '$channelsBaseUrl/organizations/$orgId/members',
      body: {'user_email': email},
      headers: {'Authorization': 'Bearer $token'},
    );
    if (res.statusCode == 200) {
      return true;
    }
    return false;
  }

  /// This method creates an organization. Creator email `email` must be present
  @override
  Future<String> createOrganization(String email, token) async {
    try {
      final res = await _service.post('$channelsBaseUrl/organizations',
          headers: {'Authorization': 'Bearer $token'},
          body: {'creator_email': email});
      return res['data']['InsertedID'];
    } on Failure catch (e) {
      log.w(e.toString());
      rethrow;
    } catch (e) {
      log.w(e.toString());
      throw UnknownFailure(errorMessage: e.toString());
    }
  }

  /// Updates an organization's URL. The organization's id `orgId` must not be
  /// null or empty. Url must not begin with `https` or `http`

  @override
  Future updateOrgUrl(String orgId, String url, token) async {
    try {
      final res = await _service.patch(
        '${coreBaseUrl}organizations/$orgId/url',
        headers: {'Authorization': 'Bearer $token'},
        body: {'url': url},
      );
      return res['message'];
    } on Failure catch (e) {
      log.w(e.toString());
      rethrow;
    } catch (e) {
      log.w(e.toString());
      throw UnknownFailure(errorMessage: e.toString());
    }
  }

  /// Updates an organization's name. The organization's id `orgId` must not be
  /// null or empty
  @override
  Future updateOrgName(String orgId, String name, token) async {
    try {
      final res = await _service.patch(
        '${coreBaseUrl}organizations/$orgId/name',
        headers: {'Authorization': 'Bearer $token'},
        body: {'organization_name': name},
      );
      return res['message'];
    } on Failure catch (e) {
      log.w(e.toString());
      rethrow;
    } catch (e) {
      log.w(e.toString());
      throw UnknownFailure(errorMessage: e.toString());
    }
  }

  /// Updates an organization's logo. The organization's id `orgId` must not be
  /// null or empty
  @override
  Future<bool> updateOrgLogo(String orgId, File image, token) async {
    try {
      var formData = FormData.fromMap({
        'height': 300,
        'width': 300,
        "image": await MultipartFile.fromFile(
          image.path,
          filename: image.path.split(Platform.pathSeparator).last,
          contentType: MediaType('image', 'jpeg'),
        ),
      });
      await _service.patch(
        '${coreBaseUrl}organizations/$orgId/logo',
        headers: {'Authorization': 'Bearer $token'},
        body: formData,
      );
      return true;
    } on Failure catch (e) {
      log.w(e.toString());
      rethrow;
    } catch (e) {
      log.w(e.toString());
      throw UnknownFailure(errorMessage: e.toString());
    }
  }

  /// Add members to an organization either through invite
  /// or by calls
  @override
  Future addMemberToOrganization(String orgId, String email, token) async {
    try {
      final res = await _service.post(
        '$channelsBaseUrl/organizations/$orgId/members',
        headers: {'Authorization': 'Bearer $token'},
        body: {'user_email': email},
      );
      return res['message'];
    } on Failure catch (e) {
      log.w(e.toString());
      rethrow;
    } catch (e) {
      log.w(e.toString());
      throw UnknownFailure(errorMessage: e.toString());
    }
  }

  /// FETCHING MEMBERS

  @override
  Future<List<UserSearch>> fetchMembersInOrganization(
      String orgId, token) async {
    try {
      final res = await _service.get(
        '$channelsBaseUrl/organizations/$orgId/members',
        headers: {'Authorization': 'Bearer $token'},
      );
      return (res['data'] as List).map((e) => UserSearch.fromJson(e)).toList();
    } on Failure catch (e) {
      log.w(e.toString());
      rethrow;
    } catch (e) {
      log.w(e.toString());
      throw UnknownFailure(errorMessage: e.toString());
    }
  }

  @override
  Future<void> inviteToOrganizationWithNormalMail(
      String orgId, List body, String token) async {
    try {
      final data = {"emails": body};
      final res = await _service.post(
        'organizations/$orgId/send-invite',
        body: data,
        headers: {'Authorization': 'Bearer $token'},
      );
      log.i(res);
    } on Failure catch (e) {
      log.w(e.toString());
      rethrow;
    } catch (e) {
      log.w(e.toString());
      throw UnknownFailure(errorMessage: e.toString());
    }
  }
}
