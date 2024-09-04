import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/social_app/social_cubit.dart';
import 'package:social_app/layout/social_app/social_states.dart';
import 'package:social_app/modules/social_pages/edit_settings/edit_settings.dart';
import 'package:social_app/shared/components/components.dart';

class settings extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (BuildContext context, SocialStates state) {  },
      builder: (BuildContext context, SocialStates state) {
        var cubit=SocialCubit.get(context);

        return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              children: [
                Container(
                  height: 210,
                  child: Stack(
                    alignment: AlignmentDirectional.bottomCenter,
                    children: [
                      Column(
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
                                image: NetworkImage('${cubit.model!.cover}'),
                              ),
                            ),
                          ),

                        ],
                      ),
                      CircleAvatar(
                        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                        radius: 64,
                        child: CircleAvatar(
                          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                          radius: 60,
                          backgroundImage: NetworkImage('${cubit.model!.image}'),
                        ),
                      ),


                    ],
                  ),
                ),
                Text('${cubit.model!.name}',style: Theme.of(context).textTheme.bodyLarge,),
                SizedBox(height: 10,),
                Text('${cubit.model!.bio}',style: Theme.of(context).textTheme.bodySmall,),

                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: (){},
                          child: Column(
                            children: [
                              Text('100',style: Theme.of(context).textTheme.bodyMedium,),
                              Text('Posts',style: Theme.of(context).textTheme.bodySmall,),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: (){},
                          child: Column(
                            children: [
                              Text('151',style: Theme.of(context).textTheme.bodyMedium,),
                              Text('Followers',style: Theme.of(context).textTheme.bodySmall,),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: (){},
                          child: Column(
                            children: [
                              Text('256',style: Theme.of(context).textTheme.bodyMedium,),
                              Text('Following',style: Theme.of(context).textTheme.bodySmall,),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: (){},
                          child: Column(
                            children: [
                              Text('101',style: Theme.of(context).textTheme.bodyMedium,),
                              Text('Photo',style: Theme.of(context).textTheme.bodySmall,),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 25,),

                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {},
                        child: Text('Add Photos',style: TextStyle(color: Colors.blueAccent),),
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: Colors.grey.shade400), // Remove border
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8), // Optional: Rounded corners
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 15),
                    OutlinedButton(
                      onPressed: () {
                        navigateTo(context, editUserProfile());
                      },
                      child: Icon(Icons.edit, size: 16,color: Colors.blueAccent,),
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: Colors.grey.shade400), // Remove border
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8), // Optional: Rounded corners
                        ),
                      ),
                    ),
                  ],
                )


              ],
            ),
          );
      },

    );
  }

}