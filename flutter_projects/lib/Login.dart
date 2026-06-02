// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:fisheries/register.dart';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'forgot_password.dart';
// import 'home.dart';
//
// class LoginPage extends StatefulWidget {
//   const LoginPage({super.key});
//
//   @override
//   State<LoginPage> createState() => _LoginPageState();
// }
//
// class _LoginPageState extends State<LoginPage> with SingleTickerProviderStateMixin {
//   final _formKey = GlobalKey<FormState>();
//   TextEditingController usernameController = TextEditingController();
//   TextEditingController passwordController = TextEditingController();
//   bool _isPasswordVisible = false;
//   bool _isLoading = false;
//   late AnimationController _animationController;
//   late Animation<double> _fadeAnimation;
//   late Animation<Offset> _slideAnimation;
//
//   @override
//   void initState() {
//     super.initState();
//     _animationController = AnimationController(
//       vsync: this,
//       duration: Duration(milliseconds: 1200),
//     );
//     _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
//       CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
//     );
//     _slideAnimation = Tween<Offset>(
//       begin: Offset(0, 0.3),
//       end: Offset.zero,
//     ).animate(CurvedAnimation(parent: _animationController, curve: Curves.easeOutCubic));
//     _animationController.forward();
//   }
//
//   @override
//   void dispose() {
//     _animationController.dispose();
//     usernameController.dispose();
//     passwordController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//             colors: [
//               Color(0xff141E30),
//               Color(0xff243B55),
//             ],
//           ),
//         ),
//         child: SafeArea(
//           child: Center(
//             child: SingleChildScrollView(
//               child: FadeTransition(
//                 opacity: _fadeAnimation,
//                 child: SlideTransition(
//                   position: _slideAnimation,
//                   child: Padding(
//                     padding: EdgeInsets.symmetric(horizontal: 32.0),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         // App Icon with Glow
//                         Container(
//                           padding: EdgeInsets.all(28),
//                           decoration: BoxDecoration(
//                             shape: BoxShape.circle,
//                             gradient: LinearGradient(
//                               colors: [
//                                 Color(0xff4facfe),
//                                 Color(0xff00f2fe),
//                               ],
//                             ),
//                             boxShadow: [
//                               BoxShadow(
//                                 color: Color(0xff00f2fe).withOpacity(0.4),
//                                 blurRadius: 35,
//                                 spreadRadius: 8,
//                               ),
//                             ],
//                           ),
//                           child: Icon(
//                             Icons.waves,
//                             size: 56,
//                             color: Colors.white,
//                           ),
//                         ),
//                         SizedBox(height: 32),
//
//                         // Welcome Text
//                         Text(
//                           'Welcome Back',
//                           style: TextStyle(
//                             fontSize: 34,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.white,
//                             letterSpacing: 1.2,
//                             shadows: [
//                               Shadow(
//                                 color: Color(0xff00f2fe).withOpacity(0.3),
//                                 blurRadius: 15,
//                               ),
//                             ],
//                           ),
//                         ),
//                         SizedBox(height: 8),
//
//                         Text(
//                           'Login to Smart Fisheries',
//                           style: TextStyle(
//                             fontSize: 15,
//                             color: Colors.white70,
//                             letterSpacing: 0.8,
//                           ),
//                         ),
//                         SizedBox(height: 48),
//
//                         // Login Card
//                         Container(
//                           decoration: BoxDecoration(
//                             color: Colors.white.withOpacity(0.08),
//                             borderRadius: BorderRadius.circular(24),
//                             border: Border.all(
//                               color: Colors.white.withOpacity(0.15),
//                               width: 1.5,
//                             ),
//                             boxShadow: [
//                               BoxShadow(
//                                 color: Colors.black.withOpacity(0.3),
//                                 blurRadius: 30,
//                                 offset: Offset(0, 15),
//                               ),
//                             ],
//                           ),
//                           child: Padding(
//                             padding: EdgeInsets.all(28),
//                             child: Form(
//                               key: _formKey,
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                                 children: [
//                                   // Username Field
//                                   TextFormField(
//                                     controller: usernameController,
//                                     style: TextStyle(
//                                       color: Colors.white,
//                                       fontSize: 15,
//                                     ),
//                                     decoration: InputDecoration(
//                                       labelText: 'Username',
//                                       labelStyle: TextStyle(
//                                         color: Colors.white60,
//                                         fontSize: 14,
//                                       ),
//                                       prefixIcon: Icon(
//                                         Icons.person_outline,
//                                         color: Color(0xff00f2fe),
//                                         size: 22,
//                                       ),
//                                       filled: true,
//                                       fillColor: Colors.white.withOpacity(0.05),
//                                       enabledBorder: OutlineInputBorder(
//                                         borderRadius: BorderRadius.circular(14),
//                                         borderSide: BorderSide(
//                                           color: Colors.white.withOpacity(0.2),
//                                           width: 1.5,
//                                         ),
//                                       ),
//                                       focusedBorder: OutlineInputBorder(
//                                         borderRadius: BorderRadius.circular(14),
//                                         borderSide: BorderSide(
//                                           color: Color(0xff00f2fe),
//                                           width: 2,
//                                         ),
//                                       ),
//                                       errorBorder: OutlineInputBorder(
//                                         borderRadius: BorderRadius.circular(14),
//                                         borderSide: BorderSide(
//                                           color: Color(0xffff6b6b),
//                                           width: 1.5,
//                                         ),
//                                       ),
//                                       focusedErrorBorder: OutlineInputBorder(
//                                         borderRadius: BorderRadius.circular(14),
//                                         borderSide: BorderSide(
//                                           color: Color(0xffff6b6b),
//                                           width: 2,
//                                         ),
//                                       ),
//                                       errorStyle: TextStyle(
//                                         color: Color(0xffff6b6b),
//                                       ),
//                                       contentPadding: EdgeInsets.symmetric(
//                                         horizontal: 18,
//                                         vertical: 16,
//                                       ),
//                                     ),
//                                     validator: (value) {
//                                       if (value == null || value.isEmpty) {
//                                         return 'Please enter your username';
//                                       }
//                                       return null;
//                                     },
//                                   ),
//                                   SizedBox(height: 20),
//
//                                   // Password Field
//                                   TextFormField(
//                                     controller: passwordController,
//                                     obscureText: !_isPasswordVisible,
//                                     style: TextStyle(
//                                       color: Colors.white,
//                                       fontSize: 15,
//                                     ),
//                                     decoration: InputDecoration(
//                                       labelText: 'Password',
//                                       labelStyle: TextStyle(
//                                         color: Colors.white60,
//                                         fontSize: 14,
//                                       ),
//                                       prefixIcon: Icon(
//                                         Icons.lock_outline,
//                                         color: Color(0xff00f2fe),
//                                         size: 22,
//                                       ),
//                                       suffixIcon: IconButton(
//                                         icon: Icon(
//                                           _isPasswordVisible
//                                               ? Icons.visibility_off_outlined
//                                               : Icons.visibility_outlined,
//                                           color: Colors.white60,
//                                           size: 22,
//                                         ),
//                                         onPressed: () {
//                                           setState(() {
//                                             _isPasswordVisible = !_isPasswordVisible;
//                                           });
//                                         },
//                                       ),
//                                       filled: true,
//                                       fillColor: Colors.white.withOpacity(0.05),
//                                       enabledBorder: OutlineInputBorder(
//                                         borderRadius: BorderRadius.circular(14),
//                                         borderSide: BorderSide(
//                                           color: Colors.white.withOpacity(0.2),
//                                           width: 1.5,
//                                         ),
//                                       ),
//                                       focusedBorder: OutlineInputBorder(
//                                         borderRadius: BorderRadius.circular(14),
//                                         borderSide: BorderSide(
//                                           color: Color(0xff00f2fe),
//                                           width: 2,
//                                         ),
//                                       ),
//                                       errorBorder: OutlineInputBorder(
//                                         borderRadius: BorderRadius.circular(14),
//                                         borderSide: BorderSide(
//                                           color: Color(0xffff6b6b),
//                                           width: 1.5,
//                                         ),
//                                       ),
//                                       focusedErrorBorder: OutlineInputBorder(
//                                         borderRadius: BorderRadius.circular(14),
//                                         borderSide: BorderSide(
//                                           color: Color(0xffff6b6b),
//                                           width: 2,
//                                         ),
//                                       ),
//                                       errorStyle: TextStyle(
//                                         color: Color(0xffff6b6b),
//                                       ),
//                                       contentPadding: EdgeInsets.symmetric(
//                                         horizontal: 18,
//                                         vertical: 16,
//                                       ),
//                                     ),
//                                     validator: (value) {
//                                       if (value == null || value.isEmpty) {
//                                         return 'Please enter your password';
//                                       }
//                                       return null;
//                                     },
//                                   ),
//                                   SizedBox(height: 12),
//
//                                   // Forgot Password
//                                   Align(
//                                     alignment: Alignment.centerRight,
//                                     child: TextButton(
//                                       onPressed: () {
//                                         Navigator.push(context, MaterialPageRoute(builder: (context)=>Forgot()));
//                                       },
//                                       style: TextButton.styleFrom(
//                                         padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//                                       ),
//                                       child: Text(
//                                         'Forgot Password?',
//                                         style: TextStyle(
//                                           color: Color(0xff00f2fe),
//                                           fontWeight: FontWeight.w600,
//                                           fontSize: 13,
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                   SizedBox(height: 24),
//
//                                   // Login Button
//                                   Container(
//                                     height: 54,
//                                     decoration: BoxDecoration(
//                                       gradient: LinearGradient(
//                                         colors: [
//                                           Color(0xff4facfe),
//                                           Color(0xff00f2fe),
//                                         ],
//                                       ),
//                                       borderRadius: BorderRadius.circular(14),
//                                       boxShadow: [
//                                         BoxShadow(
//                                           color: Color(0xff00f2fe).withOpacity(0.4),
//                                           blurRadius: 20,
//                                           offset: Offset(0, 8),
//                                         ),
//                                       ],
//                                     ),
//                                     child: Material(
//                                       color: Colors.transparent,
//                                       child: InkWell(
//                                         onTap: _isLoading ? null : sendData,
//                                         borderRadius: BorderRadius.circular(14),
//                                         child: Center(
//                                           child: _isLoading
//                                               ? SizedBox(
//                                             height: 24,
//                                             width: 24,
//                                             child: CircularProgressIndicator(
//                                               strokeWidth: 2.5,
//                                               valueColor: AlwaysStoppedAnimation<Color>(
//                                                 Colors.white,
//                                               ),
//                                             ),
//                                           )
//                                               : Row(
//                                             mainAxisAlignment: MainAxisAlignment.center,
//                                             children: [
//                                               Text(
//                                                 'Login',
//                                                 style: TextStyle(
//                                                   color: Colors.white,
//                                                   fontSize: 17,
//                                                   fontWeight: FontWeight.bold,
//                                                   letterSpacing: 1.2,
//                                                 ),
//                                               ),
//                                               SizedBox(width: 10),
//                                               Icon(
//                                                 Icons.arrow_forward,
//                                                 color: Colors.white,
//                                                 size: 20,
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ),
//                         SizedBox(height: 32),
//
//                         // Sign Up Section
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Text(
//                               "Don't have an account? ",
//                               style: TextStyle(
//                                 color: Colors.white60,
//                                 fontSize: 14,
//                               ),
//                             ),
//                             GestureDetector(
//                               onTap: () {
//                                 Navigator.push(
//                                   context,
//                                   MaterialPageRoute(builder: (context) => signup()),
//                                 );
//                               },
//                               child: Text(
//                                 'Sign Up',
//                                 style: TextStyle(
//                                   color: Color(0xff00f2fe),
//                                   fontWeight: FontWeight.bold,
//                                   fontSize: 14,
//                                   decoration: TextDecoration.underline,
//                                   decorationColor: Color(0xff00f2fe),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                         SizedBox(height: 20),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Future<void> sendData() async {
//     if (!_formKey.currentState!.validate()) {
//       return;
//     }
//
//     String username = usernameController.text.trim();
//     String password = passwordController.text.trim();
//
//     setState(() {
//       _isLoading = true;
//     });
//
//     final sh = await SharedPreferences.getInstance();
//     String? url = sh.getString('url');
//
//     final api = Uri.parse('$url/FlutterLogin/');
//
//     try {
//       final request = await http.post(api, body: {
//         'username': username,
//         'password': password,
//       });
//
//       setState(() {
//         _isLoading = false;
//       });
//
//       if (request.statusCode == 200) {
//         var data = jsonDecode(request.body);
//         if (data['status'] == 'ok') {
//           final sh = await SharedPreferences.getInstance();
//           await sh.setString('lid', data['lid'].toString());
//
//           Fluttertoast.showToast(
//             msg: 'Login successful!',
//             toastLength: Toast.LENGTH_SHORT,
//             backgroundColor: Color(0xff00f2fe),
//             textColor: Colors.white,
//           );
//
//           Navigator.pushReplacement(
//             context,
//             MaterialPageRoute(builder: (context) => Home()),
//           );
//         } else {
//           Fluttertoast.showToast(
//             msg: 'Invalid username or password',
//             toastLength: Toast.LENGTH_SHORT,
//             backgroundColor: Color(0xffff6b6b),
//             textColor: Colors.white,
//           );
//         }
//       } else {
//         Fluttertoast.showToast(
//           msg: 'Connection error. Please try again.',
//           toastLength: Toast.LENGTH_SHORT,
//           backgroundColor: Color(0xffff6b6b),
//           textColor: Colors.white,
//         );
//       }
//     } catch (e) {
//       setState(() {
//         _isLoading = false;
//       });
//       Fluttertoast.showToast(
//         msg: 'Error: $e',
//         toastLength: Toast.LENGTH_LONG,
//         backgroundColor: Color(0xffff6b6b),
//         textColor: Colors.white,
//       );
//     }
//   }
// }



import 'dart:convert';
import 'dart:ui';
import 'package:http/http.dart' as http;
import 'package:fisheries/register.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'forgot_password.dart';
import 'home.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _isPasswordVisible = false;
  bool _isLoading = false;
  late AnimationController _animationController;
  late AnimationController _pulseController;
  late AnimationController _floatController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _pulseAnimation;
  late Animation<double> _floatAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    // Main animation controller
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1500),
    );

    // Pulse animation for icon glow
    _pulseController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 2000),
    )..repeat(reverse: true);

    // Float animation for background elements
    _floatController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 3000),
    )..repeat(reverse: true);

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Interval(0.0, 0.6, curve: Curves.easeIn),
      ),
    );

    _slideAnimation = Tween<Offset>(
      begin: Offset(0, 0.5),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Interval(0.2, 0.8, curve: Curves.easeOutCubic),
    ));

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Interval(0.3, 1.0, curve: Curves.elasticOut),
      ),
    );

    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.15).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    _floatAnimation = Tween<double>(begin: -10, end: 10).animate(
      CurvedAnimation(parent: _floatController, curve: Curves.easeInOut),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _pulseController.dispose();
    _floatController.dispose();
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Darker Background
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xff040d10),
                  Color(0xff061419),
                  Color(0xff041012),
                ],
              ),
            ),
          ),

          // Main Content
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: SlideTransition(
                    position: _slideAnimation,
                    child: ScaleTransition(
                      scale: _scaleAnimation,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 32.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Animated App Icon with Pulsing Glow
                            AnimatedBuilder(
                              animation: _pulseAnimation,
                              builder: (context, child) {
                                return Transform.scale(
                                  scale: _pulseAnimation.value,
                                  child: Container(
                                    padding: EdgeInsets.all(32),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      gradient: LinearGradient(
                                        colors: [
                                          Color(0xff20e3b2),
                                          Color(0xff29ffc6),
                                        ],
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Color(0xff20e3b2).withOpacity(0.6),
                                          blurRadius: 40 * _pulseAnimation.value,
                                          spreadRadius: 10 * _pulseAnimation.value,
                                        ),
                                        BoxShadow(
                                          color: Color(0xff29ffc6).withOpacity(0.4),
                                          blurRadius: 60 * _pulseAnimation.value,
                                          spreadRadius: 15 * _pulseAnimation.value,
                                        ),
                                      ],
                                    ),
                                    child: Icon(
                                      Icons.waves,
                                      size: 64,
                                      color: Color(0xff0b3037),
                                    ),
                                  ),
                                );
                              },
                            ),
                            SizedBox(height: 40),

                            // Welcome Text with Shimmer Effect
                            ShaderMask(
                              shaderCallback: (bounds) {
                                return LinearGradient(
                                  colors: [
                                    Color(0xff20e3b2),
                                    Color(0xff29ffc6),
                                    Color(0xff20e3b2),
                                  ],
                                  stops: [0.0, 0.5, 1.0],
                                ).createShader(bounds);
                              },
                              child: Text(
                                'Welcome Back',
                                style: TextStyle(
                                  fontSize: 38,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  letterSpacing: 1.5,
                                  shadows: [
                                    Shadow(
                                      color: Color(0xff20e3b2).withOpacity(0.5),
                                      blurRadius: 20,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 10),

                            Text(
                              'Login to Smart Fisheries',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white.withOpacity(0.4),
                                letterSpacing: 1.0,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                            SizedBox(height: 50),

                            // Login Card with Glassmorphism
                            Container(
                              decoration: BoxDecoration(
                                color: Color(0xff0a1518).withOpacity(0.6),
                                borderRadius: BorderRadius.circular(28),
                                border: Border.all(
                                  color: Color(0xff20e3b2).withOpacity(0.15),
                                  width: 1.5,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.5),
                                    blurRadius: 40,
                                    offset: Offset(0, 20),
                                  ),
                                ],
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(28),
                                child: BackdropFilter(
                                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                                  child: Padding(
                                    padding: EdgeInsets.all(32),
                                    child: Form(
                                      key: _formKey,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.stretch,
                                        children: [
                                          // Username Field
                                          _buildTextField(
                                            controller: usernameController,
                                            label: 'Username',
                                            icon: Icons.person_outline,
                                            validator: (value) {
                                              if (value == null || value.isEmpty) {
                                                return 'Please enter your username';
                                              }
                                              return null;
                                            },
                                          ),
                                          SizedBox(height: 24),

                                          // Password Field
                                          _buildTextField(
                                            controller: passwordController,
                                            label: 'Password',
                                            icon: Icons.lock_outline,
                                            isPassword: true,
                                            validator: (value) {
                                              if (value == null || value.isEmpty) {
                                                return 'Please enter your password';
                                              }
                                              return null;
                                            },
                                          ),
                                          SizedBox(height: 16),

                                          // Forgot Password
                                          Align(
                                            alignment: Alignment.centerRight,
                                            child: TextButton(
                                              onPressed: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(builder: (context) => Forgot()),
                                                );
                                              },
                                              style: TextButton.styleFrom(
                                                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                              ),
                                              child: Text(
                                                'Forgot Password?',
                                                style: TextStyle(
                                                  color: Color(0xff20e3b2),
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 14,
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 28),

                                          // Login Button with Hover Effect
                                          _buildLoginButton(),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 36),

                            // Sign Up Section
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Don't have an account? ",
                                  style: TextStyle(
                                    color: Colors.white.withOpacity(0.6),
                                    fontSize: 15,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => signup()),
                                    );
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                    decoration: BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(
                                          color: Color(0xff20e3b2),
                                          width: 2,
                                        ),
                                      ),
                                    ),
                                    child: Text(
                                      'Sign Up',
                                      style: TextStyle(
                                        color: Color(0xff20e3b2),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    bool isPassword = false,
    String? Function(String?)? validator,
  }) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      child: TextFormField(
        controller: controller,
        obscureText: isPassword ? !_isPasswordVisible : false,
        style: TextStyle(
          color: Colors.white,
          fontSize: 16,
        ),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(
            color: Color(0xff20e3b2).withOpacity(0.7),
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
          prefixIcon: Icon(
            icon,
            color: Color(0xff20e3b2),
            size: 22,
          ),
          suffixIcon: isPassword
              ? IconButton(
            icon: Icon(
              _isPasswordVisible
                  ? Icons.visibility_off_outlined
                  : Icons.visibility_outlined,
              color: Color(0xff20e3b2).withOpacity(0.7),
              size: 22,
            ),
            onPressed: () {
              setState(() {
                _isPasswordVisible = !_isPasswordVisible;
              });
            },
          )
              : null,
          filled: true,
          fillColor: Color(0xff0a1518).withOpacity(0.5),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(
              color: Color(0xff20e3b2).withOpacity(0.2),
              width: 1.5,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(
              color: Color(0xff20e3b2),
              width: 2.5,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(
              color: Color(0xffff6b6b),
              width: 1.5,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(
              color: Color(0xffff6b6b),
              width: 2.5,
            ),
          ),
          errorStyle: TextStyle(
            color: Color(0xffff6b6b),
            fontSize: 12,
          ),
          contentPadding: EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 18,
          ),
        ),
        validator: validator,
      ),
    );
  }

  Widget _buildLoginButton() {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: Duration(milliseconds: 800),
      builder: (context, value, child) {
        return Transform.scale(
          scale: 0.95 + (value * 0.05),
          child: Container(
            height: 58,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xff20e3b2),
                  Color(0xff29ffc6),
                ],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Color(0xff20e3b2).withOpacity(0.5),
                  blurRadius: 25,
                  offset: Offset(0, 10),
                ),
                BoxShadow(
                  color: Color(0xff29ffc6).withOpacity(0.3),
                  blurRadius: 35,
                  offset: Offset(0, 15),
                ),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: _isLoading ? null : sendData,
                borderRadius: BorderRadius.circular(16),
                splashColor: Colors.white.withOpacity(0.2),
                highlightColor: Colors.white.withOpacity(0.1),
                child: Center(
                  child: _isLoading
                      ? SizedBox(
                    height: 26,
                    width: 26,
                    child: CircularProgressIndicator(
                      strokeWidth: 3,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Color(0xff0b3037),
                      ),
                    ),
                  )
                      : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Login',
                        style: TextStyle(
                          color: Color(0xff0b3037),
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.5,
                        ),
                      ),
                      SizedBox(width: 12),
                      Icon(
                        Icons.arrow_forward_rounded,
                        color: Color(0xff0b3037),
                        size: 22,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> sendData() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    String username = usernameController.text.trim();
    String password = passwordController.text.trim();

    setState(() {
      _isLoading = true;
    });

    final sh = await SharedPreferences.getInstance();
    String? url = sh.getString('url');

    final api = Uri.parse('$url/FlutterLogin/');

    try {
      final request = await http.post(api, body: {
        'username': username,
        'password': password,
      });

      setState(() {
        _isLoading = false;
      });

      if (request.statusCode == 200) {
        var data = jsonDecode(request.body);
        if (data['status'] == 'ok') {
          final sh = await SharedPreferences.getInstance();
          await sh.setString('lid', data['lid'].toString());

          Fluttertoast.showToast(
            msg: 'Login successful!',
            toastLength: Toast.LENGTH_SHORT,
            backgroundColor: Color(0xff20e3b2),
            textColor: Color(0xff0b3037),
          );

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => Home()),
          );
        } else {
          Fluttertoast.showToast(
            msg: 'Invalid username or password',
            toastLength: Toast.LENGTH_SHORT,
            backgroundColor: Color(0xffff6b6b),
            textColor: Colors.white,
          );
        }
      } else {
        Fluttertoast.showToast(
          msg: 'Connection error. Please try again.',
          toastLength: Toast.LENGTH_SHORT,
          backgroundColor: Color(0xffff6b6b),
          textColor: Colors.white,
        );
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      Fluttertoast.showToast(
        msg: 'Error: $e',
        toastLength: Toast.LENGTH_LONG,
        backgroundColor: Color(0xffff6b6b),
        textColor: Colors.white,
      );
    }
  }
}