import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/models/social_model/social_user_model.dart';
import 'package:social_app/modules/social_pages/social_register/social_register_states.dart';


class SocialRegisterCubit extends Cubit<SocialRegisterStates>{

  SocialRegisterCubit():super(SocialRegisterInitialState());

  static SocialRegisterCubit get(context)=> BlocProvider.of(context);

  IconData suffixIcon=Icons.visibility_off;
  bool isPasswordShown=true;
  void changePasswordVisibility(){
    isPasswordShown=!isPasswordShown;
    suffixIcon=isPasswordShown?Icons.visibility_off:Icons.visibility;
    emit(SocialChangePassShown());
  }

  void userRegister({
    required String name,
    required String email,
    required String password,
    required String phone,
  }){
      emit(SocialRegisterLoadingState());
    FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password
    ).then((value) {
      print(value.user!.email);
      print(value.user!.uid);
      userCreate(
          name: name,
          email: email,
          phone: phone,
          uId: value.user!.uid);
    }).catchError((error){
      print(error.toString());
      emit(SocialRegisterErrorState(error.toString()));
    });
  }
  void userCreate({
    required String name,
    required String email,
    required String phone,
    required String uId,
  }){
    SocialUserModel model= SocialUserModel(
      name: name,
      phone: phone,
      email: email,
      uId: uId,
      bio:'Write your bio....',
      image: 'https://img.freepik.com/free-photo/traveler-asian-woman-spending-holiday-trip-ayutthaya-thailand_7861-3465.jpg?t=st=1717761281~exp=1717764881~hmac=a9d36cff46e88735633dd183e78f97592589030741ce57e97120d80a5976db86&w=1380',
      cover: 'https://img.freepik.com/free-photo/traveler-asian-woman-spending-holiday-trip-ayutthaya-thailand_7861-3457.jpg?t=st=1717761267~exp=1717764867~hmac=361a47970ff0f47bf283b9f36033b520da5d079e68f716330d1fe8a8003e1f0d&w=1380',
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(model.toMap()).then((value) {
          emit(SocialCreateUserSuccessState());
    }).catchError((error){
      emit(SocialCreateUserErrorState(error.toString()));
    });
  }
}