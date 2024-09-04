import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/social_app/social_app.dart';
import 'package:social_app/modules/social_pages/social_login/social_login_cubit.dart';
import 'package:social_app/modules/social_pages/social_login/social_login_states.dart';
import 'package:social_app/modules/social_pages/social_register/social_register_screen.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/network/local/cashe_helper.dart';
class SocialLoginScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    var formKey=GlobalKey<FormState>();
    var emailController=TextEditingController();
    var passwordController=TextEditingController();
    return BlocProvider(create: (BuildContext context) =>SocialLoginCubit(),
    child: BlocConsumer<SocialLoginCubit,SocialLoginStates>(
      listener:(context,state){
        if(state is SocialLoginErrorState){
          showToast(context, title: 'Error',
              description: state.error.toString(),
              state: ToastColorState.error,
              icon: Icons.error);
        }
        if(state is SocialLoginSuccessState){
          CacheHelper.saveData(
              key: 'uId',
              value: state.uId).then((value) {
          navigateAndFinish(context, SocialLayout());
          });
        }
      } ,
      builder: (context,state){
        return Scaffold(
          appBar: AppBar(),
          body: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Login',style: TextStyle(fontSize: 40,fontWeight: FontWeight.bold),),
                      SizedBox(height: 5,),
                      Text('Login to communitcate with your friends',style: TextStyle(color: Colors.grey,fontSize: 20),),
                      SizedBox(height: 30,),
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

                        onSubmit: (value){
                          if(formKey.currentState!.validate()){
                            SocialLoginCubit.get(context).userLogin(
                                email: emailController.text,
                                password: passwordController.text);
                          }
                        },
                        controller: passwordController,
                        KeyboardType: TextInputType.visiblePassword,
                        validate: (value){
                          if(value!.isEmpty)
                          { return'Password isn\'t correct';}
                          else {return null;}
                        },
                        lable: 'Password',
                        prefix: Icons.lock,
                        suffix: SocialLoginCubit.get(context).suffixIcon,
                        isPassword:SocialLoginCubit.get(context).isShown ,
                        suffixpressed: (){
                          SocialLoginCubit.get(context).changeVisibility();
                        },
                      ),
                      SizedBox(height: 20,),
                      ConditionalBuilder(
                        condition: (state is !SocialLoginLoadingState),
                        builder:(context)=>defaultButton(
                            text: 'LOGIN',
                            Function: (){
                              if(formKey.currentState!.validate()){
                                SocialLoginCubit.get(context).userLogin(
                                    email: emailController.text,
                                    password: passwordController.text);
                              }
                            }
                        ) ,
                        fallback:(context)=>Center(child: CircularProgressIndicator()) ,
                      ),
                      SizedBox(height: 15,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Don\'t have an account?easy ^_^'),
                          SizedBox(width: 5,),
                          TextButton(onPressed: (){
                            navigateTo(context, SocialRegisterScreen());
                          }, child: Text('Sign Up'))
                        ],
                      )
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