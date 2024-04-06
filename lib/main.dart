import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  var initialLink = await FirebaseDynamicLinks.instance.getInitialLink();
  handleLink(initialLink);

  FirebaseDynamicLinks.instance.onLink.listen((event) async {
    handleLink(event);
  });

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Firebase Referral"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Welcome",
                style: TextStyle(fontSize: 20),
              ),
              Text("")
            ],
          ),
        ),
      ),
    );
  }
}

void handleLink(PendingDynamicLinkData? data) {
  if (data != null) {
    Uri? uri = data.link;
    print(data);
    print(uri);
    if (uri != null) {
      Map<String, String>? utmParameters =
          data.utmParameters?.cast<String, String>();
      print("UTM Source :${utmParameters?["utm_source"]}");
      print("UTM Medium :${utmParameters?["utm_medium"]}");
      print("UTM Campaign :${utmParameters?["utm_campaign"]}");
    }
  }
}
