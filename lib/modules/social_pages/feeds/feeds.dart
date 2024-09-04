import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/social_app/social_cubit.dart';
import 'package:social_app/layout/social_app/social_states.dart';
import 'package:social_app/models/social_model/social_post_model.dart';

class feeds extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context,state){},
      builder: (context,state){
        return  ConditionalBuilder(
          condition:state is !SocialGetPostLoadingState ,
          builder: (context)=>SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                Stack(
                  alignment: AlignmentDirectional.bottomStart,
                  children: [
                    Card(
                      margin: EdgeInsetsDirectional.all(10),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: Image(
                        height: 140,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        image:
                        NetworkImage('https://img.freepik.com/free-photo/young-asia-girl-wear-medical-face-mask-use-mobile-phone-with-dressed-casual-cloth-self-isolation-social-distancing-quarantine-corona-virus-panoramic-banner-blue-background-with-copy-space_7861-2703.jpg?t=st=1717604428~exp=1717608028~hmac=51b09e6c02379162e9165485b20d2a88c6c862d1581b185c5e12e3f99f4c2820&w=1380'),),

                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text('Communicate With Friends <3',style: TextStyle(color: Colors.white),),
                    ),
                  ],
                ),
                ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context,index)=>buildPost(context,SocialCubit.get(context).posts[index],index),
                    separatorBuilder: (context,index)=>SizedBox(height: 8,),
                    itemCount: SocialCubit.get(context).posts.length),
                SizedBox(height: 5,)
              ],
            ),
          ),
          fallback: (context)=>Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget buildPost(context,PostModel postInfo,index)=> Card(
    elevation: 10,
      margin: EdgeInsetsDirectional.symmetric(horizontal: 10),
      child:
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                    radius: 25,
                    backgroundImage:NetworkImage('${postInfo.profileImage}')),
                SizedBox(width: 15,),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text('${postInfo.name}',style: TextStyle(height: 1.4),),
                          SizedBox(width: 5,),
                          Icon(Icons.check_circle,color: Colors.blueAccent,size: 18,)
                        ],
                      ),
                      Text('${postInfo.dateTime}',style: Theme.of(context).textTheme.bodySmall!.copyWith(height: 1.4)),

                    ],
                  ),
                ),
                IconButton(onPressed: (){}, icon: Icon(Icons.more_horiz)),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                color: Colors.grey[300],
                height: 1,
                width: double.infinity,
              ),
            ),
            Text(
              '${postInfo.text}',style: Theme.of(context).textTheme.bodySmall,),
            if(postInfo.postImage!='')
            Padding(
              padding: const EdgeInsetsDirectional.only(top: 8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Image(
                  fit: BoxFit.cover,
                  image: NetworkImage('${postInfo.postImage}'),
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: (){},
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        children: [
                          Icon(Icons.favorite_outline,color: Colors.red,size: 18,),
                          SizedBox(width: 5,),
                          Text('${SocialCubit.get(context).likes[index]}'),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: (){},
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Icon(Icons.chat_rounded,color: Colors.amber,size: 18,),
                          SizedBox(width: 5,),
                          Text('0 Comments'),
                        ],
                      ),
                    ),
                  ),
                )

              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                color: Colors.grey[300],
                height: 1,
                width: double.infinity,
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap:(){},
                    child: Row(
                      children: [
                        CircleAvatar(
                            radius: 15,
                            backgroundImage:NetworkImage('${SocialCubit.get(context).model!.image}')),
                        SizedBox(width: 15,),
                        Text('Write a comment ...... ',style: Theme.of(context).textTheme.bodySmall),


                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: (){
                    SocialCubit.get(context).likePost(SocialCubit.get(context).postId[index]);
                  },
                  child: Row(
                    children: [
                      Icon(Icons.favorite_outline,color: Colors.red,size: 18,),
                      SizedBox(width: 5,),
                      Text('Like'),
                    ],
                  ),
                ),
              ],
            ),


          ],
        ),
      )
  );
}