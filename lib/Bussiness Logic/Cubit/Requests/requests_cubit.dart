import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../Data/Models/requests.dart';
import '../../../Data/Repository/Request/requests_repository.dart';

part 'requests_state.dart';

class RequestsCubit extends Cubit<RequestsState> {
  final RequestsRepository requestsRepository;
  RequestsCubit(this.requestsRepository) : super(RequestsInitial());

  createRequest(List<String> teachersId, Request request) {
    emit(RequestsLoading());
    requestsRepository.createRequest(teachersId, request);
    emit(RequestsInitial());
  }

  Future<List<Request>> getTeacherRequests(String teacherId) async {
    emit(RequestsLoading());
    return requestsRepository.getTeacherRequests(teacherId).then((value) {
      emit(RequestsSuccess());
      return value;
    }).onError((error, stackTrace) {
      emit(RequestsError());
      return [];
    });

  }
  Future<List<Request>> getStudentRequests(String teacherId) async {
    emit(RequestsLoading());
    return requestsRepository.getStudentRequests(teacherId).then((value) {
      emit(RequestsSuccess());
      return value;
    }).onError((error, stackTrace) {
      emit(RequestsError());
      return [];
    });

  }

  Future<void> deleteRequest(String teacherId, String requestId , bool isTeacher) async {
    emit(RequestsLoading());
    requestsRepository.deleteRequest(teacherId, requestId , isTeacher);
    emit(RequestsInitial());
  }

  Future<void> acceptRequest(String teacherId, String requestId , bool isTeacher) async {
    emit(RequestsLoading());
    requestsRepository.acceptRequest(teacherId, requestId , isTeacher).then((value) {
      emit(RequestsSuccess());
    }).onError((error, stackTrace) {
      emit(RequestsError());
    });
  }

}
