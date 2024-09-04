import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/social_app/social_cubit.dart';
import 'package:social_app/layout/social_app/social_states.dart';
import 'package:social_app/models/social_model/social_user_model.dart';
import 'package:social_app/modules/social_pages/chat_details/chat_details.dart';
import 'package:social_app/shared/components/components.dart';

class chat extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
    listener: (BuildContext context, Object? state) {  },
      builder: (BuildContext context, Object? state) {
      return ConditionalBuilder(
          condition: SocialCubit.get(context).Users.length>0,
          builder: (context)=>ListView.separated(
          itemBuilder: (context,index)=>buildUsersChat(SocialCubit.get(context).Users[index],context),
          separatorBuilder: (context,index)=>mySeparator(),
          itemCount: SocialCubit.get(context).Users.length),
          fallback: (context)=>Center(child: CircularProgressIndicator()));
      },
    );
  }

  Widget buildUsersChat(SocialUserModel model,context)=> InkWell(
    onTap: (){
      navigateTo(context, chat_details(
        model: model,
      ));
    },
    child: Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        children: [
          CircleAvatar(
              radius: 25,
              backgroundImage:NetworkImage('${model.image}')),
          SizedBox(width: 15,),
          Text('${model.name}',style: TextStyle(height: 1.4),),
        ],
      ),
    ),
  );

}