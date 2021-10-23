import 'dart:io';

import 'package:zurichat/models/organization_model.dart';
import 'package:zurichat/models/user_search_model.dart';

abstract class IOrganizationRepo {
  // THE SERVICE TO GET LIST OF ORGANIZATIONS
  Future<List<OrganizationModel>> fetchListOfOrganizations(token);

  // THE SERVICE TO GET LIST OF JOINED ORGANIZATIONS OF A USER
  Future<List<OrganizationModel>> getJoinedOrganizations(token, String email);

  // THE SERVICE TO GET THE INFORMATION OF AN ORGANIZATION
  Future fetchOrganizationInfo(String id, token);

  // THE SERVICE TO GET AN ORGANIZATION BY URL
  Future fetchOrganizationByUrl(String url, token);

  // THE SERVICE TO JOIN AN ORGANIZATION
  Future<bool> joinOrganization(String orgId, String email, token);

  // THE SERVICE TO CREATE AN ORGANIZATION
  Future<String> createOrganization(String email, token);

  /// THE SERVICE TO UPDATE AN ORGANIZATION URL
  /// THIS GIVES THE ORGANIZATION A PRIVILEDGE TO
  /// GET A CUSTOM LINK
  ///
  /// AS FAR AS IT IS AVAILABLE FOR USE
  Future updateOrgUrl(String orgId, String url, token);

  // THE SERVICE TO UPDATE AN ORGANIZATION NAME
  Future updateOrgName(String orgId, String name, token);

  // THE SERVICE TO UPDATE AN ORGANIZATION LOGO
  Future<bool> updateOrgLogo(String orgId, File image, token);

  // THE SERVICE TO ADD A MEMBERS TO AN ORGANIZATION
  Future addMemberToOrganization(String orgId, String email, token);

  // THE SERVICE TO FETCH MEMBERS IN AN ORGANIZATION
  Future<List<UserSearch>> fetchMembersInOrganization(String orgId, token);

  /// Invites a user to the organzization
  /// This endpoint would sent the user a mail with the UUID
  void inviteToOrganizationWithNormalMail(String orgId, List body, String token);
}
