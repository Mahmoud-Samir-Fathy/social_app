import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/application_state.dart';
import 'package:social_app/shared/network/local/cashe_helper.dart';


class ApplicationCubit extends Cubit<ApplicationState>{

  ApplicationCubit(): super(ApplicationInitialState());

  static ApplicationCubit get(context)=>BlocProvider.of(context);

  bool isDark=false;
  void changeMode({bool? fromShared}) {
    if(fromShared !=null){
      isDark=fromShared;
      emit(ApplicationBrightnessChange());
    }else {
      isDark=!isDark;
      CacheHelper.putBool(key: 'isDark', value: isDark).then((value) {
        emit(ApplicationBrightnessChange());
      });
    }

  }

}