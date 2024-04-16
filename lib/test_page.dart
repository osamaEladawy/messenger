// import 'package:flutter/material.dart';
// import 'package:messenger_app/view_model/home/home_view_model.dart';

// class TextPage extends StatefulWidget {
//   const TextPage({super.key});

//   @override
//   State<TextPage> createState() => _TextPageState();
// }

// class _TextPageState extends State<TextPage>
//     with SingleTickerProviderStateMixin {
//   final _model = HomeViewModel();

//   late PageController _page;

//   @override
//   void initState() {
//     _model.controller = PageController();
//     super.initState();
//   }

//   @override
//   void dispose() {
//     _model.controller?.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       bottomNavigationBar:
//       body: 
//       PageView(
//         controller: _model.controller,
//         physics: const NeverScrollableScrollPhysics(),
//         onPageChanged: (value) {
//           _model.nextPage(value);
//           setState(() {});
//         },
//         children: [
//           ...List.generate(_model.pages.length, (index) => _model.pages[index])
//         ],
//       ),
//     );
//   }
// }
