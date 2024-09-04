import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/social_app/social_app.dart';
import 'package:social_app/modules/social_pages/social_register/social_register_cubit.dart';
import 'package:social_app/modules/social_pages/social_register/social_register_states.dart';
import 'package:social_app/shared/components/components.dart';

class SocialRegisterScreen extends StatelessWidget{
  var formKey=GlobalKey<FormState>();
  var emailController=TextEditingController();
  var nameController=TextEditingController();
  var phoneController=TextEditingController();
  var passwordController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (BuildContext context) =>SocialRegisterCubit(),
    child: BlocConsumer<SocialRegisterCubit,SocialRegisterStates>(
      listener:(context,state){
        if(state is SocialCreateUserSuccessState){
          navigateAndFinish(context, SocialLayout());
        }
      } ,
      builder: (context,state){
        return Scaffold(
          appBar: AppBar(),
          body:  Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: formKey,

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Register',style: TextStyle(fontSize: 40,fontWeight: FontWeight.bold),),
                      SizedBox(height: 5,),
                      Text('Register to browse our hot offers',style: TextStyle(color: Colors.grey,fontSize: 20),),
                      SizedBox(height: 30,),

                      defaultTextFormField(
                          controller: nameController,
                          KeyboardType: TextInputType.text,
                          validate: (value){
                            if(value!.isEmpty)
                            { return'Please enter your Full Name';}
                            else {return null;}
                          },
                          lable: 'Full Name',
                          prefix: Icons.person),
                      SizedBox(height: 20,),

                      defaultTextFormField(
                          controller: emailController,
                          KeyboardType: TextInputType.emailAddress,
                          validate: (value){
                            if(value!.isEmpty)
                            { return'Please enter your email address';}
                            else {return null;}
                          },
                          lable: 'Email Address',
                          prefix: Icons.email_outlined),
                      SizedBox(height: 20,),
                      defaultTextFormField(
                        controller: passwordController,
                        KeyboardType: TextInputType.visiblePassword,
                        validate: (value){
                          if(value!.isEmpty)
                          { return'Password isn\'t correct';}
                          else {return null;}
                        },
                        lable: 'Password',
                        prefix: Icons.lock,
                        suffix: SocialRegisterCubit.get(context).suffixIcon,
                        isPassword:SocialRegisterCubit.get(context).isPasswordShown ,
                        suffixpressed: (){
                          SocialRegisterCubit.get(context).changePasswordVisibility();
                        },
                      ),
                      SizedBox(height: 20,),

                      defaultTextFormField(
                          controller: phoneController,
                          KeyboardType: TextInputType.phone,
                          validate: (value){
                            if(value!.isEmpty)
                            { return'Please enter your mobile number';}
                            else {return null;}
                          },
                          lable: 'Phone',
                          prefix: Icons.phone),
                      SizedBox(height: 20,),
                      ConditionalBuilder(
                        condition: (state is !SocialRegisterLoadingState),
                        builder:(context)=>defaultButton(
                            text: 'Register',
                            isUpperCase: true,
                            Function: (){
                              if(formKey.currentState!.validate()){
                                SocialRegisterCubit.get(context).userRegister(
                                  name: nameController.text,
                                  email: emailController.text,
                                  password: passwordController.text,
                                  phone: phoneController.text,
                                );
                              }
                            }
                        ) ,
                        fallback:(context)=>Center(child: CircularProgressIndicator()) ,
                      ),

                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    ),
    );
  }

}