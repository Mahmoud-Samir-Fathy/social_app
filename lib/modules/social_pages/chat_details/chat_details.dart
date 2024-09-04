import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/social_app/social_cubit.dart';
import 'package:social_app/layout/social_app/social_states.dart';
import 'package:social_app/models/social_model/social_message_model.dart';
import 'package:social_app/models/social_model/social_user_model.dart';

class chat_details extends StatelessWidget{

  SocialUserModel? model;
  chat_details({
    this.model
  });

  var textController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (BuildContext context) {
      SocialCubit.get(context).getMessage(receiverId: model!.uId!);

      return BlocConsumer<SocialCubit,SocialStates>(
        listener: (context,state){},
        builder: (context,state){
          return Scaffold(
            appBar: AppBar(
              title: Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundImage: NetworkImage('${model!.image}'),
                  ),
                  SizedBox(width: 15,),
                  Text('${model!.name}')
                ],
              ),
            ),
            body: ConditionalBuilder(
              condition: SocialCubit.get(context).messages.length>=0,
              builder: (BuildContext context) {
                return Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.separated(
                            itemBuilder: (context,index){
                              var messages=SocialCubit.get(context).messages[index];
                              if(SocialCubit.get(context).model!.uId==messages.senderId){
                                return  buildMyMessage(messages);
                              }else {
                               return buildMessage(messages);
                              }
                        
                            },
                            separatorBuilder: (context,index)=>SizedBox(height: 15,),
                            itemCount: SocialCubit.get(context).messages.length),
                      ),
                      Container(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        decoration: BoxDecoration(
                            border: Border.all(
                                width: 1,
                                color: Colors.grey
                            ),
                            borderRadius: BorderRadiusDirectional.all( Radius.circular(8))
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: textController,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: '  Type your massage...'

                                ),
                              ),
                            ),
                            Container(
                                color: Colors.blueAccent,
                                child: MaterialButton(minWidth: 1,onPressed: (){
                                  SocialCubit.get(context).sendMessage(receiverId: model!.uId.toString(), text: textController.text, time: DateTime.now().toString());
                                },
                                  child: Icon(Icons.send,size: 16,color: Colors.white,),))
                          ],
                        ),
                      )

                    ],
                  ),
                );
              },
              fallback: (BuildContext context)=>Center(child: CircularProgressIndicator()),

            ),
          );
        },
      );
    },

    );
  }
  Widget buildMessage(MessageModel messageModel)=>Align(
    alignment: AlignmentDirectional.centerStart,
    child: Container(
      decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadiusDirectional.only(
            bottomEnd: Radius.circular(10),
            topEnd: Radius.circular(10),
            topStart: Radius.circular(10),


          )
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Text(messageModel.text.toString()),
      ),
    ),
  );
  Widget buildMyMessage(MessageModel messageModel)=>Align(
    alignment: AlignmentDirectional.centerEnd,
    child: Container(
      decoration: BoxDecoration(
          color: Colors.blue[300],
          borderRadius: BorderRadiusDirectional.only(
            bottomStart: Radius.circular(10),
            topEnd: Radius.circular(10),
            topStart: Radius.circular(10),


          )
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Text(messageModel.text.toString()),
      ),
    ),
  );

}