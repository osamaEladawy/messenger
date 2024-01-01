import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:messenger/views/screens/profile_user.dart';
import 'package:provider/provider.dart';

import '../../auth/service_auth.dart';
import '../../core/constant/custom_colors.dart';
import '../../data/model/user_model.dart';
import '../../data/viewmodel/online_viewmodel.dart';
import '../chat/chat_page.dart';
import '../widgets/shared/custom_textfield.dart';

class OnlinePage extends StatefulWidget {
  const OnlinePage({super.key});

  @override
  State<OnlinePage> createState() => _OnlinePageState();
}

class _OnlinePageState extends State<OnlinePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController controller = TextEditingController();
  OnlineViewModel onlineViewModel = OnlineViewModel();
  Color? valColor;


  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    var auth = Provider.of<AuthServise>(context);
    return Scaffold(
      backgroundColor: kBackGround,
      appBar: AppBar(
          backgroundColor: kBackGround,
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                size: 25,
              )),
          title: const Text(
            "Frindes",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('users')
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return const Text('error');
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Text('Loading...');
                    }
                    return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (BuildContext context, int index) {
                        QueryDocumentSnapshot result = snapshot.data!.docs[index];
                        Map<String, dynamic> data =
                            result!.data()! as Map<String, dynamic>;
                        var usermodel = UserModel.fromMap(data);
                        return Card(
                          child: ListTile(
                            title: Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                UserProfilePage(
                                                  doc: result!,
                                                ),),);
                                  },
                                  child: CircleAvatar(
                                    backgroundImage: usermodel.image == null
                                        ? const AssetImage(
                                            "assetes/images/person01.png",
                                          )
                                        : NetworkImage("${usermodel.image}")
                                            as ImageProvider,
                                    maxRadius: 15,
                                  ),
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                if (usermodel.name != null)
                                  Text(
                                    usermodel.name!,
                                    style: const TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold),
                                  ),
                                const Spacer(),
                                usermodel.uid == _auth.currentUser!.uid
                                    ? Radio(
                                        activeColor: Colors.green,
                                        value: valColor,
                                        groupValue: valColor,
                                        onChanged: (onChanged) {})
                                    : const Card()
                              ],
                            ),
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(builder: (context) {
                                  return ChatPage(
                                    reciverUserName: usermodel.name!,
                                    reciverUserId: usermodel.uid!,
                                    reciverUserEmail: usermodel.email!,
                                    currentUser: _auth.currentUser!.displayName,
                                  );
                                }),
                              );
                            },
                          ),
                        );
                      },
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}

class MyUsersName extends StatefulWidget {
 final auth;
 final  valColor;
  const MyUsersName({super.key, this.auth, required this.valColor});

  @override
  State<MyUsersName> createState() => _MyUsersNameState();
}

class _MyUsersNameState extends State<MyUsersName> {
  final  usersData = FirebaseFirestore.instance.collection('users').where("name").snapshots();


  @override
  Widget build(BuildContext context) {
    var auth = Provider.of<AuthServise>(context);
    return Expanded(
      child: StreamBuilder(
        stream: usersData,
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if(snapshot.hasData){
            return ListView.builder(
              shrinkWrap: true,
                itemCount:snapshot.data!.docs.length ,
                itemBuilder: (context,index){
                  QueryDocumentSnapshot result = snapshot.data!.docs[index];
                  Map<String, dynamic> data =
                  result.data()! as Map<String, dynamic>;
                  var usermodel = UserModel.fromMap(data);
                  return Card(
                    child: ListTile(
                      title: Row(
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.of(context).push(
                              MaterialPageRoute(
                               builder: (context) =>
                              UserProfilePage(
                                doc: result,
                              ),),);
                            },
                            child: CircleAvatar(
                              backgroundImage: usermodel.image == null
                                  ? const AssetImage(
                                "assetes/images/person01.png",
                              )
                                  : NetworkImage("${usermodel.image}")
                              as ImageProvider,
                              maxRadius: 15,
                            ),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          if (usermodel.name != null)
                            Text(
                              usermodel.name!,
                              style: const TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold),
                            ),
                          const Spacer(),
                          usermodel.uid == widget.auth.currentUser!.uid
                              ? Radio(
                              activeColor: Colors.green,
                              value: widget.valColor,
                              groupValue: widget.valColor,
                              onChanged: (onChanged) {})
                              : const Card()
                        ],
                      ),
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) {
                            return ChatPage(
                              reciverUserName:  usermodel.name!,
                              reciverUserId:  usermodel.uid!,
                              reciverUserEmail:  usermodel.email!,
                              currentUser: widget.auth.currentUser!.displayName,
                            );
                          }),
                        );
                      },
                    ),
                  );
                });
          }else{
            return const Text("loading");
          }
        }
      ),
    );
  }
}

