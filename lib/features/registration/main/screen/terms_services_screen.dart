import 'package:Nahvino/core/Utils/Text/Text.dart';
import 'package:flutter/material.dart';

class TermsservicesScreen extends StatelessWidget {
  const TermsservicesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan.shade800,
        title: Callout(text: "قوانین و مقررات اپلیکیشن نحوینو"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Callout(
                color: Colors.black,
                textAlign: TextAlign.right,
                text:
                    "تیم توسعه دهندهٔ نحوینو همواره به سبب هدف اساسی و اولیهٔ خود در خصوص ایجاد محیطی امن، همهٔ گروه ها و کانال های عمومی ایجاد شده را از منظر محتوا و موضوع مورد بررسی قرار می دهد و با مواردی از قبیل زیر ممانعت به عمل خواهد آورد:\n• ایجاد گروه ها و یا کانال هایی با موضوعات و محتوای مبتذل و مستهجن\n• ایجاد گروه ها و یا کانال هایی با موضوعات و محتوایی خلاف موازین شرعی و یا با هدف توهین و اهانت به مذاهب و ادیان الهی\n• تبادل هر گونه پیامی با محتوای مربوط به پورنوگرافی کودکان\n• ایجاد گروه ها و یا کانال هایی با موضوعات سیاسی و مغایر با سیاست های داخلی ایرانتمامی کاربران پس از مطالعهٔ شرایط و ضوابط کامل برنامه و موافقت با قوانین موظفند به همهٔ مقررات پایبند بوده تا بتوانند از برنامه و خدمات مطلوب آن استفاده کنند.\n همچنین تیم نحوینو به عنوان سازندهٔ این پیام رسان موظف است تمامی خدمات مذکور را بدون کم و کاست به کاربران ارائه دهد و در صورت مشاهدهٔ هر گونه گزارش تخلف در باب موضوعات و محتوای پیام ها و صفحات ایجاد شده در برنامه با آنها برخورد کند.لازم به ذکر است؛  تیم نحوینو  در هر زمان میتواند شرایط و قوانین برنامه را تغییر دهد و تمامی کاربران ملزم به رعایت قوانین و مقررات میباشند پس برای اطمینان خاطر هر از چند گاهی قوانین را مجدداً مطالعه کنید."),
          ),
        ),
      ),
    );
  }
}