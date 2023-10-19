import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:frontend/constants.dart';
import 'package:frontend/screens/main_home_Screen.dart';
import 'package:frontend/screens/auth/register_user_screen.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:provider/provider.dart';
import 'provider/following_data_provider.dart';
import 'global_handler.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await initHiveForFlutter();
  final bool hasToken = await GlobalHandler.hasAuthToken();

  runApp(ChangeNotifierProvider(
    create: (context) => FollowingDataProvider(),
    child: MyApp(
      hasToken: hasToken,
    ),
  ));
}

class MyApp extends StatelessWidget {
  final bool hasToken;
  // For Graph Ql
  final HttpLink httpLink = HttpLink(Constants.graphQlAPIURL);

  MyApp({required this.hasToken, super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    ValueNotifier<GraphQLClient> client = ValueNotifier(
      GraphQLClient(
        link: httpLink,
        cache: GraphQLCache(store: HiveStore()),
      ),
    );
    return GraphQLProvider(
      client: client,
      child: CacheProvider(
        child: MaterialApp(
          title: 'Social App',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: hasToken ? MainHomeScreen() : RegisterUserScreen(),
          debugShowCheckedModeBanner: false,
        ),
      ),
    );
  }
}
