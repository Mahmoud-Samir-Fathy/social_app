import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/modules/social_pages/social_login/social_login_states.dart';

class SocialLoginCubit extends Cubit<SocialLoginStates>{

  SocialLoginCubit():super(SocialLoginInitialState());

  static SocialLoginCubit get(context)=> BlocProvider.of(context);


  bool isShown=false;
  IconData suffixIcon=Icons.visibility_off;

  void changeVisibility(){

    isShown=!isShown;
    suffixIcon=isShown?Icons.visibility:Icons.visibility_off;
    emit(SocialChangePasswordShown());
  }
  void userLogin({
    required String email,
    required String password,
}){
    emit(SocialLoginLoadingState());
    FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password).then((value) {
          print(value.user!.uid);
          print(value.user!.email);
          emit(SocialLoginSuccessState(value.user!.uid));
    }).catchError((error){
      print(error.toString());
      emit(SocialLoginErrorState(error.toString()));
    });
  }
}