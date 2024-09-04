import 'dart:core';

class MessageModel {
  String? receiverId;
  String? senderId;
  String? time;
  String? text;

  MessageModel({
    this.receiverId,
    this.senderId,
    this.time,
    this.text,
  });

  MessageModel.fromJson(Map<String,dynamic> json){
    receiverId=json['receiverId'];
    senderId=json['senderId'];
    time=json['time'];
    text=json['text'];
  }

  Map<String,dynamic> toMap()
  { return {
    'receiverId':receiverId,
    'senderId':senderId,
    'time':time,
    'text':text,
  };
  }
}