import 'package:quiz_maker/Data/Web%20Services/Requests/requests_webservices.dart';

import '../../Models/requests.dart';

class RequestsRepository {
  final RequestsWebServices webServices;

  RequestsRepository(this.webServices);

  Future<void> createRequest(List<String> teachersId, Request request) async {
    await webServices.createRequest(teachersId, request);
  }

  /*
  Future<List<Request>> getStudentRequests(String teacherId) async {
    return await webServices.getStudentRequests(teacherId);
  }
  Future<List<Request>> getTeacherRequests(String teacherId) async {
    return await webServices.getTeacherRequests(teacherId);
  }


   */
  Future<void> deleteRequest(
      String teacherId, String requestId, bool isTeacher) async {
    await webServices.deleteRequest(teacherId, requestId, isTeacher);
  }

  Future<void> acceptRequest(
      String teacherId, String requestId, bool isTeacher) async {
    await webServices.acceptRequest(teacherId, requestId, isTeacher);
  }
}
