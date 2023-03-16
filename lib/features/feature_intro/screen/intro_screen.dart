import 'package:Nahvino/config/generated/assets.dart';
import 'package:Nahvino/core/Utils/Text/Text.dart';
import 'package:Nahvino/features/feature_auth/main/screen/registration.dart';
import 'package:Nahvino/features/feature_intro/controllers/into_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intro_views_flutter/intro_views_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IntroScreen extends StatelessWidget {
  IntroScreen({Key? key}) : super(key: key);

   IntroController intro_controller = Get.put(IntroController());
  SharedPreferences? save_intro;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Builder(
      builder: (context) => IntroViewsFlutter(
        [
          PageViewModel(
            bubbleBackgroundColor: Color.fromRGBO(137, 215, 251, 1),
            pageBackground: SizedBox(
                width: 2000,
                child: Image.asset(Assets.into_back_img1, fit: BoxFit.cover)),
            body: Directionality(
              textDirection: TextDirection.rtl,
              child: Subhead(
                text:
                    "یه سرزمین با قبایلی از آدم ها!\nآدم هایی که اومدن تا به هم کمک کنن!\nکمک برای زندگی بهتر!\nاینجا یه محیط برای تعالی و رشد دسته جمعی و گروهیه!",
              ),
            ),
            title: Padding(
              padding: EdgeInsets.only(top: height * 0.05),
              child: Title2(
                text: "اینجا کجاست؟",
              ),
            ),
          ),
          PageViewModel(
            bubbleBackgroundColor: Color.fromRGBO(203, 228, 173, 1),
            pageBackground: SizedBox(
                width: 2000,
                child: Image.asset(Assets.into_back_img3, fit: BoxFit.cover)),
            body: Directionality(
              textDirection: TextDirection.rtl,
              child: Subhead(
                text:
                    "باید تا میتونی شاهپر جمع کنی!\nروش به دست اوردن شاهپر سر زدن به قبیله و کمک کردن به دوستان و فعالیت مداومه!\nهفت وادی تعالی در این سرزمین وجود داره که مسیر زیبا\nو پر فراز و نشیبش از دل حمایت و کمک به هم قبیله ای ها\nمیگذره!",
              ),
            ),
            title: Padding(
              padding: EdgeInsets.only(top: height * 0.05),
              child: Title2(
                text: "قاعده و قانون خاصی داره؟",
              ),
            ),
          ),
          PageViewModel(
            bubbleBackgroundColor: Color.fromRGBO(247, 163, 187, 1),
            pageBackground: SizedBox(
                width: 2000,
                child: Image.asset(Assets.into_back_img3, fit: BoxFit.cover)),
            body: Directionality(
              textDirection: TextDirection.rtl,
              child: Subhead(
                text:
                    "رشد شخصی به شیوه گروهی!\nدر این سرزمین هر کاربر به صورت نمادین یک ققنوسه!\nققنوسی که عادت های بد گذشته رو سوزونده و از خاکستر\nاین عادات ، جوون و شاداب دوباره متولد شده!\nاگر مراقب ققنوس خودتون نباشید ممکنه مریض بشه!\nهم قبیله ای ها ققنوس شما رو میبینن! پس با ملاقات هرروزه\nققنوس، اون رو شاداب و سلامت نگه دارید!",
              ),
            ),
            title: Padding(
              padding: EdgeInsets.only(top: height * 0.05),
              child: Title2(
                text: "هدف چیه؟",
              ),
            ),
          ),
        ],
        showNextButton: true,
        showBackButton: true,
        onTapDoneButton: () async {
            intro_controller.saveintro();

        },
        nextText: Subhead(
          text: "بعدی",
        ),
        backText: Subhead(
          text: "قبلی",
        ),
        doneText: Subhead(
          text: "بزن بریم",
        ),
        skipText: Subhead(
          text: "رد کردن",
        ),
        pageButtonTextStyles: const TextStyle(
          color: Colors.white,
          fontSize: 18.0,
        ),
      ),
    );
  }
}
