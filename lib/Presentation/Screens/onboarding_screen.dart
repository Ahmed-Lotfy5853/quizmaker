import 'package:flutter/material.dart';
import 'package:quiz_maker/Constants/Strings.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoarding_Screen extends StatefulWidget {
  const OnBoarding_Screen({super.key});

  @override
  State<OnBoarding_Screen> createState() => _OnBoarding_ScreenState();
}

class _OnBoarding_ScreenState extends State<OnBoarding_Screen> {
  final PageController _controller = PageController();
  bool onLastPage = false;

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  late SharedPreferences _sharedPreferences;
  bool _isFirstTime = true;

  @override
  void initState() {
    super.initState();
    _initPrefs();
  }

  _initPrefs() async {
    _sharedPreferences = await _prefs;
    setState(() {
      _isFirstTime = _sharedPreferences.getBool('isFirstTime') ?? true;
      if (!_isFirstTime && current_user!.uid == '') {
        Navigator.pushNamed(context, registerScreen);
      }
      if (current_user!.uid != '') {
        current_user!.isTeacher ? Navigator.pushReplacementNamed(
          context,
          teacherNavBar,
        ): Navigator.pushReplacementNamed(
          context,
          bottomNavStudentScreen,
        );
      }
    });
  }

  setFirstTime() {
    _sharedPreferences.setBool('isFirstTime', false);
  }

  @override
  Widget build(BuildContext context) {
    double fSize = MediaQuery.textScalerOf(context).scale(20);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          PageView(
            controller: _controller,
            onPageChanged: (index) {
              setState(() {
                onLastPage = (index == 2);
              });
            },
            children: [
              buildOnBoardingScreen(
                  "assets/images/onboard.png",
                  "Welcome",
                  "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy",
                  height,
                  width),
              buildOnBoardingScreen(
                  "assets/images/onboard.png",
                  "Screen Number 2",
                  "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy",
                  height,
                  width),
              buildOnBoardingScreen(
                  "assets/images/onboard.png",
                  "Let`s get started",
                  "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy",
                  height,
                  width),
            ],
          ),
          Container(
            alignment: const Alignment(0, 0.90),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  child: Text(
                    "Skip",
                    style: TextStyle(fontSize: fSize),
                  ),
                  onTap: () {
                    _controller.jumpToPage(2);
                  },
                ),
                SmoothPageIndicator(
                    controller: _controller,
                    count: 3,
                    effect: const ExpandingDotsEffect(
                      dotColor: Color(0xFFF7EEDD),
                      activeDotColor: Colors.blue,
                    )),
                onLastPage
                    ? GestureDetector(
                        onTap: () {
                          setFirstTime();
                          Navigator.pushNamed(context, registerScreen);
                        },
                        child: Text(
                          "Done",
                          style: TextStyle(fontSize: fSize),
                        ))
                    : GestureDetector(
                        onTap: () {
                          _controller.nextPage(
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeInSine);
                        },
                        child: Text(
                          "Next",
                          style: TextStyle(fontSize: fSize),
                        ),
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildOnBoardingScreen(
      String img, String title, String text, double h, double w) {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Container(
        height: h / 2.75,
        width: w / 1.5,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(img),
            fit: BoxFit.contain,
          ),
        ),
      ),
      Center(
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: w / 11,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      const SizedBox(
        height: 30,
      ),
      Padding(
        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
        child: Center(
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: w/19.5,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    ]);
  }
}
