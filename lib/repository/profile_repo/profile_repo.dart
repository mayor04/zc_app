import 'package:zurichat/app/app.locator.dart';
import 'package:zurichat/repository/repo_mixin.dart';
import 'package:zurichat/services/app_services/local_storage_services.dart';
import 'package:zurichat/services/core_services/api_service.dart';
import 'package:zurichat/app/app.logger.dart';
import 'package:zurichat/ui/shared/shared.dart';
import 'package:zurichat/utilities/constants/storage_keys.dart';
import 'package:zurichat/utilities/failures.dart';

import 'i_profile_repo.dart';

class ProfileRepo extends IProfileRepo with RepoMixin {
  final ApiService _service = ApiService(coreBaseUrl);
  final _log = getLogger('Profile Repo');

  @override
  Future<Map> fetchStatus() async {
    try {
      return {};
    } on Failure catch (e) {
      _log.w(e.toString());
      rethrow;
    } catch (e) {
      _log.w(e.toString());
      throw UnknownFailure(errorMessage: e.toString());
    }
  }

  @override
  Future<bool> getUserPresence() async {
    try {
      return true;
    } on Failure catch (e) {
      _log.w(e.toString());
      rethrow;
    } catch (e) {
      _log.w(e.toString());
      throw UnknownFailure(errorMessage: e.toString());
    }
  }

  @override
  Future<bool> setStatus(
      String tagIcon, String statusText, String expiryTime) async {
    try {
      return true;
    } on Failure catch (e) {
      _log.w(e.toString());
      rethrow;
    } catch (e) {
      _log.w(e.toString());
      throw UnknownFailure(errorMessage: e.toString());
    }
  }

  @override
  Future<bool> setUserPresence() async {
    try {
      return true;
    } on Failure catch (e) {
      _log.w(e.toString());
      rethrow;
    } catch (e) {
      _log.w(e.toString());
      throw UnknownFailure(errorMessage: e.toString());
    }
  }
}
