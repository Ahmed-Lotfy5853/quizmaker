part of 'questions_bank_cubit.dart';

@immutable
sealed class QuestionsBankState {}

final class QuestionsBankInitial extends QuestionsBankState {}

final class QuestionsBankLoading extends QuestionsBankState {}

final class QuestionsBankLoaded extends QuestionsBankState {}

final class QuestionsBankError extends QuestionsBankState {}
