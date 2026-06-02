// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// class viewtrip extends StatelessWidget {
//   const viewtrip({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.red,
//       ),
//       home: const viewtrippage(title: 'Flutter Demo Home Page'),
//     );
//   }
// }
//
// class viewtrippage extends StatefulWidget {
//   const viewtrippage({super.key, required this.title});
//
//   final String title;
//
//   @override
//   State<viewtrippage> createState() => _viewtrippageState();
// }
//
// class _viewtrippageState extends State<viewtrippage> {
//   List<String> id_ = [];
//   List<String> boat_ = [];
//   List<String> start_date_ = [];
//   List<String> end_date_ = [];
//   List<String> From_ = [];
//   List<String> To_ = [];
//   List<String> status_ = [];
//
//   @override
//   void initState() {
//     super.initState();
//     load();
//   }
//
//   Future<void> load() async {
//     List<String> id = [];
//     List<String> boat = [];
//     List<String> start_date = [];
//     List<String> end_date = [];
//     List<String> From = [];
//     List<String> To = [];
//     List<String> status = [];
//
//     try {
//       final pref = await SharedPreferences.getInstance();
//       String ip = pref.getString("url").toString();
//
//       String url = "$ip/user_viewtrip/";
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
//         boat.add(arr[i]['boat']);
//         start_date.add(arr[i]['start_date'].toString());
//         end_date.add(arr[i]['end_date'].toString());
//         From.add(arr[i]['From'].toString());
//         To.add(arr[i]['To'].toString());
//         status.add(arr[i]['status'].toString());
//       }
//
//       setState(() {
//         id_ = id;
//         boat_ = boat;
//         start_date_ = start_date;
//         end_date_ = end_date;
//         From_ = From;
//         To_ = To;
//         status_ = status;
//       });
//
//       print(stat);
//     } catch (e) {
//       print("Error ------------------- $e");
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           "VIEW trip",
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
//                             buildRow("STOP PLACE", boat_[index]),
//                             const SizedBox(height: 10),
//
//                             buildRow("START TIME", start_date_[index]),
//                             const SizedBox(height: 10),
//
//                             buildRow("END TIME", end_date_[index]),
//                             const SizedBox(height: 10),
//
//                             buildRow("FROM", From_[index]),
//                             const SizedBox(height: 10),
//
//                             buildRow("TO", To_[index]),
//                             const SizedBox(height: 10),
//
//                             buildRow("STATUS", status_[index]),
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
// class viewtrip extends StatelessWidget {
//   const viewtrip({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Trip Viewer',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//         useMaterial3: true,
//       ),
//       home: const viewtrippage(title: 'My Trips'),
//     );
//   }
// }
//
// class viewtrippage extends StatefulWidget {
//   const viewtrippage({super.key, required this.title});
//
//   final String title;
//
//   @override
//   State<viewtrippage> createState() => _viewtrippageState();
// }
//
// class _viewtrippageState extends State<viewtrippage> {
//   List<String> id_ = [];
//   List<String> boat_ = [];
//   List<String> start_date_ = [];
//   List<String> end_date_ = [];
//   List<String> From_ = [];
//   List<String> To_ = [];
//   List<String> status_ = [];
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
//     List<String> boat = [];
//     List<String> start_date = [];
//     List<String> end_date = [];
//     List<String> From = [];
//     List<String> To = [];
//     List<String> status = [];
//
//     try {
//       final pref = await SharedPreferences.getInstance();
//       String ip = pref.getString("url").toString();
//       String lid = pref.getString("lid").toString();
//
//       String url = "$ip/user_viewtrip/";
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
//         boat.add(arr[i]['boat']);
//         start_date.add(arr[i]['start_date'].toString());
//         end_date.add(arr[i]['end_date'].toString());
//         From.add(arr[i]['From'].toString());
//         To.add(arr[i]['To'].toString());
//         status.add(arr[i]['status'].toString());
//       }
//
//       setState(() {
//         id_ = id;
//         boat_ = boat;
//         start_date_ = start_date;
//         end_date_ = end_date;
//         From_ = From;
//         To_ = To;
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
//   Color getStatusColor(String status) {
//     switch (status.toLowerCase()) {
//       case 'completed':
//         return Colors.green;
//       case 'pending':
//         return Colors.orange;
//       case 'cancelled':
//         return Colors.red;
//       case 'active':
//         return Colors.blue;
//       default:
//         return Colors.grey;
//     }
//   }
//
//   IconData getStatusIcon(String status) {
//     switch (status.toLowerCase()) {
//       case 'completed':
//         return Icons.check_circle;
//       case 'pending':
//         return Icons.schedule;
//       case 'cancelled':
//         return Icons.cancel;
//       case 'active':
//         return Icons.directions_boat;
//       default:
//         return Icons.info;
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       appBar: AppBar(
//         title: const Text(
//           "My Trips",
//           style: TextStyle(
//             color: Colors.white,
//             fontWeight: FontWeight.bold,
//             fontSize: 22,
//           ),
//         ),
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back, color: Colors.white),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//         backgroundColor: Colors.blue[700],
//         elevation: 0,
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
//             CircularProgressIndicator(
//               valueColor: AlwaysStoppedAnimation<Color>(Colors.blue[700]!),
//             ),
//             const SizedBox(height: 16),
//             const Text(
//               "Loading trips...",
//               style: TextStyle(
//                 fontSize: 16,
//                 color: Colors.grey,
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
//             Icon(
//               Icons.directions_boat_outlined,
//               size: 100,
//               color: Colors.grey[400],
//             ),
//             const SizedBox(height: 20),
//             Text(
//               "No trips found",
//               style: TextStyle(
//                 fontSize: 20,
//                 fontWeight: FontWeight.w500,
//                 color: Colors.grey[600],
//               ),
//             ),
//             const SizedBox(height: 8),
//             Text(
//               "Your trip history will appear here",
//               style: TextStyle(
//                 fontSize: 14,
//                 color: Colors.grey[500],
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
//           return Container(
//             margin: const EdgeInsets.only(bottom: 16),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(16),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.black.withOpacity(0.08),
//                   blurRadius: 10,
//                   offset: const Offset(0, 4),
//                 ),
//               ],
//             ),
//             child: ClipRRect(
//               borderRadius: BorderRadius.circular(16),
//               child: Column(
//                 children: [
//                   // Header with status
//                   Container(
//                     padding: const EdgeInsets.all(16),
//                     decoration: BoxDecoration(
//                       gradient: LinearGradient(
//                         colors: [
//                           Colors.blue[700]!,
//                           Colors.blue[500]!,
//                         ],
//                       ),
//                     ),
//                     child: Row(
//                       children: [
//                         Container(
//                           padding: const EdgeInsets.all(8),
//                           decoration: BoxDecoration(
//                             color: Colors.white.withOpacity(0.2),
//                             borderRadius: BorderRadius.circular(8),
//                           ),
//                           child: const Icon(
//                             Icons.directions_boat,
//                             color: Colors.white,
//                             size: 24,
//                           ),
//                         ),
//                         const SizedBox(width: 12),
//                         Expanded(
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 boat_[index],
//                                 style: const TextStyle(
//                                   color: Colors.white,
//                                   fontSize: 18,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                               const SizedBox(height: 4),
//                               Text(
//                                 "Trip #${id_[index]}",
//                                 style: TextStyle(
//                                   color: Colors.white.withOpacity(0.9),
//                                   fontSize: 12,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         Container(
//                           padding: const EdgeInsets.symmetric(
//                             horizontal: 12,
//                             vertical: 6,
//                           ),
//                           decoration: BoxDecoration(
//                             color: getStatusColor(status_[index]),
//                             borderRadius: BorderRadius.circular(20),
//                           ),
//                           child: Row(
//                             mainAxisSize: MainAxisSize.min,
//                             children: [
//                               Icon(
//                                 getStatusIcon(status_[index]),
//                                 color: Colors.white,
//                                 size: 16,
//                               ),
//                               const SizedBox(width: 4),
//                               Text(
//                                 status_[index].toUpperCase(),
//                                 style: const TextStyle(
//                                   color: Colors.white,
//                                   fontSize: 12,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//
//                   // Trip details
//                   Padding(
//                     padding: const EdgeInsets.all(16),
//                     child: Column(
//                       children: [
//                         // Route
//                         Row(
//                           children: [
//                             Expanded(
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(
//                                     "FROM",
//                                     style: TextStyle(
//                                       fontSize: 11,
//                                       fontWeight: FontWeight.w600,
//                                       color: Colors.grey[600],
//                                       letterSpacing: 0.5,
//                                     ),
//                                   ),
//                                   const SizedBox(height: 4),
//                                   Text(
//                                     From_[index],
//                                     style: const TextStyle(
//                                       fontSize: 16,
//                                       fontWeight: FontWeight.w600,
//                                       color: Colors.black87,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             Container(
//                               padding: const EdgeInsets.all(8),
//                               decoration: BoxDecoration(
//                                 color: Colors.blue[50],
//                                 shape: BoxShape.circle,
//                               ),
//                               child: Icon(
//                                 Icons.arrow_forward,
//                                 color: Colors.blue[700],
//                                 size: 20,
//                               ),
//                             ),
//                             Expanded(
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.end,
//                                 children: [
//                                   Text(
//                                     "TO",
//                                     style: TextStyle(
//                                       fontSize: 11,
//                                       fontWeight: FontWeight.w600,
//                                       color: Colors.grey[600],
//                                       letterSpacing: 0.5,
//                                     ),
//                                   ),
//                                   const SizedBox(height: 4),
//                                   Text(
//                                     To_[index],
//                                     style: const TextStyle(
//                                       fontSize: 16,
//                                       fontWeight: FontWeight.w600,
//                                       color: Colors.black87,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//
//                         const SizedBox(height: 16),
//                         Divider(color: Colors.grey[300], height: 1),
//                         const SizedBox(height: 16),
//
//                         // Time details
//                         Row(
//                           children: [
//                             Expanded(
//                               child: _buildInfoTile(
//                                 Icons.access_time,
//                                 "Start Time",
//                                 start_date_[index],
//                                 Colors.green,
//                               ),
//                             ),
//                             Container(
//                               width: 1,
//                               height: 40,
//                               color: Colors.grey[300],
//                             ),
//                             Expanded(
//                               child: _buildInfoTile(
//                                 Icons.access_time_filled,
//                                 "End Time",
//                                 end_date_[index],
//                                 Colors.red,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
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
//   Widget _buildInfoTile(IconData icon, String label, String value, Color color) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 8),
//       child: Column(
//         children: [
//           Icon(icon, color: color, size: 20),
//           const SizedBox(height: 4),
//           Text(
//             label,
//             style: TextStyle(
//               fontSize: 11,
//               fontWeight: FontWeight.w600,
//               color: Colors.grey[600],
//             ),
//           ),
//           const SizedBox(height: 2),
//           Text(
//             value,
//             style: const TextStyle(
//               fontSize: 13,
//               fontWeight: FontWeight.w600,
//               color: Colors.black87,
//             ),
//             textAlign: TextAlign.center,
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

// --- Professional Theme Palette ---
class MarineTheme {
  static const Color background = Color(0xFF050b1f);
  static const Color surface = Color(0xFF1E293B);
  static const Color primary = Color(0xFF38BDF8); // Electric Blue
  static const Color textMain = Colors.white;
  static const Color textMuted = Color(0xFF94A3B8);
}

class viewtrip extends StatelessWidget {
  const viewtrip({super.key});

  @override
  Widget build(BuildContext context) {
    return const viewtrippage(title: 'My Trips');
  }
}

class viewtrippage extends StatefulWidget {
  const viewtrippage({super.key, required this.title});
  final String title;

  @override
  State<viewtrippage> createState() => _viewtrippageState();
}

class _viewtrippageState extends State<viewtrippage> {
  // Keeping all original variables
  List<String> id_ = [];
  List<String> boat_ = [];
  List<String> start_date_ = [];
  List<String> end_date_ = [];
  List<String> From_ = [];
  List<String> To_ = [];
  List<String> status_ = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    load();
  }

  // Original load function logic preserved
  Future<void> load() async {
    List<String> id = [];
    List<String> boat = [];
    List<String> start_date = [];
    List<String> end_date = [];
    List<String> From = [];
    List<String> To = [];
    List<String> status = [];

    try {
      final pref = await SharedPreferences.getInstance();
      String ip = pref.getString("url").toString();
      String lid = pref.getString("lid").toString();

      String url = "$ip/user_viewtrip/";
      var data = await http.post(Uri.parse(url), body: {'lid': lid});
      var jsondata = json.decode(data.body);
      var arr = jsondata["data"];

      for (int i = 0; i < arr.length; i++) {
        id.add(arr[i]['id'].toString());
        boat.add(arr[i]['boat'].toString());
        start_date.add(arr[i]['start_date'].toString());
        end_date.add(arr[i]['end_date'].toString());
        From.add(arr[i]['From'].toString());
        To.add(arr[i]['To'].toString());
        status.add(arr[i]['status'].toString());
      }

      setState(() {
        id_ = id;
        boat_ = boat;
        start_date_ = start_date;
        end_date_ = end_date;
        From_ = From;
        To_ = To;
        status_ = status;
        isLoading = false;
      });
    } catch (e) {
      debugPrint("Error: $e");
      setState(() => isLoading = false);
    }
  }

  Color getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'completed': return const Color(0xFF10b981);
      case 'pending': return const Color(0xFFf59e0b);
      case 'cancelled': return const Color(0xFFef4444);
      case 'active': return MarineTheme.primary;
      default: return Colors.grey;
    }
  }

  IconData getStatusIcon(String status) {
    switch (status.toLowerCase()) {
      case 'completed': return Icons.verified_rounded;
      case 'pending': return Icons.history_toggle_off_rounded;
      case 'cancelled': return Icons.block_flipped;
      case 'active': return Icons.sailing_rounded;
      default: return Icons.info_outline;
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
              backgroundColor: MarineTheme.background.withOpacity(0.75),
              elevation: 0,
              centerTitle: false,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white, size: 20),
                onPressed: () => Navigator.pop(context),
              ),
              title: const Text(
                "My Voyages",
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
      body: isLoading ? _buildLoader() : (id_.isEmpty ? _buildEmptyState() : _buildTripList()),
    );
  }

  Widget _buildLoader() {
    return const Center(child: CircularProgressIndicator(color: MarineTheme.primary));
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.anchor_rounded, size: 80, color: MarineTheme.textMuted.withOpacity(0.2)),
          const SizedBox(height: 16),
          const Text("No Voyages Tracked", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
          const Text("Your sailing history will appear here.", style: TextStyle(color: MarineTheme.textMuted)),
        ],
      ),
    );
  }

  Widget _buildTripList() {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(16, 110, 16, 20),
      itemCount: id_.length,
      itemBuilder: (context, index) => _buildTripCard(index),
    );
  }

  Widget _buildTripCard(int index) {
    final statusColor = getStatusColor(status_[index]);

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
        child: Column(
          children: [
            // Header with Boat Info and Status
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: MarineTheme.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.directions_boat_filled_rounded, color: MarineTheme.primary, size: 24),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(boat_[index], style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                        Text("ID: #${id_[index]}", style: const TextStyle(color: MarineTheme.textMuted, fontSize: 12)),
                      ],
                    ),
                  ),
                  _buildStatusChip(index, statusColor),
                ],
              ),
            ),

            // Route Visualization
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    _buildRouteNode(From_[index], "ORIGIN", CrossAxisAlignment.start),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          children: List.generate(5, (i) => Expanded(
                            child: Container(height: 1, margin: const EdgeInsets.symmetric(horizontal: 2), color: MarineTheme.textMuted.withOpacity(0.3)),
                          )),
                        ),
                      ),
                    ),
                    _buildRouteNode(To_[index], "DESTINATION", CrossAxisAlignment.end),
                  ],
                ),
              ),
            ),

            // Time Footer
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  _buildTimeInfo("START", start_date_[index], Icons.login_rounded, Colors.green),
                  const Spacer(),
                  _buildTimeInfo("END", end_date_[index], Icons.logout_rounded, Colors.redAccent),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusChip(int index, Color color) {
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
          Icon(getStatusIcon(status_[index]), color: color, size: 14),
          const SizedBox(width: 6),
          Text(status_[index].toUpperCase(), style: TextStyle(color: color, fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 0.5)),
        ],
      ),
    );
  }

  Widget _buildRouteNode(String city, String label, CrossAxisAlignment align) {
    return Column(
      crossAxisAlignment: align,
      children: [
        Text(label, style: const TextStyle(color: MarineTheme.textMuted, fontSize: 9, fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        Text(city, style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _buildTimeInfo(String label, String time, IconData icon, Color color) {
    return Row(
      children: [
        Icon(icon, color: color.withOpacity(0.7), size: 14),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: const TextStyle(color: MarineTheme.textMuted, fontSize: 9, fontWeight: FontWeight.bold)),
            Text(time, style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w500)),
          ],
        ),
      ],
    );
  }
}