import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/social_app/social_cubit.dart';
import 'package:social_app/layout/social_app/social_states.dart';
import 'package:social_app/shared/components/components.dart';

class editUserProfile extends StatelessWidget {
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var bioController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = SocialCubit.get(context).model;

        if (cubit != null) {
          nameController.text = cubit.name!;
          bioController.text = cubit.bio!;
          phoneController.text = cubit.phone!;
        }

        return Scaffold(
          appBar: AppBar(
            actions: [
              TextButton(
                onPressed: () {
                  SocialCubit.get(context).updateUser(
                    name: nameController.text,
                    bio: bioController.text,
                    phone: phoneController.text,
                  );
                },
                child: Text(
                  'Update',
                  style: TextStyle(color: Colors.blueAccent),
                ),
              ),
              SizedBox(width: 20),
            ],
            title: Text('Edit Settings'),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                children: [
                  if (state is SocialUpdateLoadingState) LinearProgressIndicator(),
                  if (state is SocialUpdateLoadingState) SizedBox(height: 10),
                  Container(
                    height: 210,
                    child: Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        Column(
                          children: [
                            Stack(
                              alignment: AlignmentDirectional.topEnd,
                              children: [
                                Container(
                                  width: double.infinity,
                                  height: 150,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(5),
                                      topRight: Radius.circular(5),
                                    ),
                                    child: Image(
                                      fit: BoxFit.cover,
                                      image: NetworkImage('${cubit?.cover}'),
                                    ),
                                  ),
                                ),
                                CircleAvatar(
                                  child: IconButton(
                                    onPressed: () {
                                      SocialCubit.get(context).getProfileCover();
                                    },
                                    icon: Icon(Icons.camera_alt_outlined, color: Colors.blueAccent),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: [
                            CircleAvatar(
                              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                              radius: 64,
                              child: CircleAvatar(
                                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                                radius: 60,
                                backgroundImage: NetworkImage('${cubit?.image}'),
                              ),
                            ),
                            CircleAvatar(
                              child: IconButton(
                                onPressed: () {
                                  SocialCubit.get(context).getProfileImage();
                                },
                                icon: Icon(Icons.camera_alt_outlined, color: Colors.blueAccent),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  if (SocialCubit.get(context).profileImage != null || SocialCubit.get(context).coverImage != null)
                    Row(
                      children: [
                        if (SocialCubit.get(context).profileImage != null)
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  defaultButton(
                                    text: 'Upload Image',
                                    Function: () {
                                      SocialCubit.get(context).uploadProfileImage(
                                        name: nameController.text,
                                        bio: bioController.text,
                                        phone: phoneController.text,
                                      );
                                    },
                                  ),
                                  if (state is SocialUpdateLoadingState) LinearProgressIndicator(),
                                ],
                              ),
                            ),
                          ),
                        if (SocialCubit.get(context).coverImage != null)
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  defaultButton(
                                    text: 'Upload Cover',
                                    Function: () {
                                      SocialCubit.get(context).uploadProfileCover(
                                        name: nameController.text,
                                        bio: bioController.text,
                                        phone: phoneController.text,
                                      );
                                    },
                                  ),
                                  if (state is SocialUpdateLoadingState) LinearProgressIndicator(),
                                ],
                              ),
                            ),
                          ),
                      ],
                    ),
                  if (SocialCubit.get(context).profileImage != null || SocialCubit.get(context).coverImage != null)
                    SizedBox(height: 20),
                  defaultTextFormField(
                    controller: nameController,
                    KeyboardType: TextInputType.text,
                    validate: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your Full Name';
                      } else {
                        return null;
                      }
                    },
                    lable: 'Full Name',
                    prefix: Icons.person,
                  ),
                  SizedBox(height: 15),
                  defaultTextFormField(
                    controller: bioController,
                    KeyboardType: TextInputType.text,
                    validate: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter a bio';
                      } else {
                        return null;
                      }
                    },
                    lable: 'Bio',
                    prefix: Icons.accessibility_sharp,
                  ),
                  SizedBox(height: 15),
                  defaultTextFormField(
                    controller: phoneController,
                    KeyboardType: TextInputType.phone,
                    validate: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your Phone number';
                      } else {
                        return null;
                      }
                    },
                    lable: 'Phone Number',
                    prefix: Icons.phone,
                  ),
                  SizedBox(height: 15),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
