
import 'package:quiz_maker/Data/Models/user.dart';

const String onBoardingScreen = "/";
const String registerScreen = "/register";
const String teacherNavBar = "/teacherNavBar";
const String createGroupScreen = "/createGroupScreen";
const String editGroupDetailsScreen = "/groupDetailsScreen";
const String bottomNavStudentScreen='/BottomNavStudentScreen';
const String groupDetailsViewScreen = "/groupDetailsViewScreen";
const String addTeachertoGroup = "/addTeachertoGroup";
const String questionsBankScreen = "/questionsBankScreen";
const String createQuizScreen = "/createQuizScreen";
const String quizeScreen ='/quizeScreen';
const String addQuestions = "/add_question";

const String teacherHome = "/teacherHome";

const String studentGroupDetailSfvfcreen = "/studentGroupDetailScreen";

const String teacherGroupDetailScreen = "/teacherGroupDetailScreen";
const String teacherProfileScreen = "/teacherProfileScreen";

const String teachersCollection = "Teachers";
const String studentsCollection = "Students";
const String groupsCollection = "Groups";

const String studentRequestsCollection = "Requests";
const String teacherRequestsCollection = "TeacherRequests";
const String questionsCollection = "Questions";
const String examsCollection = "Exams";

const String postsCollection = "Posts";
const String quizCollection = "Quiz";

const String commentsCollection = "Comments";


const String onboardAsset = "assets/images/onboard.png";
const String backgroundAsset = "assets/images/background.jpg";
const String profileAsset ='assets/images/profile_place_holder.png';
const String groupAsset ='assets/images/group2.png';

UserModel? current_user = UserModel(uid: '', name: '', email: '', isTeacher: false, photoUrl: '');

class MyAssets {
  static const String baseUri = "assets/images/";
  static const String backgroundAsset = baseUri+"background.jpg";
  static const String profileAsset = baseUri+"profile_place_holder.png";
  static const String loginImage = baseUri+"quizregister.png";
}