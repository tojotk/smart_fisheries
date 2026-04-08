import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Login.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: const Color(0xFF0B3037),
        scaffoldBackgroundColor: const Color(0xFF071F24),
      ),
      home: IpPage(), // Changed to check IP first
    );
  }
}

// New SplashCheck widget to check stored IP
class IpPage extends StatefulWidget {
  const IpPage({super.key});

  @override
  State<IpPage> createState() => _IpPageState();
}

class _IpPageState extends State<IpPage>
    with SingleTickerProviderStateMixin {
  TextEditingController ipcontroller = TextEditingController();
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  final Color primary = const Color(0xFF0B3037);
  final Color accent = const Color(0xFF2EC4B6);
  final Color bgDark = const Color(0xFF071F24);

  @override
  void initState() {
    super.initState();
    _loadStoredIP(); // Load IP if exists
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeIn,
      ),
    );
    _animationController.forward();
  }

  // Load stored IP into text field
  Future<void> _loadStoredIP() async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    String? storedUrl = sh.getString("url");

    if (storedUrl != null && storedUrl.isNotEmpty) {
      // Extract IP from stored URL (format: http://IP:8000/myapp)
      String ip = storedUrl.replaceAll('http://', '').split(':')[0];
      ipcontroller.text = ip;
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    ipcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              bgDark,
              primary,
            ],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      /// APP ICON
                      Container(
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            colors: [
                              accent,
                              primary,
                            ],
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: accent.withOpacity(0.4),
                              blurRadius: 30,
                              spreadRadius: 4,
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.waves,
                          size: 64,
                          color: Colors.white,
                        ),
                      ),

                      const SizedBox(height: 40),

                      /// TITLE
                      const Text(
                        'Smart Fisheries',
                        style: TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          letterSpacing: 1.5,
                        ),
                      ),

                      const SizedBox(height: 10),

                      Text(
                        'Connect to Server',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white.withOpacity(.7),
                          letterSpacing: 1.2,
                        ),
                      ),

                      const SizedBox(height: 60),

                      /// IP CARD
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.06),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.1),
                            width: 1.5,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.35),
                              blurRadius: 25,
                              offset: const Offset(0, 12),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(24),
                          child: Column(
                            children: [

                              /// IP FIELD
                              TextFormField(
                                controller: ipcontroller,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                                decoration: InputDecoration(
                                  labelText: 'Server IP Address',
                                  labelStyle: TextStyle(
                                    color: Colors.white.withOpacity(.7),
                                  ),
                                  hintText: 'e.g., 192.168.1.100',
                                  hintStyle: TextStyle(
                                    color: Colors.white.withOpacity(.4),
                                  ),
                                  prefixIcon: Icon(
                                    Icons.dns,
                                    color: accent,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide(
                                      color: Colors.white.withOpacity(.2),
                                      width: 1.5,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide(
                                      color: accent,
                                      width: 2,
                                    ),
                                  ),
                                  filled: true,
                                  fillColor:
                                  Colors.white.withOpacity(0.05),
                                ),
                                keyboardType:
                                const TextInputType.numberWithOptions(
                                    decimal: true),
                              ),

                              const SizedBox(height: 30),

                              /// CONNECT BUTTON
                              Container(
                                width: double.infinity,
                                height: 56,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      accent,
                                      primary,
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                  boxShadow: [
                                    BoxShadow(
                                      color: accent.withOpacity(0.5),
                                      blurRadius: 20,
                                      offset: const Offset(0, 8),
                                    ),
                                  ],
                                ),
                                child: Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    borderRadius:
                                    BorderRadius.circular(12),
                                    onTap: sendData,
                                    child: Center(
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        children: const [
                                          Text(
                                            'Connect',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              letterSpacing: 1.2,
                                            ),
                                          ),
                                          SizedBox(width: 12),
                                          Icon(
                                            Icons.arrow_forward,
                                            color: Colors.white,
                                            size: 20,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 40),

                      /// INFO
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.info_outline,
                            color: Colors.white.withOpacity(.4),
                            size: 16,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Enter your server IP to continue',
                            style: TextStyle(
                              color: Colors.white.withOpacity(.4),
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// SEND DATA
  void sendData() async {
    String ip = ipcontroller.text.trim();

    if (ip.isEmpty) {
      Fluttertoast.showToast(
        msg: 'Please enter server IP address',
        backgroundColor: Colors.redAccent,
        textColor: Colors.white,
      );
      return;
    }

    SharedPreferences sh = await SharedPreferences.getInstance();
    sh.setString("url", "http://$ip:8000/myapp");
    sh.setString("img_url", "http://$ip:8000");

    Fluttertoast.showToast(
      msg: 'Connecting to server...',
      backgroundColor: accent,
      textColor: Colors.white,
    );

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }
}