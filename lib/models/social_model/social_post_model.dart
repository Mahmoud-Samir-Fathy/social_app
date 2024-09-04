import 'dart:core';

class PostModel {
  String? name;
  String? text;
  String? postImage;
  String? profileImage;
  String? dateTime;
  String? uId;

  PostModel({
    this.name,
    this.text,
    this.postImage,
    this.profileImage,
    this.dateTime,
    this.uId,
  });

  PostModel.fromJson(Map<String,dynamic> json){
    name=json['name'];
    text=json['text'];
    postImage=json['postImage'];
    profileImage=json['profileImage'];
    dateTime=json['dateTime'];
    uId=json['uId'];

  }

  Map<String,dynamic> toMap()
  { return {
    'name':name,
    'text':text,
    'postImage':postImage,
    'profileImage':profileImage,
    'dateTime':dateTime,
    'uId':uId,
  };
  }
}