// import 'dart:convert';
// import 'dart:math';
//
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:provider/provider.dart';
// import 'package:spotify/service/auth.dart';
//
// class HomeScreen extends StatefulWidget {
//   final userId;
//   HomeScreen({this.userId});
//
//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen>
//     with SingleTickerProviderStateMixin {
//   var tabbarController;
//   var selectIndex = 0;
//

//
//   @override
//   void initState() {
//     // TODO: uncomment Adding USer();
//     tabbarController = TabController(vsync: this, initialIndex: 0, length: 2);
//     addingUser();
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black54,
//       appBar: AppBar(
//         elevation: 0.0,
//         backgroundColor: Colors.white,
//         title: Text(
//           'Spotify',
//           style: TextStyle(color: Colors.white),
//         ),
//       ),
//       body: Column(
//         children: [
//           TabBar(
//             controller: tabbarController,
//             indicatorColor: Colors.pink,
//             indicatorSize: TabBarIndicatorSize.label,
//             indicatorWeight: 5,
//             tabs: [
//               Tab(
//                 child: Text("Songs"),
//               ),
//               Tab(
//                 child: Text("Playlists"),
//               )
//             ],
//           ),
//           Padding(
//             padding: const EdgeInsets.only(top: 25.0),
//             child: LimitedBox(
//               maxHeight: 400,
//               child: TabBarView(
//                 controller: tabbarController,
//                 children: [
//                   ListView(
//                     shrinkWrap: true,
//                     children: [
//                       ChoisesCard(
//                         image: Random().nextInt(7) + 1,
//                       ),
//                       ChoisesCard(
//                         image: Random().nextInt(7) + 1,
//                       ),
//                       ChoisesCard(
//                         image: Random().nextInt(7) + 1,
//                       ),
//                       ChoisesCard(
//                         image: Random().nextInt(7) + 1,
//                       ),
//                       ChoisesCard(
//                         image: Random().nextInt(7) + 1,
//                       ),
//                       ChoisesCard(
//                         image: Random().nextInt(7) + 1,
//                       )
//                     ],
//                   ),
//                   ListView(
//                     children: [
//                       ChoisesCard(
//                         image: Random().nextInt(7) + 1,
//                       ),
//                       ChoisesCard(
//                         image: Random().nextInt(7) + 1,
//                       ),
//                       ChoisesCard(
//                         image: Random().nextInt(7) + 1,
//                       ),
//                       ChoisesCard(
//                         image: Random().nextInt(7) + 1,
//                       ),
//                       ChoisesCard(
//                         image: Random().nextInt(7) + 1,
//                       ),
//                       ChoisesCard(
//                         image: Random().nextInt(7) + 1,
//                       ),
//                       ChoisesCard(
//                         image: Random().nextInt(7) + 1,
//                       ),
//                     ],
//                   )
//                 ],
//               ),
//             ),
//           ),
//           Container(
//             alignment: Alignment.center,
//             child: RaisedButton(
//               child: Text("SignOUt"),
//               onPressed: () async {
//                 final auth = Provider.of<Auth>(context, listen: false);
//                 await auth.signOut();
//               },
//             ),
//             // padding: EdgeInsets.all(20),
//             // color: Colors.white,
//             // child: Column(
//             //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             //   children: [
//             //     Text(
//             //       "HERE IMAGE",
//             //       style: TextStyle(fontSize: 40),
//             //     ),
//             //     slider(),
//             //     InkWell(
//             //       onTap: () {
//             //         getAudio();
//             //       },
//             //       child: Icon(
//             //         playing == false
//             //             ? Icons.play_circle_outline
//             //             : Icons.pause_circle_outline,
//             //         size: 100,
//             //         color: Colors.blue,
//             //       ),
//             //     )
//             //   ],
//             // ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class ChoisesCard extends StatelessWidget {
//   final image;
//   ChoisesCard({this.image});
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.only(top: 5, bottom: 5),
//       child: Row(
//         children: [
//           ClipRRect(
//               borderRadius: BorderRadius.circular(10),
//               child: Image.asset(
//                 "assets/p$image.jpg",
//                 width: 60,
//                 height: 60,
//                 fit: BoxFit.cover,
//               )),
//           Padding(
//             padding: const EdgeInsets.only(left: 15.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   "Counting Stars",
//                   style: TextStyle(
//                       color: Colors.white, fontWeight: FontWeight.bold),
//                 ),
//                 Text(
//                   "OneRepublic Native",
//                   style: TextStyle(color: Colors.white.withOpacity(0.8)),
//                 )
//               ],
//             ),
//           ),
//           Spacer(),
//           Column(
//             children: [Icon(Icons.favorite), Text("200")],
//           )
//         ],
//       ),
//     );
//   }
// }
