import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../Data/Models/exam_model.dart';
import '../../../Data/Models/question.dart';
import '../../../Data/Repository/Questions Bank/questions_bank_repo.dart';

part 'questions_bank_state.dart';

class QuestionsBankCubit extends Cubit<QuestionsBankState> {
  QuestionsBankCubit(this.questionBankRepository) : super(QuestionsBankInitial());

  final QuestionsBankRepository questionBankRepository;

  Future<void> createQuestion(String groupId , Question question) async {
    emit(QuestionsBankLoading());
    try {
      await questionBankRepository.createQuestion(groupId, question);
      emit(QuestionsBankLoaded());
    } catch (e) {
      emit(QuestionsBankError());
    }
  }

  Future<void> deleteQuestion(String groupId , String questionId) async {
    emit(QuestionsBankLoading());
    try {
      await questionBankRepository.deleteQuestion(groupId, questionId);
      emit(QuestionsBankLoaded());
    } catch (e) {
      emit(QuestionsBankError());
    }
  }

  Future<void> createExam(String groupId , ExamModel examModel) async {
    emit(QuestionsBankLoading());
    try {
      await questionBankRepository.createExam(groupId, examModel);
    } catch (e) {

    }
  }
}
