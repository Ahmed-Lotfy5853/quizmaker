part of 'requests_cubit.dart';

@immutable
sealed class RequestsState {}

final class RequestsInitial extends RequestsState {}
final class RequestsLoading extends RequestsState {}
final class RequestsSuccess extends RequestsState {}
final class RequestsError extends RequestsState {}