import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:social_app/layout/social_app/social_cubit.dart';
import 'package:social_app/layout/social_app/social_states.dart';

class addPost extends StatelessWidget{
  @override
  Widget build(BuildContext context) {

    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context,state){},
      builder: (context,state){
        var cubit=SocialCubit.get(context).model;
        var textController=TextEditingController();
        var now=DateTime.now();
        return Scaffold(
          appBar: AppBar(
            title:Text('Add Post') ,
            actions: [
              TextButton(onPressed: () {
                if(SocialCubit.get(context).postImage==null){
                  SocialCubit.get(context).addNewPost(text: textController.text, dateTime: now.toString());
                } else{
                  SocialCubit.get(context).uploadPostImage(dateTime: now.toString(), text: textController.text);
                }
              },
              child: Text('Post')),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(

              children: [
                if(state is SocialPostImageLoadingState )LinearProgressIndicator(),
                if(state is SocialPostImageLoadingState )SizedBox(height: 10,),

                Row(
                  children: [
                    CircleAvatar(
                        radius: 25,
                        backgroundImage:NetworkImage('${cubit!.image}'),),
                    SizedBox(width: 15,),
                    Expanded(
                      child: Row(
                        children: [
                          Text('${cubit.name}',style: TextStyle(height: 1.4),),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20,),
                Expanded(
                  child: TextFormField(
                    controller: textController,
                    decoration: InputDecoration(
                        hintText: 'What is on your mind......',
                      border: InputBorder.none
                    ),
                  
                  ),
                ),
                if(SocialCubit.get(context).postImage!=null)
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
                          image: FileImage(SocialCubit.get(context).postImage!),
                        ),
                      ),
                    ),
                    CircleAvatar(
                      child: IconButton(
                        onPressed: () {
                          SocialCubit.get(context).removePostImage();

                        },
                        icon: Icon(Icons.close, color: Colors.blueAccent),
                      ),
                    ),
                  ],
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: TextButton(onPressed: (){
                        SocialCubit.get(context).getPostImage();
                      },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                               Icon(Icons.image),SizedBox(width: 5,),
                              Text('add photo'),
                                          ],)),
                    ),
                    Expanded(child: TextButton(onPressed: () {  },
                    child: Text('#tags'))),

                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

}