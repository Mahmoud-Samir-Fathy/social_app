import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/layout/social_app/social_states.dart';
import 'package:social_app/models/social_model/social_message_model.dart';
import 'package:social_app/models/social_model/social_post_model.dart';
import 'package:social_app/models/social_model/social_user_model.dart';
import 'package:social_app/modules/social_pages/add_post/add_post.dart';
import 'package:social_app/modules/social_pages/feeds/feeds.dart';
import 'package:social_app/modules/social_pages/settings/settings.dart';
import 'package:social_app/modules/social_pages/users/users.dart';
import 'package:social_app/shared/components/constants.dart';

import '../../modules/social_pages/chat/chat.dart';

class SocialCubit extends Cubit<SocialStates> {
  SocialCubit() : super(SocialInitialState());
  static SocialCubit get(context) => BlocProvider.of(context);

  SocialUserModel? model;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void getUserData() {
    emit(SocialGetUserLoadingState());
    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
      print(value.data());
      model = SocialUserModel.fromJson(value.data()!);
      emit(SocialGetUserSuccessState());
    }).catchError((error) {
      emit(SocialGetUserErrorState(error.toString()));
    });
  }

  int currentIndex = 0;
  List<Widget> Screens = [
    feeds(),
    chat(),
    addPost(),
    users(),
    settings()
  ];

  List<String> tittles = [
    'Feeds',
    'Chat',
    'Add post',
    'Users',
    'Settings'
  ];

  void changeBottomNavBar(int index) {
    if(index ==1){
      getAllUsers();
    }
    if (index == 2) {
      emit(AddPostNavState());
    } else {
      currentIndex = index;
      emit(ChangeBottomNavBarIndex());
    }
  }

  File? profileImage;
  final ImagePicker picker = ImagePicker();
  Future getProfileImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      emit(GetProfileImagePickedSuccessState());
    } else {
      print('No image selected.');
      emit(GetProfileImagePickedErrorState());
    }
  }

  File? coverImage;
  Future getProfileCover() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      coverImage = File(pickedFile.path);
      emit(GetProfileCoverPickedSuccessState());
    } else {
      print('No image selected.');
      emit(GetProfileCoverPickedErrorState());
    }
  }

  void uploadProfileImage({
    required String name,
    required String bio,
    required String phone,
  }) {
    if (profileImage == null) return;

    emit(SocialUpdateLoadingState());

    FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        updateUser(
          phone: phone,
          name: name,
          bio: bio,
          image: value,
        );
        emit(UploadProfileImageSuccessState());
      }).catchError((error) {
        emit(UploadProfileImageErrorState());
      });
    }).catchError((error) {
      emit(UploadProfileImageErrorState());
    });
  }

  void uploadProfileCover({
    required String name,
    required String bio,
    required String phone,
  }) {
    if (coverImage == null) return;

    emit(SocialUpdateLoadingState());

    FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(coverImage!.path).pathSegments.last}')
        .putFile(coverImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        updateUser(
          name: name,
          phone: phone,
          bio: bio,
          cover: value,
        );
        emit(UploadProfileCoverSuccessState());
      }).catchError((error) {
        emit(UploadProfileCoverErrorState());
      });
    }).catchError((error) {
      emit(UploadProfileCoverErrorState());
    });
  }

  void updateUser({
    required String name,
    required String bio,
    required String phone,
    String? image,
    String? cover,
  }) {
    if (model == null) {
      emit(UpdateUserInfoErrorState());
      return;
    }

    SocialUserModel userModel = SocialUserModel(
      name: name,
      bio: bio,
      phone: phone,
      email: model!.email,
      uId: model!.uId,
      image: image ?? model!.image,
      cover: cover ?? model!.cover,
      isEmailVerified: false,
    );

    FirebaseFirestore.instance
        .collection('users')
        .doc(model!.uId)
        .update(userModel.toMap())
        .then((value) {
      getUserData();
    }).catchError((error) {
      emit(UpdateUserInfoErrorState());
    });
  }



  File? postImage;
  Future getPostImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      postImage = File(pickedFile.path);
      emit(GetPostImagePickedSuccessState());
    } else {
      print('No image selected.');
      emit(GetPostImagePickedErrorState());
    }
  }

  void removePostImage(){
    postImage=null;
    emit(RemovePostImageState());
  }


  void uploadPostImage({
    required String dateTime,
    required String text,
  }) {

    emit(SocialPostImageLoadingState());

    FirebaseStorage.instance
        .ref()
        .child('posts/${Uri.file(postImage!.path).pathSegments.last}')
        .putFile(postImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        addNewPost(
            dateTime: dateTime,
            text: text,
            postImage: value
        );
      }).catchError((error) {
        emit(UploadPostImageErrorState());
      });
    }).catchError((error) {
      emit(UploadPostImageErrorState());
    });
  }

  void addNewPost({
    required String text,
    required String dateTime,
    String? postImage,
  }) {
    emit(SocialPostImageLoadingState());
    PostModel postModel = PostModel(
      name: model!.name,
      text: text,
      profileImage: model!.image,
      dateTime: dateTime,
      uId: model!.uId,
      postImage: postImage ??'',
    );

    FirebaseFirestore.instance
        .collection('posts')
        .add(postModel.toMap())
        .then((value) {
          emit(CreatePostSuccessState());

    }).catchError((error) {
      emit(CreatePostErrorState());
    });
  }



 List<PostModel> posts=[];
  List<String> postId=[];
  List<int> likes=[];

  void getPostInfo(){
    emit(SocialGetPostLoadingState());
    FirebaseFirestore.
    instance.
    collection('posts').
    get().
    then((value) {
      value.docs.forEach((element) {
        element.
        reference.
        collection('likes').
        get().then((value) {
          likes.add(value.docs.length);
          postId.add(element.id);
          posts.add(PostModel.fromJson(element.data()));
        }).
        catchError((error){
          emit(SocialGetPostErrorState(error.toString()));
        });
      });
      emit(SocialGetPostSuccessState());
    }).catchError((error){
      emit(SocialGetPostErrorState(error.toString()));
    });
  }

  void likePost(String postId){
    FirebaseFirestore.
    instance.collection('posts').
    doc(postId).
    collection('likes').
    doc(model!.uId).
    set({'likes':true}).
    then((value) {
      emit(SocialLikesSuccessState());
    }).
    catchError((error){
      emit(SocialLikesErrorState(error.toString()));
    });
  }

  List<SocialUserModel> Users=[];
  void getAllUsers(){
    if(Users.length==0)
    FirebaseFirestore.
    instance.
    collection('users').
    get().
    then((value) {
      value.docs.forEach((element) {
        if(element.data()['uId']!=model!.uId)
        Users.add(SocialUserModel.fromJson(element.data()));
      });
      emit(SocialGetAllUserSuccessState());
    }).catchError((error){
      emit(SocialGetAllUserErrorState(error.toString()));
    });
  }


  void sendMessage({
    required String receiverId,
    required String text,
    required String time,
}){
    MessageModel messageModel=MessageModel(
      text: text,
      receiverId: receiverId,
      time: time,
      senderId: model!.uId,
    );
    FirebaseFirestore.instance.
    collection('users').
    doc(model!.uId).
    collection('chat').
    doc(receiverId).
    collection('messages').
    add(messageModel.toMap()).then((value) {
      emit(SendMessageSuccessState());
    }).catchError((error){
      emit(SendMessageErrorState());
    });
    FirebaseFirestore.instance.
    collection('users').
    doc(receiverId).
    collection('chat').
    doc(model!.uId).
    collection('messages').
    add(messageModel.toMap()).then((value) {
      emit(SendMessageSuccessState());
    }).catchError((error){
      emit(SendMessageErrorState());
    });
  }

  List<MessageModel> messages=[];
  void getMessage({
    required String receiverId
}){
    FirebaseFirestore.instance.
    collection('users').
    doc(model!.uId).
    collection('chat').
    doc(receiverId).
    collection('messages').
    orderBy('time').
    snapshots().
    listen((event) {
      messages=[];

      event.docs.forEach((element) {
        messages.add(MessageModel.fromJson(element.data()));
      });
      emit(GetMessageSuccessState());

    });
  }
}
