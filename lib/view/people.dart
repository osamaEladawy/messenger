
import 'package:flutter/material.dart';
import 'package:messenger_app/view/widgets/people/active_users.dart';

class PeoplePage extends StatefulWidget {
  const PeoplePage({super.key});

  @override
  State<PeoplePage> createState() => _PeoplePageState();
}

class _PeoplePageState extends State<PeoplePage> {
  bool isActiveOrStories = false;
  int changeState = 0;


  changeStates(index){
    changeState = index ;
    if(changeState == 0 ){
      changeState = index ;

    }else{
      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>pages[index]));
    }
    print("this is $changeState");
    setState(() {

    });
  }

  List<Widget> pages =[
    const ActiveUsers(),
   ListView.builder(
      shrinkWrap: true,
      itemCount: 10,
      itemBuilder: (context,index){
      return const Card(child: Text("1"),);
    }),

  ];


  selectPage(int index) {
    changeState = index;
    setState(() {
    });
  
  }

  List<String> words = [
    "Active",
    "Stories",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ...List.generate(
                  words.length,
                  (index) => Container(
                    alignment: Alignment.center,
                    height: 30,
                    width: 150,
                    decoration: BoxDecoration(
                      color: changeState == index ? Colors.grey.shade200 : null,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: GestureDetector(
                      onTap: () {
                      selectPage(index);
                      },
                      child: Text(
                        "${words[index]} (12)",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: changeState == index
                                ? Colors.black
                                : Colors.grey.withOpacity(0.7),
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          pages[changeState]
        ],
      ),
    );
  }
}
