import 'package:flutter/material.dart';
import 'package:messenger/views/screens/home_page.dart';

import '../../../core/constant/custom_colors.dart';
import '../../screens/groub.dart';
import '../../screens/online.dart';
import '../../screens/request.dart';

class CategoriesSelector extends StatefulWidget {
  const CategoriesSelector({super.key});


  @override
  State<CategoriesSelector> createState() => _CategoriesSelectorState();
}

class _CategoriesSelectorState extends State<CategoriesSelector>
    with SingleTickerProviderStateMixin {
  int? number;

  changeState(index){
    number = index ;
    if(number == 0 || pages[index] == const HomePage()){
      number = index ;

    }else{
      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>pages[index]));
    }
    print("this is $number");
    setState(() {

    });
  }

  List<Widget> pages =[
    const HomePage(),
    const OnlinePage(),
    const GroubsPage(),
    const RequsetPage(),
  ];

  List<String>categories = [
    'Messages',
    'Online',
    'Groups',
    'Requests',

  ];


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: ListView(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        children: [
          ...List.generate(categories.length, (index) =>
              GestureDetector(
                onTap: () {
                  changeState(index);
                },
                child: Container(
                  margin:const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    border:number == index ? const Border(bottom: BorderSide(
                      color: Colors.blue,width: 5,
                    )):null,
                  ),
                  child: Text(
                    categories[index],
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: number == index  ?  Colors.white:kContanerbackGround,
                        letterSpacing: 1),
                  ),
                ),
              ),
          ),
        ],
      ),
    );
  }
}
