abstract class SocialStates{}
class SocialInitialState extends SocialStates{}
class SocialGetUserLoadingState extends SocialStates{}
class SocialGetUserSuccessState extends SocialStates{}
class SocialGetUserErrorState extends SocialStates{
  final String? error;

  SocialGetUserErrorState(this.error);
}


class SocialGetAllUserLoadingState extends SocialStates{}
class SocialGetAllUserSuccessState extends SocialStates{}
class SocialGetAllUserErrorState extends SocialStates{
  final String? error;

  SocialGetAllUserErrorState(this.error);
}



class SocialGetPostLoadingState extends SocialStates{}
class SocialGetPostSuccessState extends SocialStates{}
class SocialGetPostErrorState extends SocialStates{
  final String? error;

  SocialGetPostErrorState(this.error);
}


class SocialLikesSuccessState extends SocialStates{}
class SocialLikesErrorState extends SocialStates{
  final String? error;

  SocialLikesErrorState(this.error);
}




class ChangeBottomNavBarIndex extends SocialStates{}
class AddPostNavState extends SocialStates{}
class GetProfileImagePickedSuccessState extends SocialStates{}
class GetProfileImagePickedErrorState extends SocialStates{}

class GetProfileCoverPickedSuccessState extends SocialStates{}
class GetProfileCoverPickedErrorState extends SocialStates{}

class UploadProfileImageSuccessState extends SocialStates{}
class UploadProfileImageErrorState extends SocialStates{}

class UploadProfileCoverSuccessState extends SocialStates{}
class UploadProfileCoverErrorState extends SocialStates{}

class UpdateUserInfoErrorState extends SocialStates{}

class SocialUpdateLoadingState extends SocialStates{}



// for post

class GetPostImagePickedSuccessState extends SocialStates{}
class GetPostImagePickedErrorState extends SocialStates{}


class SocialPostImageLoadingState extends SocialStates{}
class UploadPostImageSuccessState extends SocialStates{}
class UploadPostImageErrorState extends SocialStates{}
class CreatePostSuccessState extends SocialStates{}

class CreatePostErrorState extends SocialStates{}

class RemovePostImageState extends SocialStates{}


// message
class SendMessageSuccessState extends SocialStates{}
class SendMessageErrorState extends SocialStates{}

class GetMessageSuccessState extends SocialStates{}
class GetMessageErrorState extends SocialStates{}


