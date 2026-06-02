// // import 'dart:convert';
// // import 'package:http/http.dart' as http;
// // import 'package:flutter/material.dart';
// // import 'package:shared_preferences/shared_preferences.dart';
// //
// // class viewsafetytips extends StatelessWidget {
// //   const viewsafetytips({super.key});
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       title: 'Flutter Demo',
// //       theme: ThemeData(
// //         primarySwatch: Colors.red,
// //       ),
// //       home: const viewsafetytipspage(title: 'Flutter Demo Home Page'),
// //     );
// //   }
// // }
// //
// // class viewsafetytipspage extends StatefulWidget {
// //   const viewsafetytipspage({super.key, required this.title});
// //
// //   final String title;
// //
// //   @override
// //   State<viewsafetytipspage> createState() => _viewsafetytipspageState();
// // }
// //
// // class _viewsafetytipspageState extends State<viewsafetytipspage> {
// //   List<String> id_ = [];
// //   List<String> boat_ = [];
// //   List<String> start_date_ = [];
// //   List<String> end_date_ = [];
// //   List<String> From_ = [];
// //   List<String> To_ = [];
// //   List<String> status_ = [];
// //
// //   @override
// //   void initState() {
// //     super.initState();
// //     load();
// //   }
// //
// //   Future<void> load() async {
// //     List<String> id = [];
// //     List<String> boat = [];
// //     List<String> start_date = [];
// //     List<String> end_date = [];
// //     List<String> From = [];
// //     List<String> To = [];
// //     List<String> status = [];
// //
// //     try {
// //       final pref = await SharedPreferences.getInstance();
// //       String ip = pref.getString("url").toString();
// //
// //       String url = "$ip/user_viewsafetytips/";
// //       print(url);
// //
// //       var data = await http.post(Uri.parse(url));
// //       var jsondata = json.decode(data.body);
// //       String stat = jsondata['status'];
// //
// //       var arr = jsondata["data"];
// //
// //       print(arr);
// //       print(arr.length);
// //
// //       for (int i = 0; i < arr.length; i++) {
// //         id.add(arr[i]['id'].toString());
// //         boat.add(arr[i]['boat']);
// //         start_date.add(arr[i]['start_date'].toString());
// //         end_date.add(arr[i]['end_date'].toString());
// //         From.add(arr[i]['From'].toString());
// //         To.add(arr[i]['To'].toString());
// //         status.add(arr[i]['status'].toString());
// //       }
// //
// //       setState(() {
// //         id_ = id;
// //         boat_ = boat;
// //         start_date_ = start_date;
// //         end_date_ = end_date;
// //         From_ = From;
// //         To_ = To;
// //         status_ = status;
// //       });
// //
// //       print(stat);
// //     } catch (e) {
// //       print("Error ------------------- $e");
// //     }
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: const Text(
// //           "VIEW trip",
// //           style: TextStyle(color: Colors.white),
// //         ),
// //         leading: IconButton(
// //           icon: const Icon(Icons.arrow_back),
// //           onPressed: () {
// //             Navigator.pop(context);
// //           },
// //         ),
// //       ),
// //
// //       body: ListView.builder(
// //         physics: const BouncingScrollPhysics(),
// //         itemCount: id_.length,
// //         itemBuilder: (BuildContext context, int index) {
// //           return ListTile(
// //             title: Padding(
// //               padding: const EdgeInsets.all(4.0),
// //               child: Column(
// //                 children: [
// //                   Container(
// //                     width: MediaQuery.of(context).size.width,
// //                     height: 250,
// //                     child: Card(
// //                       clipBehavior: Clip.antiAliasWithSaveLayer,
// //                       child: Padding(
// //                         padding: const EdgeInsets.all(10.0),
// //                         child: Column(
// //                           children: [
// //                             const SizedBox(height: 10),
// //
// //                             buildRow("STOP PLACE", boat_[index]),
// //                             const SizedBox(height: 10),
// //
// //                             buildRow("START TIME", start_date_[index]),
// //                             const SizedBox(height: 10),
// //
// //                             buildRow("END TIME", end_date_[index]),
// //                             const SizedBox(height: 10),
// //
// //                             buildRow("FROM", From_[index]),
// //                             const SizedBox(height: 10),
// //
// //                             buildRow("TO", To_[index]),
// //                             const SizedBox(height: 10),
// //
// //                             buildRow("STATUS", status_[index]),
// //                           ],
// //                         ),
// //                       ),
// //                       shape: RoundedRectangleBorder(
// //                         borderRadius: BorderRadius.circular(10.0),
// //                       ),
// //                       elevation: 5,
// //                       margin: const EdgeInsets.all(10),
// //                     ),
// //                   ),
// //                 ],
// //               ),
// //             ),
// //           );
// //         },
// //       ),
// //     );
// //   }
// //
// //   Widget buildRow(String label, String value) {
// //     return Row(
// //       children: [
// //         const SizedBox(width: 10),
// //         Flexible(flex: 2, fit: FlexFit.loose, child: Text(label)),
// //         Flexible(flex: 3, fit: FlexFit.loose, child: Text(value)),
// //       ],
// //     );
// //   }
// // }
//
//
//
// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// class viewsafetytips extends StatelessWidget {
//   const viewsafetytips({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Trip Viewer',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//         useMaterial3: true,
//       ),
//       home: const viewsafetytipspage(title: 'My Trips'),
//     );
//   }
// }
//
// class viewsafetytipspage extends StatefulWidget {
//   const viewsafetytipspage({super.key, required this.title});
//
//   final String title;
//
//   @override
//   State<viewsafetytipspage> createState() => _viewsafetytipspageState();
// }
//
// class _viewsafetytipspageState extends State<viewsafetytipspage> {
//   List<String> id_ = [];
//   List<String> tittle_ = [];
//   List<String> date_ = [];
//   List<String> officer_ = [];
//   List<String> description_ = [];
//   bool isLoading = true;
//
//   @override
//   void initState() {
//     super.initState();
//     load();
//   }
//
//   Future<void> load() async {
//     List<String> id = [];
//     List<String> tittle = [];
//     List<String> date = [];
//     List<String> officer = [];
//     List<String> description = [];
//
//     try {
//       final pref = await SharedPreferences.getInstance();
//       String ip = pref.getString("url").toString();
//
//       String url = "$ip/user_viewsafetytips/";
//       print(url);
//
//       var data = await http.post(Uri.parse(url));
//       var jsondata = json.decode(data.body);
//       String stat = jsondata['status'];
//
//       var arr = jsondata["data"];
//
//       print(arr);
//       print(arr.length);
//
//       for (int i = 0; i < arr.length; i++) {
//         id.add(arr[i]['id'].toString());
//         tittle.add(arr[i]['tittle']);
//         date.add(arr[i]['date'].toString());
//         officer.add(arr[i]['officer'].toString());
//         description.add(arr[i]['description'].toString());
//       }
//
//       setState(() {
//         id_ = id;
//         tittle_ = tittle;
//         date_ = date;
//         officer_ = officer;
//         description_ = description;
//         isLoading = false;
//       });
//
//       print(stat);
//     } catch (e) {
//       print("Error ------------------- $e");
//       setState(() {
//         isLoading = false;
//       });
//     }
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           "VIEW tips",
//           style: TextStyle(color: Colors.white),
//         ),
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//       ),
//
//       body: ListView.builder(
//         physics: const BouncingScrollPhysics(),
//         itemCount: id_.length,
//         itemBuilder: (BuildContext context, int index) {
//           return ListTile(
//             title: Padding(
//               padding: const EdgeInsets.all(4.0),
//               child: Column(
//                 children: [
//                   Container(
//                     width: MediaQuery.of(context).size.width,
//                     height: 250,
//                     child: Card(
//                       clipBehavior: Clip.antiAliasWithSaveLayer,
//                       child: Padding(
//                         padding: const EdgeInsets.all(10.0),
//                         child: Column(
//                           children: [
//                             const SizedBox(height: 10),
//
//                             buildRow("Title", tittle_[index]),
//                             const SizedBox(height: 10),
//
//                             buildRow("Date", date_[index]),
//                             const SizedBox(height: 10),
//
//                             buildRow("Officer", officer_[index]),
//                             const SizedBox(height: 10),
//
//                             buildRow("Description", description_[index]),
//                             const SizedBox(height: 10),
//
//                           ],
//                         ),
//                       ),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(10.0),
//                       ),
//                       elevation: 5,
//                       margin: const EdgeInsets.all(10),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
//
//   Widget buildRow(String label, String value) {
//     return Row(
//       children: [
//         const SizedBox(width: 10),
//         Flexible(flex: 2, fit: FlexFit.loose, child: Text(label)),
//         Flexible(flex: 3, fit: FlexFit.loose, child: Text(value)),
//       ],
//     );
//   }
// }

// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// // class viewsafetytips extends StatelessWidget {
// //   const viewsafetytips({super.key});
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       title: 'Safety Tips',
// //       theme: ThemeData(
// //         primaryColor: const Color(0xFF0a2463),
// //         colorScheme: ColorScheme.fromSeed(
// //           seedColor: const Color(0xFF0a2463),
// //           primary: const Color(0xFF0a2463),
// //           secondary: const Color(0xFF3b82f6),
// //         ),
// //         useMaterial3: true,
// //       ),
// //       home: const viewsafetytipspage(title: 'Safety Tips'),
// //     );
// //   }
// // }
// // class viewsafetytips extends StatelessWidget {
// //   const viewsafetytips({super.key});
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return const viewsafetytipspage(title: 'Safety Tips');
// //   }
// // }
// class viewsafetytips extends StatelessWidget {
//   const viewsafetytips({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return const viewsafetytipspage(title: 'Safety Tips');  // ✅ Direct widget
//   }
// }
//
// class viewsafetytipspage extends StatefulWidget {
//   const viewsafetytipspage({super.key, required this.title});
//
//   final String title;
//
//   @override
//   State<viewsafetytipspage> createState() => _viewsafetytipspageState();
// }
//
// class _viewsafetytipspageState extends State<viewsafetytipspage> {
//   List<String> id_ = [];
//   List<String> tittle_ = [];
//   List<String> date_ = [];
//   List<String> officer_ = [];
//   List<String> description_ = [];
//   bool isLoading = true;
//
//   @override
//   void initState() {
//     super.initState();
//     load();
//   }
//
//   Future<void> load() async {
//     List<String> id = [];
//     List<String> tittle = [];
//     List<String> date = [];
//     List<String> officer = [];
//     List<String> description = [];
//
//     try {
//       final pref = await SharedPreferences.getInstance();
//       String ip = pref.getString("url").toString();
//
//       String url = "$ip/user_viewsafetytips/";
//       print(url);
//
//       var data = await http.post(Uri.parse(url));
//       var jsondata = json.decode(data.body);
//       String stat = jsondata['status'];
//
//       var arr = jsondata["data"];
//
//       print(arr);
//       print(arr.length);
//
//       for (int i = 0; i < arr.length; i++) {
//         id.add(arr[i]['id'].toString());
//         tittle.add(arr[i]['tittle']);
//         date.add(arr[i]['date'].toString());
//         officer.add(arr[i]['officer'].toString());
//         description.add(arr[i]['description'].toString());
//       }
//
//       setState(() {
//         id_ = id;
//         tittle_ = tittle;
//         date_ = date;
//         officer_ = officer;
//         description_ = description;
//         isLoading = false;
//       });
//
//       print(stat);
//     } catch (e) {
//       print("Error ------------------- $e");
//       setState(() {
//         isLoading = false;
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFF050b1f),
//       appBar: AppBar(
//         elevation: 0,
//         backgroundColor: const Color(0xFF0a2463),
//         title: Row(
//           children: [
//             Container(
//               padding: const EdgeInsets.all(8),
//               decoration: BoxDecoration(
//                 gradient: const LinearGradient(
//                   colors: [Color(0xFF3b82f6), Color(0xFF60a5fa)],
//                 ),
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               child: const Icon(
//                 Icons.shield_outlined,
//                 color: Colors.white,
//                 size: 24,
//               ),
//             ),
//             const SizedBox(width: 12),
//             const Text(
//               "Safety Tips",
//               style: TextStyle(
//                 color: Colors.white,
//                 fontWeight: FontWeight.bold,
//                 fontSize: 20,
//               ),
//             ),
//           ],
//         ),
//         leading: IconButton(
//           icon: Container(
//             padding: const EdgeInsets.all(8),
//             decoration: BoxDecoration(
//               color: Colors.white.withOpacity(0.1),
//               borderRadius: BorderRadius.circular(8),
//             ),
//             child: const Icon(Icons.arrow_back, color: Colors.white),
//           ),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.refresh, color: Colors.white),
//             onPressed: () {
//               setState(() {
//                 isLoading = true;
//               });
//               load();
//             },
//           ),
//         ],
//       ),
//       body: isLoading
//           ? Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Container(
//               padding: const EdgeInsets.all(20),
//               decoration: BoxDecoration(
//                 gradient: const LinearGradient(
//                   colors: [Color(0xFF3b82f6), Color(0xFF60a5fa)],
//                 ),
//                 borderRadius: BorderRadius.circular(20),
//               ),
//               child: const CircularProgressIndicator(
//                 color: Colors.white,
//                 strokeWidth: 3,
//               ),
//             ),
//             const SizedBox(height: 20),
//             const Text(
//               "Loading safety tips...",
//               style: TextStyle(
//                 color: Colors.white70,
//                 fontSize: 16,
//                 fontWeight: FontWeight.w500,
//               ),
//             ),
//           ],
//         ),
//       )
//           : id_.isEmpty
//           ? Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Container(
//               padding: const EdgeInsets.all(30),
//               decoration: BoxDecoration(
//                 gradient: LinearGradient(
//                   colors: [
//                     const Color(0xFF3b82f6).withOpacity(0.2),
//                     const Color(0xFF60a5fa).withOpacity(0.2),
//                   ],
//                 ),
//                 shape: BoxShape.circle,
//               ),
//               child: const Icon(
//                 Icons.lightbulb_outline,
//                 size: 80,
//                 color: Color(0xFF3b82f6),
//               ),
//             ),
//             const SizedBox(height: 20),
//             const Text(
//               "No safety tips available",
//               style: TextStyle(
//                 color: Colors.white,
//                 fontSize: 20,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             const SizedBox(height: 10),
//             const Text(
//               "Safety tips will appear here when posted",
//               style: TextStyle(
//                 color: Colors.white60,
//                 fontSize: 14,
//               ),
//             ),
//           ],
//         ),
//       )
//           : ListView.builder(
//         physics: const BouncingScrollPhysics(),
//         padding: const EdgeInsets.all(16),
//         itemCount: id_.length,
//         itemBuilder: (BuildContext context, int index) {
//           return SafetyTipCard(
//             title: tittle_[index],
//             date: date_[index],
//             officer: officer_[index],
//             description: description_[index],
//             index: index,
//           );
//         },
//       ),
//     );
//   }
// }
//
// class SafetyTipCard extends StatelessWidget {
//   final String title;
//   final String date;
//   final String officer;
//   final String description;
//   final int index;
//
//   const SafetyTipCard({
//     Key? key,
//     required this.title,
//     required this.date,
//     required this.officer,
//     required this.description,
//     required this.index,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.only(bottom: 16),
//       decoration: BoxDecoration(
//         gradient: const LinearGradient(
//           begin: Alignment.topLeft,
//           end: Alignment.bottomRight,
//           colors: [Colors.white, Color(0xFFF8FAFC)],
//         ),
//         borderRadius: BorderRadius.circular(20),
//         boxShadow: [
//           BoxShadow(
//             color: const Color(0xFF3b82f6).withOpacity(0.2),
//             blurRadius: 20,
//             offset: const Offset(0, 10),
//           ),
//         ],
//       ),
//       child: Stack(
//         children: [
//           // Top accent bar
//           Positioned(
//             top: 0,
//             left: 0,
//             right: 0,
//             child: Container(
//               height: 5,
//               decoration: const BoxDecoration(
//                 gradient: LinearGradient(
//                   colors: [Color(0xFF3b82f6), Color(0xFF60a5fa)],
//                 ),
//                 borderRadius: BorderRadius.only(
//                   topLeft: Radius.circular(20),
//                   topRight: Radius.circular(20),
//                 ),
//               ),
//             ),
//           ),
//
//           Padding(
//             padding: const EdgeInsets.all(20),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // Header with tip number and icon
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Container(
//                       padding: const EdgeInsets.symmetric(
//                         horizontal: 12,
//                         vertical: 6,
//                       ),
//                       decoration: BoxDecoration(
//                         gradient: const LinearGradient(
//                           colors: [Color(0xFF3b82f6), Color(0xFF60a5fa)],
//                         ),
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                       child: Row(
//                         children: [
//                           const Icon(
//                             Icons.lightbulb,
//                             color: Colors.white,
//                             size: 16,
//                           ),
//                           const SizedBox(width: 6),
//                           Text(
//                             "Tip #${index + 1}",
//                             style: const TextStyle(
//                               color: Colors.white,
//                               fontWeight: FontWeight.bold,
//                               fontSize: 12,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     Container(
//                       padding: const EdgeInsets.all(8),
//                       decoration: BoxDecoration(
//                         gradient: LinearGradient(
//                           colors: [
//                             const Color(0xFF10b981).withOpacity(0.2),
//                             const Color(0xFF34d399).withOpacity(0.2),
//                           ],
//                         ),
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                       child: const Icon(
//                         Icons.shield_outlined,
//                         color: Color(0xFF10b981),
//                         size: 24,
//                       ),
//                     ),
//                   ],
//                 ),
//
//                 const SizedBox(height: 20),
//
//                 // Title Section
//                 Container(
//                   width: double.infinity,
//                   padding: const EdgeInsets.all(16),
//                   decoration: BoxDecoration(
//                     gradient: LinearGradient(
//                       colors: [
//                         const Color(0xFF3b82f6).withOpacity(0.1),
//                         const Color(0xFF60a5fa).withOpacity(0.05),
//                       ],
//                     ),
//                     borderRadius: BorderRadius.circular(12),
//                     border: Border.all(
//                       color: const Color(0xFF3b82f6).withOpacity(0.2),
//                     ),
//                   ),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Row(
//                         children: [
//                           Container(
//                             padding: const EdgeInsets.all(6),
//                             decoration: BoxDecoration(
//                               color: const Color(0xFF3b82f6),
//                               borderRadius: BorderRadius.circular(6),
//                             ),
//                             child: const Icon(
//                               Icons.title,
//                               color: Colors.white,
//                               size: 16,
//                             ),
//                           ),
//                           const SizedBox(width: 8),
//                           Text(
//                             "TITLE",
//                             style: TextStyle(
//                               color: Colors.grey[600],
//                               fontSize: 11,
//                               fontWeight: FontWeight.w600,
//                               letterSpacing: 1,
//                             ),
//                           ),
//                         ],
//                       ),
//                       const SizedBox(height: 10),
//                       Text(
//                         title,
//                         style: TextStyle(
//                           color: Colors.grey[900],
//                           fontSize: 18,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//
//                 const SizedBox(height: 16),
//
//                 // Date and Officer Info
//                 Row(
//                   children: [
//                     Expanded(
//                       child: _buildInfoBox(
//                         icon: Icons.calendar_today,
//                         label: "DATE",
//                         value: date,
//                         color: const Color(0xFF10b981),
//                       ),
//                     ),
//                     const SizedBox(width: 12),
//                     Expanded(
//                       child: _buildInfoBox(
//                         icon: Icons.person_outline,
//                         label: "OFFICER",
//                         value: officer,
//                         color: const Color(0xFFf59e0b),
//                       ),
//                     ),
//                   ],
//                 ),
//
//                 const SizedBox(height: 16),
//
//                 // Description Section
//                 Container(
//                   width: double.infinity,
//                   padding: const EdgeInsets.all(16),
//                   decoration: BoxDecoration(
//                     color: Colors.grey[50],
//                     borderRadius: BorderRadius.circular(12),
//                     border: Border.all(
//                       color: Colors.grey[200]!,
//                     ),
//                   ),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Row(
//                         children: [
//                           Container(
//                             padding: const EdgeInsets.all(6),
//                             decoration: BoxDecoration(
//                               color: const Color(0xFF6366f1),
//                               borderRadius: BorderRadius.circular(6),
//                             ),
//                             child: const Icon(
//                               Icons.description,
//                               color: Colors.white,
//                               size: 16,
//                             ),
//                           ),
//                           const SizedBox(width: 8),
//                           Text(
//                             "DESCRIPTION",
//                             style: TextStyle(
//                               color: Colors.grey[600],
//                               fontSize: 11,
//                               fontWeight: FontWeight.w600,
//                               letterSpacing: 1,
//                             ),
//                           ),
//                         ],
//                       ),
//                       const SizedBox(height: 10),
//                       Text(
//                         description,
//                         style: TextStyle(
//                           color: Colors.grey[800],
//                           fontSize: 14,
//                           height: 1.6,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildInfoBox({
//     required IconData icon,
//     required String label,
//     required String value,
//     required Color color,
//   }) {
//     return Container(
//       padding: const EdgeInsets.all(12),
//       decoration: BoxDecoration(
//         color: color.withOpacity(0.05),
//         borderRadius: BorderRadius.circular(12),
//         border: Border.all(
//           color: color.withOpacity(0.2),
//           width: 1,
//         ),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               Container(
//                 padding: const EdgeInsets.all(4),
//                 decoration: BoxDecoration(
//                   color: color,
//                   borderRadius: BorderRadius.circular(6),
//                 ),
//                 child: Icon(
//                   icon,
//                   color: Colors.white,
//                   size: 14,
//                 ),
//               ),
//               const SizedBox(width: 6),
//               Text(
//                 label,
//                 style: TextStyle(
//                   color: Colors.grey[600],
//                   fontSize: 10,
//                   fontWeight: FontWeight.w600,
//                   letterSpacing: 0.5,
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 8),
//           Text(
//             value,
//             style: TextStyle(
//               color: Colors.grey[900],
//               fontSize: 13,
//               fontWeight: FontWeight.w600,
//             ),
//             maxLines: 1,
//             overflow: TextOverflow.ellipsis,
//           ),
//         ],
//       ),
//     );
//   }
// }


import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:ui';

// --- Theme Constants (Synced with your Marine Project Theme) ---
class MarineTheme {
  static const Color background = Color(0xFF050b1f);
  static const Color surface = Color(0xFF1E293B);
  static const Color primary = Color(0xFF38BDF8); // Electric Blue
  static const Color secondary = Color(0xFF0EA5E9);
  static const Color accent = Color(0xFF10b981); // Emerald for safety
  static const Color textMain = Colors.white;
  static const Color textMuted = Color(0xFF94A3B8);
}

class viewsafetytips extends StatelessWidget {
  const viewsafetytips({super.key});

  @override
  Widget build(BuildContext context) {
    return const viewsafetytipspage(title: 'Safety Guidelines');
  }
}

class viewsafetytipspage extends StatefulWidget {
  const viewsafetytipspage({super.key, required this.title});
  final String title;

  @override
  State<viewsafetytipspage> createState() => _viewsafetytipspageState();
}

class _viewsafetytipspageState extends State<viewsafetytipspage> {
  List<Map<String, dynamic>> tips = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    load();
  }

  Future<void> load() async {
    try {
      final pref = await SharedPreferences.getInstance();
      String ip = pref.getString("url") ?? "";
      String url = "$ip/user_viewsafetytips/";

      var response = await http.post(Uri.parse(url)).timeout(const Duration(seconds: 10));
      var jsondata = json.decode(response.body);

      if (jsondata['status'] == 'ok') {
        setState(() {
          tips = List<Map<String, dynamic>>.from(jsondata["data"]);
          isLoading = false;
        });
      }
    } catch (e) {
      debugPrint("Error: $e");
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MarineTheme.background,
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: AppBar(
              backgroundColor: MarineTheme.background.withOpacity(0.7),
              elevation: 0,
              centerTitle: false,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white, size: 20),
                onPressed: () => Navigator.pop(context),
              ),
              title: const Text(
                "Safety Protocol",
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 22),
              ),
              actions: [
                IconButton(
                  icon: const Icon(Icons.refresh_rounded, color: MarineTheme.primary),
                  onPressed: () {
                    setState(() => isLoading = true);
                    load();
                  },
                ),
                const SizedBox(width: 8),
              ],
            ),
          ),
        ),
      ),
      body: isLoading
          ? _buildLoader()
          : tips.isEmpty
          ? _buildEmptyState()
          : _buildList(),
    );
  }

  Widget _buildLoader() {
    return Center(
      child: CircularProgressIndicator(
        color: MarineTheme.primary,
        backgroundColor: MarineTheme.surface,
        strokeWidth: 3,
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.verified_user_outlined, size: 80, color: MarineTheme.textMuted.withOpacity(0.2)),
          const SizedBox(height: 16),
          const Text("All Clear", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
          const Text("Check back later for safety updates.", style: TextStyle(color: MarineTheme.textMuted)),
        ],
      ),
    );
  }

  Widget _buildList() {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(16, 110, 16, 20),
      itemCount: tips.length,
      itemBuilder: (context, index) {
        final item = tips[index];
        return SafetyTipCard(
          title: item['tittle'] ?? "",
          date: item['date'].toString(),
          officer: item['officer'].toString(),
          description: item['description'].toString(),
          index: index,
        );
      },
    );
  }
}

class SafetyTipCard extends StatelessWidget {
  final String title;
  final String date;
  final String officer;
  final String description;
  final int index;

  const SafetyTipCard({
    Key? key,
    required this.title,
    required this.date,
    required this.officer,
    required this.description,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: MarineTheme.surface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Stack(
          children: [
            // Decorative Background Icon
            Positioned(
              right: -20,
              top: -20,
              child: Icon(
                Icons.shield_rounded,
                size: 120,
                color: MarineTheme.accent.withOpacity(0.03),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Top Row: Tip Label and Date
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: MarineTheme.primary.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          "ADVISORY ${index + 1}",
                          style: const TextStyle(
                            color: MarineTheme.primary,
                            fontSize: 10,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 1.2,
                          ),
                        ),
                      ),
                      Text(
                        date,
                        style: const TextStyle(color: MarineTheme.textMuted, fontSize: 12),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // Title
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      letterSpacing: -0.5,
                    ),
                  ),

                  const SizedBox(height: 12),

                  // Officer Badge
                  Row(
                    children: [
                      const Icon(Icons.verified_user_rounded, color: MarineTheme.accent, size: 14),
                      const SizedBox(width: 6),
                      Text(
                        "Issued by $officer",
                        style: const TextStyle(
                          color: MarineTheme.accent,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),

                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: Divider(color: Colors.white10, height: 1),
                  ),

                  // Description
                  Text(
                    description,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.7),
                      fontSize: 14,
                      height: 1.6,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}