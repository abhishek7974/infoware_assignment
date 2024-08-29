import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'features/Form/bloc/form_bloc.dart';
import 'features/post/bloc/posts_bloc.dart';
import 'features/audio/ui/audio_player.dart';
import 'features/Form/ui/form_screen.dart';
import 'features/post/ui/post_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => PostsBloc()),
        BlocProvider(create: (context) => FormBloc()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: PostPage(),
        routes: {
          '/form': (context) => FormPage(),
          '/audio': (context) => AudioPlayerScreen(),
        },
      ),
    );;
  }
}

