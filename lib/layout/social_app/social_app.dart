import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/social_app/social_cubit.dart';
import 'package:social_app/layout/social_app/social_states.dart';

import '../../modules/social_pages/add_post/add_post.dart';
import '../../shared/components/components.dart';

class SocialLayout extends StatelessWidget{
  @override
  Widget build(BuildContext context) {

    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context,state){
        if(state is AddPostNavState){
          navigateTo(context, addPost());
        }
      },

      builder: (context,state){
        var cubit =SocialCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(cubit.tittles[cubit.currentIndex]),
          ),
          body:cubit.Screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex:cubit.currentIndex ,
            onTap:(index){
              cubit.changeBottomNavBar(index);
            } ,
            items: [

              BottomNavigationBarItem(icon:Icon(Icons.home) ,label:'Home' ),
              BottomNavigationBarItem(icon:Icon(Icons.chat) ,label:'Chat'),
              BottomNavigationBarItem(icon:Icon(Icons.post_add) ,label:'Post'),
              BottomNavigationBarItem(icon:Icon(Icons.person) ,label:'Users'),
              BottomNavigationBarItem(icon:Icon(Icons.settings) ,label:'Settings'),
            ],
          ),
        );
      },
    );

  }
}