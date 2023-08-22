import 'package:blackcoffer/screens/post_video_screen.dart';
import 'package:blackcoffer/widgets/post_cards.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../utils/colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: colorPrimary)
    );
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            "BlackCoffer",
            style: TextStyle(
              fontSize: 16,
            ),
          ),
          backgroundColor: colorPrimary,
          elevation: 0,

        ),

        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 48,
                  constraints: BoxConstraints(maxWidth: 500),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(52),
                    color: Colors.grey.shade200,
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Search....",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(52),
                        borderSide: BorderSide(color: Colors.grey.shade200, width: 0.5)
                          ),
                    ),
                  ),
                ),
              ),
              Container(
                child: Center(
                  child: StreamBuilder(
                      stream: FirebaseFirestore.instance.collection("posts").snapshots(),
                      builder: (context,
                          AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(strokeWidth: 2,),
                          );
                        }
                        return   ListView.builder(
                            itemCount: snapshot.data!.docs.length,
                            shrinkWrap: true,
                            primary: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) =>
                                GestureDetector(
                                  onTap: (){

                                  },
                                  child: Container(

                                    child: Center(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
                                        child: PostCards(
                                          snap: snapshot.data!.docs[index].data(),
                                        ),
                                      ),
                                    ),
                                  ),
                                ));

                      }
                  ),
                ),
              ),
            ],
          ),
        ),

        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context,
                CupertinoPageRoute(
                    fullscreenDialog: true, builder: (_) => PostVideoScreen()));
          },
          backgroundColor: colorPrimary,
          child: Icon(
            Icons.video_call_rounded,
            color: Colors.white,
          ),
          elevation: 0,
        ),
      ),
    );
  }
}
