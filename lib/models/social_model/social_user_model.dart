class SocialUserModel{
  String? name;
  String? phone;
  String? email;
  String? uId;
  bool? isEmailVerified;
  String? bio;
  String? image;
  String? cover;

  SocialUserModel({
   this.name,
    this.phone,
    this.email,
    this.uId,
    this.isEmailVerified,
    this.bio,
    this.image,
    this.cover
});

  SocialUserModel.fromJson(Map<String,dynamic>json){
    name=json['name'];
    phone=json['phone'];
    email=json['email'];
    uId=json['uId'];
    isEmailVerified=json['isEmailVerified'];
    bio=json['bio'];
    image=json['image'];
    cover=json['cover'];
  }

  Map<String,dynamic> toMap(){
   return {
     'name':name,
     'phone':phone,
     'email':email,
     'uId':uId,
     'isEmailVerified':isEmailVerified,
     'bio':bio,
     'image':image,
     'cover':cover,
   };
  }
}