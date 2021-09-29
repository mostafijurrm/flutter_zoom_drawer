import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:zoom_drawer/screens/drawer/drawer_screen.dart';
import 'package:zoom_drawer/utils/custom_color.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: CustomColor.primaryColor,
      systemNavigationBarColor: CustomColor.primaryColor
    )
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 640),
      builder: () => MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          // primarySwatch: Colors.deepOrange,
        ),
        home: ChangeNotifierProvider(
          create: (_) => MenuProvider(),
          child: const DrawerScreen(),
        ),
      ),
    );
  }
}