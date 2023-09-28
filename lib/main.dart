import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wallcano/bloc/wallpaper_bloc.dart';
import 'package:wallcano/screens/home_page.dart';

import 'api_response/img_response.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(
      BlocProvider<WallpaperBloc>(create:(context)=>WallpaperBloc(apiResponse: ApiResponse()),
  child: const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp(),)
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, widget) => BlocProvider<WallpaperBloc>(create:(context)=>WallpaperBloc(apiResponse: ApiResponse()),
          child:MaterialApp(
            themeMode: ThemeMode.system,
            theme: ThemeData(
                fontFamily: 'Ubuntu'
            ),
            debugShowCheckedModeBanner: false,
            builder: (context, widget) => MediaQuery(
                data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                child: const HomePage()),
            title: 'News App',
          )
      ),
    );
  }
}
