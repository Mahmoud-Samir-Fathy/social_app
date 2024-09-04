import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/application_cubit.dart';
import 'package:social_app/application_state.dart';
import 'package:social_app/firebase_options.dart';

import 'package:social_app/layout/social_app/social_app.dart';
import 'package:social_app/layout/social_app/social_cubit.dart';
import 'package:social_app/modules/social_pages/social_login/social_login_screen.dart';
import 'package:social_app/shared/bloc_observer/bloc_observer.dart';
import 'package:social_app/shared/network/local/cashe_helper.dart';
import 'package:social_app/shared/network/remote/dio_helper.dart';
import 'package:social_app/shared/styles/themes.dart';

import 'shared/components/constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  String? token = await FirebaseMessaging.instance.getToken();
  print(token);

  Bloc.observer = MyBlocObserver();
  await DioHelper.init();
  await CacheHelper.init();
  bool? isDark=CacheHelper.getData(key:'isDark');
  //bool? onBoarding=CacheHelper.getData(key:'OnBoarding');
  //token=CacheHelper.getData(key: 'token')??null;
  //print(token);
  uId=CacheHelper.getData(key: 'uId');
  Widget widget;

  if(uId!=null){
    widget=SocialLayout();
  } else{
    widget=SocialLoginScreen();

  }
  runApp(Myapp(
    isDark: isDark,
    startWidget: widget,
  ));
}
class Myapp extends StatelessWidget{
  final bool? isDark;
  final Widget? startWidget;
  Myapp({this.isDark,this.startWidget});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context)=>SocialCubit()..getUserData()..getPostInfo(),),
        BlocProvider(create: (context)=>ApplicationCubit()..changeMode(fromShared: false))


      ],
      child: BlocConsumer<ApplicationCubit,ApplicationState>(
        listener: (BuildContext context,ApplicationState state){
        },
        builder:(
            BuildContext context,ApplicationState state){

          return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: lightMode,
              darkTheme:darkMode ,
              themeMode:ThemeMode.light,
              home:startWidget
          );
        } ,
      ),
    );
  }
}