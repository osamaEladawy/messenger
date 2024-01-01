import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../auth/service_auth.dart';
import '../../../core/constant/custom_colors.dart';
import '../../../data/model/user_model.dart';
import '../../chat/chat_page.dart';
import '../../screens/profile_user.dart';

class FavoriteCateegories extends StatefulWidget {
  const FavoriteCateegories({super.key});

  @override
  State<FavoriteCateegories> createState() => _FavoriteCateegoriesState();
}

class _FavoriteCateegoriesState extends State<FavoriteCateegories> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  getData() async {
    final auth = Provider.of<AuthServise>(context, listen: false);
    await auth.getDataFromSharedpreferences();
  }

  // ignore: prefer_typing_uninitialized_variables
  var response;

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    final auth = Provider.of<AuthServise>(context);
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('users').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Error');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text('Loading...');
        }
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: kContanerbackGround.withOpacity(0.1),
          ),
          height: 120,
          child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                QueryDocumentSnapshot result = snapshot.data!.docs[index];
                Map<String, dynamic> data =
                result.data()! as Map<String, dynamic>;
                UserModel userModel = UserModel.fromMap(data);
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => ChatPage(
                            reciverUserName: data['name'],
                            reciverUserId: data['uid'],
                            reciverUserEmail: data['email'],
                          ),
                        ),
                      );
                    },
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: () async {
                              response = await Navigator.of(context)
                                  .push(MaterialPageRoute(
                                builder: (context) => UserProfilePage(
                                  doc: result,
                                ),
                              ));
                            },
                            child: CircleAvatar(
                                radius: 40,
                                backgroundImage: data['image'] == null
                                    ? const AssetImage(
                                  "assetes/images/person01.png",
                                )
                                    : NetworkImage("${data['image']}")
                                as ImageProvider),
                          ),
                        ),
                        if (data['name'] != null)
                          Text(
                            data['name'],
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white38,
                                letterSpacing: 0.8),
                          ),
                      ],
                    ),
                  ),
                );
              }),
        );
      },
    );
  }

  // ignore: unused_element
  Widget _buildUsersList() {
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text('error');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text('Loading...');
          }
          return ListView(
            padding: const EdgeInsets.only(left: 15),
            scrollDirection: Axis.horizontal,
            children: snapshot.data!.docs
                .map<Widget>((doc) => _buildUsersListItem(doc))
                .toList(),
          );
        });
  }

  //
  Widget _buildUsersListItem(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data()! as Map<String, dynamic>;
    UserModel userModel = UserModel.fromMap(data);
    if (_auth.currentUser!.email != data['email'] &&
        _auth.currentUser!.uid != data['uid']) {
      return GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => ChatPage(
                reciverUserName: data['name'],
                reciverUserId: data['uid'],
                reciverUserEmail: data['email'],
              ),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: CircleAvatar(
                  radius: 35,
                  // backgroundImage: file == null ? const AssetImage("assetes/images/image01.jpg") : FileImage(File(file!.path)) as ImageProvider
                ),
              ),
              Text(
                data['name'],
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white38,
                    letterSpacing: 0.8),
              ),
            ],
          ),
        ),
      );
    } else {
      return Container();
    }
  }
}
