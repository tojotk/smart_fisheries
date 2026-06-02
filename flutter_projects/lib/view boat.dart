// // import 'dart:convert';
// // import 'package:http/http.dart' as http;
// // import 'package:flutter/material.dart';
// // import 'package:shared_preferences/shared_preferences.dart';
// //
// // import 'home.dart';
// //
// // class viewtrip extends StatelessWidget {
// //   const viewtrip({super.key});
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       title: 'Flutter Demo',
// //       theme: ThemeData(
// //         primarySwatch: Colors.red,
// //       ),
// //       home: const viewboat(title: 'Flutter Demo Home Page'),
// //     );
// //   }
// // }
// //
// // class viewboat extends StatefulWidget {
// //   const viewboat({super.key, required this.title});
// //
// //   final String title;
// //
// //   @override
// //   State<viewboat> createState() => _viewboatState();
// // }
// //
// // class _viewboatState extends State<viewboat> {
// //   List<String> id_ = [];
// //   List<String> owner_ = [];
// //   List<String> regno_ = [];
// //   List<String> capacity_ = [];
// //   List<String> type_ = [];
// //   List<String> status_ = [];
// //
// //
// //   @override
// //   void initState() {
// //     super.initState();
// //     load();
// //   }
// //
// //   Future<void> load() async {
// //     List<String> id = [];
// //     List<String> owner = [];
// //     List<String> regno = [];
// //     List<String> capacity = [];
// //     List<String> type = [];
// //     List<String> status = [];
// //
// //     try {
// //       final pref = await SharedPreferences.getInstance();
// //       String ip = pref.getString("url").toString();
// //
// //       String url = "$ip/user_viewboat/";
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
// //         owner.add(arr[i]['owner']);
// //         print(arr[i]['owner']);
// //         regno.add(arr[i]['regno'].toString());
// //         print(arr[i]['regno']);
// //         capacity.add(arr[i]['capacity'].toString());
// //         print(arr[i]['capacity']);
// //         type.add(arr[i]['type'].toString());
// //         print(arr[i]['type']);
// //         status.add(arr[i]['status'].toString());
// //         print(arr[i]['status']);
// //
// //       }
// //
// //       setState(() {
// //         id_ = id;
// //         owner_ = owner;
// //         regno_ = regno;
// //         capacity_ = capacity;
// //         type_ = type;
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
// //
// //           Navigator.push(
// //             context,
// //             MaterialPageRoute(
// //               builder: (context) => const Home(
// //
// //               ),
// //             ),
// //           );
// //
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
// //                             buildRow("STOP PLACE", owner_[index]),
// //                             const SizedBox(height: 10),
// //
// //                             buildRow("START TIME", regno_[index]),
// //                             const SizedBox(height: 10),
// //
// //                             buildRow("END TIME", capacity_[index]),
// //                             const SizedBox(height: 10),
// //
// //                             buildRow("FROM", type_[index]),
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
// import 'dart:convert';
// import 'package:fisheries/home.dart';
// import 'package:http/http.dart' as http;
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
//
// class viewtrip extends StatelessWidget {
//   const viewtrip({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Trip Viewer',
//       theme: ThemeData(
//         primaryColor: const Color(0xFF0a2463),
//         colorScheme: ColorScheme.fromSeed(
//           seedColor: const Color(0xFF0a2463),
//           primary: const Color(0xFF0a2463),
//           secondary: const Color(0xFF3b82f6),
//         ),
//         useMaterial3: true,
//       ),
//       home: const viewboat(title: 'View Trips'),
//     );
//   }
// }
//
// class viewboat extends StatefulWidget {
//   const viewboat({super.key, required this.title});
//
//   final String title;
//
//   @override
//   State<viewboat> createState() => _viewboatState();
// }
//
// class _viewboatState extends State<viewboat> {
//   List<String> id_ = [];
//   List<String> owner_ = [];
//   List<String> regno_ = [];
//   List<String> capacity_ = [];
//   List<String> type_ = [];
//   List<String> status_ = [];
//
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
//     List<String> owner = [];
//     List<String> regno = [];
//     List<String> capacity = [];
//     List<String> type = [];
//     List<String> status = [];
//
//     try {
//       final pref = await SharedPreferences.getInstance();
//       String ip = pref.getString("url").toString();
//
//       String url = "$ip/user_viewboat/";
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
//         owner.add(arr[i]['owner']);
//         print(arr[i]['owner']);
//         regno.add(arr[i]['regno'].toString());
//         print(arr[i]['regno']);
//         capacity.add(arr[i]['capacity'].toString());
//         print(arr[i]['capacity']);
//         type.add(arr[i]['type'].toString());
//         print(arr[i]['type']);
//         status.add(arr[i]['status'].toString());
//         print(arr[i]['status']);
//       }
//
//       setState(() {
//         id_ = id;
//         owner_ = owner;
//         regno_ = regno;
//         capacity_ = capacity;
//         type_ = type;
//         status_ = status;
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
//                 Icons.sailing,
//                 color: Colors.white,
//                 size: 24,
//               ),
//             ),
//             const SizedBox(width: 12),
//             const Text(
//               "View Boats",
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
//             Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (context) => const Home(),
//               ),
//             );
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
//               "Loading trips...",
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
//                 Icons.inbox_outlined,
//                 size: 80,
//                 color: Color(0xFF3b82f6),
//               ),
//             ),
//             const SizedBox(height: 20),
//             const Text(
//               "No trips found",
//               style: TextStyle(
//                 color: Colors.white,
//                 fontSize: 20,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             const SizedBox(height: 10),
//             const Text(
//               "Your trip history will appear here",
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
//           return TripCard(
//             owner: owner_[index],
//             regno: regno_[index],
//             capacity: capacity_[index],
//             type: type_[index],
//             status: status_[index],
//             index: index,
//           );
//         },
//       ),
//     );
//   }
// }
//
// class TripCard extends StatelessWidget {
//   final String owner;
//   final String regno;
//   final String capacity;
//   final String type;
//   final String status;
//   final int index;
//
//   const TripCard({
//     Key? key,
//     required this.owner,
//     required this.regno,
//     required this.capacity,
//     required this.type,
//     required this.status,
//     required this.index,
//   }) : super(key: key);
//
//   Color _getStatusColor() {
//     switch (status.toLowerCase()) {
//       case 'completed':
//         return const Color(0xFF10b981);
//       case 'pending':
//         return const Color(0xFFf59e0b);
//       case 'cancelled':
//         return const Color(0xFFef4444);
//       default:
//         return const Color(0xFF3b82f6);
//     }
//   }
//
//   IconData _getStatusIcon() {
//     switch (status.toLowerCase()) {
//       case 'completed':
//         return Icons.check_circle;
//       case 'pending':
//         return Icons.access_time;
//       case 'cancelled':
//         return Icons.cancel;
//       default:
//         return Icons.info;
//     }
//   }
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
//                 // Header with trip number
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
//                       child: Text(
//                         "Trip #${index + 1}",
//                         style: const TextStyle(
//                           color: Colors.white,
//                           fontWeight: FontWeight.bold,
//                           fontSize: 12,
//                         ),
//                       ),
//                     ),
//                     Container(
//                       padding: const EdgeInsets.symmetric(
//                         horizontal: 12,
//                         vertical: 6,
//                       ),
//                       decoration: BoxDecoration(
//                         color: _getStatusColor().withOpacity(0.1),
//                         borderRadius: BorderRadius.circular(10),
//                         border: Border.all(
//                           color: _getStatusColor().withOpacity(0.3),
//                         ),
//                       ),
//                       child: Row(
//                         children: [
//                           Icon(
//                             _getStatusIcon(),
//                             size: 14,
//                             color: _getStatusColor(),
//                           ),
//                           const SizedBox(width: 4),
//                           Text(
//                             status.toUpperCase(),
//                             style: TextStyle(
//                               color: _getStatusColor(),
//                               fontWeight: FontWeight.bold,
//                               fontSize: 11,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//
//                 const SizedBox(height: 20),
//
//                 // Trip details
//                 _buildInfoRow(
//                   icon: Icons.location_on,
//                   label: "STOP PLACE",
//                   value: owner,
//                   color: const Color(0xFF3b82f6),
//                 ),
//                 const SizedBox(height: 12),
//
//                 _buildInfoRow(
//                   icon: Icons.access_time,
//                   label: "START TIME",
//                   value: regno,
//                   color: const Color(0xFF10b981),
//                 ),
//                 const SizedBox(height: 12),
//
//                 _buildInfoRow(
//                   icon: Icons.timer_off,
//                   label: "END TIME",
//                   value: capacity,
//                   color: const Color(0xFFef4444),
//                 ),
//                 const SizedBox(height: 12),
//
//                 _buildInfoRow(
//                   icon: Icons.directions_boat,
//                   label: "FROM",
//                   value: type,
//                   color: const Color(0xFFf59e0b),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildInfoRow({
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
//       child: Row(
//         children: [
//           Container(
//             padding: const EdgeInsets.all(8),
//             decoration: BoxDecoration(
//               color: color.withOpacity(0.1),
//               borderRadius: BorderRadius.circular(8),
//             ),
//             child: Icon(
//               icon,
//               size: 20,
//               color: color,
//             ),
//           ),
//           const SizedBox(width: 12),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   label,
//                   style: TextStyle(
//                     color: Colors.grey[600],
//                     fontSize: 11,
//                     fontWeight: FontWeight.w600,
//                     letterSpacing: 0.5,
//                   ),
//                 ),
//                 const SizedBox(height: 4),
//                 Text(
//                   value,
//                   style: TextStyle(
//                     color: Colors.grey[900],
//                     fontSize: 15,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// // ✅ Remove MaterialApp wrapper, return widget directly
// class viewboat extends StatelessWidget {
//   final String title;
//
//   const viewboat({super.key, required this.title});
//
//   @override
//   Widget build(BuildContext context) {
//     return viewboatpage(title: title);  // ✅ Direct widget, no MaterialApp
//   }
// }
//
// // ✅ Renamed from 'viewboat' to 'viewboatpage' to avoid confusion
// class viewboatpage extends StatefulWidget {
//   const viewboatpage({super.key, required this.title});
//
//   final String title;
//
//   @override
//   State<viewboatpage> createState() => _viewboatpageState();
// }
//
// class _viewboatpageState extends State<viewboatpage> {
//   List<String> id_ = [];
//   List<String> owner_ = [];
//   List<String> regno_ = [];
//   List<String> capacity_ = [];
//   List<String> type_ = [];
//   List<String> status_ = [];
//
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
//     List<String> owner = [];
//     List<String> regno = [];
//     List<String> capacity = [];
//     List<String> type = [];
//     List<String> status = [];
//
//     try {
//       final pref = await SharedPreferences.getInstance();
//       String ip = pref.getString("url").toString();
//       String lid = pref.getString("lid").toString();
//
//       String url = "$ip/user_viewboat/";
//       print(url);
//
//       var data = await http.post(Uri.parse(url),body: {'lid':lid});
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
//         owner.add(arr[i]['owner']);
//         print(arr[i]['owner']);
//         regno.add(arr[i]['regno'].toString());
//         print(arr[i]['regno']);
//         capacity.add(arr[i]['capacity'].toString());
//         print(arr[i]['capacity']);
//         type.add(arr[i]['type'].toString());
//         print(arr[i]['type']);
//         status.add(arr[i]['status'].toString());
//         print(arr[i]['status']);
//       }
//
//       setState(() {
//         id_ = id;
//         owner_ = owner;
//         regno_ = regno;
//         capacity_ = capacity;
//         type_ = type;
//         status_ = status;
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
//                 Icons.sailing,
//                 color: Colors.white,
//                 size: 24,
//               ),
//             ),
//             const SizedBox(width: 12),
//             const Text(
//               "View Boats",
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
//             Navigator.pop(context);  // ✅ Changed from push to pop
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
//               "Loading boats...",  // ✅ Changed text
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
//                 Icons.directions_boat_outlined,
//                 size: 80,
//                 color: Color(0xFF3b82f6),
//               ),
//             ),
//             const SizedBox(height: 20),
//             const Text(
//               "No boats found",
//               style: TextStyle(
//                 color: Colors.white,
//                 fontSize: 20,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             const SizedBox(height: 10),
//             const Text(
//               "Registered boats will appear here",
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
//           return BoatCard(  // ✅ Renamed from TripCard
//             owner: owner_[index],
//             regno: regno_[index],
//             capacity: capacity_[index],
//             type: type_[index],
//             status: status_[index],
//             index: index,
//           );
//         },
//       ),
//     );
//   }
// }
//
// // ✅ Renamed from TripCard to BoatCard
// class BoatCard extends StatelessWidget {
//   final String owner;
//   final String regno;
//   final String capacity;
//   final String type;
//   final String status;
//   final int index;
//
//   const BoatCard({
//     Key? key,
//     required this.owner,
//     required this.regno,
//     required this.capacity,
//     required this.type,
//     required this.status,
//     required this.index,
//   }) : super(key: key);
//
//   Color _getStatusColor() {
//     switch (status.toLowerCase()) {
//       case 'active':
//       case 'approved':
//         return const Color(0xFF10b981);
//       case 'pending':
//         return const Color(0xFFf59e0b);
//       case 'inactive':
//       case 'rejected':
//         return const Color(0xFFef4444);
//       default:
//         return const Color(0xFF3b82f6);
//     }
//   }
//
//   IconData _getStatusIcon() {
//     switch (status.toLowerCase()) {
//       case 'active':
//       case 'approved':
//         return Icons.check_circle;
//       case 'pending':
//         return Icons.access_time;
//       case 'inactive':
//       case 'rejected':
//         return Icons.cancel;
//       default:
//         return Icons.info;
//     }
//   }
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
//                 // Header with boat number
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
//                             Icons.directions_boat,
//                             color: Colors.white,
//                             size: 16,
//                           ),
//                           const SizedBox(width: 6),
//                           Text(
//                             "Boat #${index + 1}",
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
//                       padding: const EdgeInsets.symmetric(
//                         horizontal: 12,
//                         vertical: 6,
//                       ),
//                       decoration: BoxDecoration(
//                         color: _getStatusColor().withOpacity(0.1),
//                         borderRadius: BorderRadius.circular(10),
//                         border: Border.all(
//                           color: _getStatusColor().withOpacity(0.3),
//                         ),
//                       ),
//                       child: Row(
//                         children: [
//                           Icon(
//                             _getStatusIcon(),
//                             size: 14,
//                             color: _getStatusColor(),
//                           ),
//                           const SizedBox(width: 4),
//                           Text(
//                             status.toUpperCase(),
//                             style: TextStyle(
//                               color: _getStatusColor(),
//                               fontWeight: FontWeight.bold,
//                               fontSize: 11,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//
//                 const SizedBox(height: 20),
//
//                 // Boat details
//                 _buildInfoRow(
//                   icon: Icons.person_outline,
//                   label: "OWNER",
//                   value: owner,
//                   color: const Color(0xFF3b82f6),
//                 ),
//                 const SizedBox(height: 12),
//
//                 _buildInfoRow(
//                   icon: Icons.confirmation_number,
//                   label: "REGISTRATION NO",
//                   value: regno,
//                   color: const Color(0xFF10b981),
//                 ),
//                 const SizedBox(height: 12),
//
//                 _buildInfoRow(
//                   icon: Icons.groups,
//                   label: "CAPACITY",
//                   value: capacity,
//                   color: const Color(0xFFf59e0b),
//                 ),
//                 const SizedBox(height: 12),
//
//                 _buildInfoRow(
//                   icon: Icons.category,
//                   label: "TYPE",
//                   value: type,
//                   color: const Color(0xFF8b5cf6),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildInfoRow({
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
//       child: Row(
//         children: [
//           Container(
//             padding: const EdgeInsets.all(8),
//             decoration: BoxDecoration(
//               color: color.withOpacity(0.1),
//               borderRadius: BorderRadius.circular(8),
//             ),
//             child: Icon(
//               icon,
//               size: 20,
//               color: color,
//             ),
//           ),
//           const SizedBox(width: 12),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   label,
//                   style: TextStyle(
//                     color: Colors.grey[600],
//                     fontSize: 11,
//                     fontWeight: FontWeight.w600,
//                     letterSpacing: 0.5,
//                   ),
//                 ),
//                 const SizedBox(height: 4),
//                 Text(
//                   value,
//                   style: TextStyle(
//                     color: Colors.grey[900],
//                     fontSize: 15,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//               ],
//             ),
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

// --- Global Marine Theme ---
class MarineTheme {
  static const Color background = Color(0xFF050B1F);
  static const Color surface = Color(0xFF161E35);
  static const Color primary = Color(0xFF38BDF8);
  static const Color success = Color(0xFF10B981);
  static const Color warning = Color(0xFFF59E0B);
  static const Color error = Color(0xFFEF4444);
  static const Color textMain = Colors.white;
  static const Color textMuted = Color(0xFF94A3B8);
}

class viewboat extends StatelessWidget {
  final String title;
  const viewboat({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return viewboatpage(title: title);
  }
}

class viewboatpage extends StatefulWidget {
  const viewboatpage({super.key, required this.title});
  final String title;

  @override
  State<viewboatpage> createState() => _viewboatpageState();
}

class _viewboatpageState extends State<viewboatpage> {
  List<dynamic> boatList = [];
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
      String lid = pref.getString("lid") ?? "";

      var response = await http.post(
          Uri.parse("$ip/user_viewboat/"),
          body: {'lid': lid}
      ).timeout(const Duration(seconds: 10));

      var jsondata = json.decode(response.body);

      if (jsondata['status'] == 'ok') {
        setState(() {
          boatList = jsondata["data"];
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
      appBar: _buildGlassAppBar(),
      body: isLoading ? _buildLoader() : (boatList.isEmpty ? _buildEmptyState() : _buildList()),
    );
  }

  PreferredSizeWidget _buildGlassAppBar() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(70),
      child: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
          child: AppBar(
            backgroundColor: MarineTheme.background.withOpacity(0.7),
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white, size: 20),
              onPressed: () => Navigator.pop(context),
            ),
            title: const Text(
              "Vessel Registry",
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 20),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.sync_rounded, color: MarineTheme.primary),
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
    );
  }

  Widget _buildLoader() {
    return Center(
      child: CircularProgressIndicator(color: MarineTheme.primary, strokeWidth: 2),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.anchor_outlined, size: 80, color: MarineTheme.textMuted.withOpacity(0.2)),
          const SizedBox(height: 16),
          const Text("No Boats Found", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
          const Text("Registered vessels will appear here.", style: TextStyle(color: MarineTheme.textMuted)),
        ],
      ),
    );
  }

  Widget _buildList() {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(16, 110, 16, 20),
      itemCount: boatList.length,
      itemBuilder: (context, index) {
        final boat = boatList[index];
        return BoatCard(
          owner: boat['owner']?.toString() ?? "Unknown",
          regno: boat['regno']?.toString() ?? "N/A",
          capacity: boat['capacity']?.toString() ?? "0",
          type: boat['type']?.toString() ?? "Standard",
          status: boat['status']?.toString() ?? "Pending",
          index: index,
        );
      },
    );
  }
}

class BoatCard extends StatelessWidget {
  final String owner;
  final String regno;
  final String capacity;
  final String type;
  final String status;
  final int index;

  const BoatCard({
    super.key,
    required this.owner,
    required this.regno,
    required this.capacity,
    required this.type,
    required this.status,
    required this.index,
  });

  Color _getStatusColor() {
    switch (status.toLowerCase()) {
      case 'active': case 'approved': return MarineTheme.success;
      case 'pending': return MarineTheme.warning;
      case 'inactive': case 'rejected': return MarineTheme.error;
      default: return MarineTheme.primary;
    }
  }

  @override
  Widget build(BuildContext context) {
    final statusColor = _getStatusColor();

    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: MarineTheme.surface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.4),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Stack(
          children: [
            // Background Decorative Icon
            Positioned(
              right: -10,
              bottom: -10,
              child: Icon(Icons.directions_boat_filled_rounded, size: 100, color: Colors.white.withOpacity(0.02)),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Card Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: MarineTheme.primary.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          "VESSEL #${index + 1}",
                          style: const TextStyle(color: MarineTheme.primary, fontSize: 11, fontWeight: FontWeight.w900, letterSpacing: 1),
                        ),
                      ),
                      _buildStatusBadge(statusColor),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Detail Items
                  _buildDetailItem(Icons.person_outline_rounded, "SHIP OWNER", owner),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 12),
                    child: Divider(color: Colors.white10, height: 1),
                  ),
                  Row(
                    children: [
                      Expanded(child: _buildDetailItem(Icons.pin_rounded, "REG NO", regno)),
                      Expanded(child: _buildDetailItem(Icons.groups_rounded, "CAPACITY", "$capacity Persons")),
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 12),
                    child: Divider(color: Colors.white10, height: 1),
                  ),
                  _buildDetailItem(Icons.category_outlined, "VESSEL TYPE", type),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusBadge(Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          const SizedBox(width: 8),
          Text(
            status.toUpperCase(),
            style: TextStyle(color: color, fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 0.5),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailItem(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, size: 18, color: MarineTheme.textMuted),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: const TextStyle(color: MarineTheme.textMuted, fontSize: 10, fontWeight: FontWeight.w600, letterSpacing: 0.5)),
            const SizedBox(height: 2),
            Text(value, style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)),
          ],
        ),
      ],
    );
  }
}