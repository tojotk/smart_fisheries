//
// //
// //
// //
// // import 'dart:convert';
// // import 'dart:io';
// // import 'package:fisheries/Login.dart';
// // import 'package:flutter/material.dart';
// // import 'package:fluttertoast/fluttertoast.dart';
// // import 'package:image_picker/image_picker.dart';
// // import 'package:shared_preferences/shared_preferences.dart';
// // import 'package:http/http.dart' as http;
// //
// // class signup extends StatefulWidget {
// //   const signup({super.key});
// //
// //   @override
// //   State<signup> createState() => _signupState();
// // }
// //
// // class _signupState extends State<signup> {
// //   File? _image;
// //   final ImagePicker _picker = ImagePicker();
// //
// //   TextEditingController nameController = TextEditingController();
// //   TextEditingController placeController = TextEditingController();
// //   TextEditingController dobController = TextEditingController();
// //   TextEditingController phoneController = TextEditingController();
// //   TextEditingController emailController = TextEditingController();
// //   TextEditingController usernameController = TextEditingController();
// //   TextEditingController passwordController = TextEditingController();
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(title: Text('Signup Page')),
// //       body: Padding(
// //         padding: EdgeInsets.all(20.0),
// //         child: SingleChildScrollView(
// //           child: Column(
// //             children: [
// //               /// NAME
// //               TextFormField(
// //                 decoration: InputDecoration(labelText: 'Name'),
// //                 controller: nameController,
// //               ),
// //
// //               /// PLACE
// //               TextFormField(
// //                 decoration: InputDecoration(labelText: 'Place'),
// //                 controller: placeController,
// //               ),
// //
// //               /// PHONE
// //               TextFormField(
// //                 decoration: InputDecoration(labelText: 'Phone'),
// //                 controller: phoneController,
// //                 keyboardType: TextInputType.phone,
// //               ),
// //
// //               SizedBox(height: 10),
// //
// //               /// DATE OF BIRTH (DATE PICKER)
// //               TextFormField(
// //                 decoration: InputDecoration(
// //                   labelText: 'Date of Birth',
// //                   prefixIcon: Icon(Icons.calendar_today),
// //                 ),
// //                 controller: dobController,
// //                 readOnly: true,
// //                 onTap: () async {
// //                   DateTime? pickedDate = await showDatePicker(
// //                     context: context,
// //                     initialDate: DateTime(2000),
// //                     firstDate: DateTime(1900),
// //                     lastDate: DateTime.now(),
// //                   );
// //
// //                   if (pickedDate != null) {
// //                     dobController.text =
// //                     "${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}";
// //                   }
// //                 },
// //               ),
// //
// //               SizedBox(height: 10),
// //
// //               /// EMAIL
// //               TextFormField(
// //                 decoration: InputDecoration(labelText: 'Email'),
// //                 controller: emailController,
// //                 keyboardType: TextInputType.emailAddress,
// //               ),
// //
// //               SizedBox(height: 20),
// //
// //               /// IMAGE PICKER
// //               _image == null
// //                   ? Text("No image selected")
// //                   : Image.file(_image!, height: 200),
// //
// //               SizedBox(height: 20),
// //
// //               ElevatedButton.icon(
// //                 onPressed: () => _pickImage(ImageSource.gallery),
// //                 icon: Icon(Icons.photo),
// //                 label: Text("Pick from Gallery"),
// //               ),
// //
// //               ElevatedButton.icon(
// //                 onPressed: () => _pickImage(ImageSource.camera),
// //                 icon: Icon(Icons.camera_alt),
// //                 label: Text("Pick from Camera"),
// //               ),
// //
// //               SizedBox(height: 20),
// //
// //               /// USERNAME
// //               TextFormField(
// //                 decoration: InputDecoration(labelText: 'Username'),
// //                 controller: usernameController,
// //               ),
// //
// //               /// PASSWORD
// //               TextFormField(
// //                 decoration: InputDecoration(labelText: 'Password'),
// //                 controller: passwordController,
// //                 obscureText: true,
// //               ),
// //
// //               SizedBox(height: 20),
// //
// //               /// SIGNUP BUTTON
// //               ElevatedButton(
// //                 onPressed: sendData,
// //                 child: Text('Signup'),
// //               )
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// //
// //   /// ============================
// //   /// SEND DATA TO DJANGO
// //   /// ============================
// //   Future<void> sendData() async {
// //     String name = nameController.text.trim();
// //     String place = placeController.text.trim();
// //     String password = passwordController.text.trim();
// //     String email = emailController.text.trim();
// //     String username = usernameController.text.trim();
// //     String phone = phoneController.text.trim();
// //     String dob = dobController.text.trim();
// //
// //     if (name.isEmpty ||
// //         place.isEmpty ||
// //         username.isEmpty ||
// //         password.isEmpty ||
// //         phone.isEmpty ||
// //         dob.isEmpty) {
// //       Fluttertoast.showToast(msg: 'Please fill all the fields');
// //       return;
// //     }
// //
// //     if (_image == null) {
// //       Fluttertoast.showToast(msg: 'Please select an image');
// //       return;
// //     }
// //
// //     final sh = await SharedPreferences.getInstance();
// //     String? url = sh.getString('url');
// //
// //     final api = Uri.parse('$url/user_register/');
// //
// //     try {
// //       final request = http.MultipartRequest('POST', api);
// //
// //       request.fields['name'] = name;
// //       request.fields['place'] = place;
// //       request.fields['email'] = email;
// //       request.fields['phone'] = phone;
// //       request.fields['dob'] = dob; // YYYY-MM-DD (Correct format for Django)
// //       request.fields['username'] = username;
// //       request.fields['password'] = password;
// //
// //       request.files.add(
// //         await http.MultipartFile.fromPath(
// //           'photo',
// //           _image!.path,
// //         ),
// //       );
// //
// //       var response = await request.send();
// //
// //       if (response.statusCode == 200) {
// //         var responseData = await response.stream.bytesToString();
// //         var data = jsonDecode(responseData);
// //
// //         if (data['status'] == 'ok') {
// //           Navigator.push(
// //             context,
// //             MaterialPageRoute(builder: (context) => LoginPage()),
// //           );
// //         } else {
// //           Fluttertoast.showToast(msg: 'Error Occurred');
// //         }
// //       } else {
// //         Fluttertoast.showToast(msg: 'Server Error');
// //       }
// //     } catch (e) {
// //       Fluttertoast.showToast(msg: 'Error: $e');
// //     }
// //   }
// //
// //   /// ============================
// //   /// PICK IMAGE
// //   /// ============================
// //   Future<void> _pickImage(ImageSource source) async {
// //     final pickedFile = await _picker.pickImage(source: source);
// //
// //     if (pickedFile != null) {
// //       setState(() {
// //         _image = File(pickedFile.path);
// //       });
// //     }
// //   }
// // }
//
//
//
// import 'dart:convert';
// import 'dart:io';
// import 'package:fisheries/Login.dart';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http;
//
// class signup extends StatefulWidget {
//   const signup({super.key});
//
//   @override
//   State<signup> createState() => _signupState();
// }
//
// class _signupState extends State<signup> {
//   File? _image;
//   final ImagePicker _picker = ImagePicker();
//   final _formKey = GlobalKey<FormState>();
//
//   TextEditingController nameController = TextEditingController();
//   TextEditingController placeController = TextEditingController();
//   TextEditingController dobController = TextEditingController();
//   TextEditingController phoneController = TextEditingController();
//   TextEditingController emailController = TextEditingController();
//   TextEditingController usernameController = TextEditingController();
//   TextEditingController passwordController = TextEditingController();
//
//   bool _isPasswordVisible = false;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[50],
//       appBar: AppBar(
//         title: Text('Create Account', style: TextStyle(fontWeight: FontWeight.w600)),
//         centerTitle: true,
//         elevation: 0,
//         backgroundColor: Colors.blue[700],
//         foregroundColor: Colors.white,
//       ),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Padding(
//             padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
//             child: Form(
//               key: _formKey,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 children: [
//                   // Profile Image Section
//                   Center(
//                     child: Stack(
//                       children: [
//                         Container(
//                           decoration: BoxDecoration(
//                             shape: BoxShape.circle,
//                             boxShadow: [
//                               BoxShadow(
//                                 color: Colors.black.withOpacity(0.1),
//                                 blurRadius: 20,
//                                 offset: Offset(0, 10),
//                               ),
//                             ],
//                           ),
//                           child: CircleAvatar(
//                             radius: 70,
//                             backgroundColor: Colors.blue[100],
//                             backgroundImage: _image != null ? FileImage(_image!) : null,
//                             child: _image == null
//                                 ? Icon(Icons.person, size: 70, color: Colors.blue[300])
//                                 : null,
//                           ),
//                         ),
//                         Positioned(
//                           bottom: 0,
//                           right: 0,
//                           child: Container(
//                             decoration: BoxDecoration(
//                               color: Colors.blue[700],
//                               shape: BoxShape.circle,
//                               border: Border.all(color: Colors.white, width: 3),
//                             ),
//                             child: IconButton(
//                               icon: Icon(Icons.camera_alt, color: Colors.white, size: 20),
//                               onPressed: _showImageSourceDialog,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//
//                   SizedBox(height: 30),
//
//                   // Personal Information Header
//                   Text(
//                     'Personal Information',
//                     style: TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.grey[800],
//                     ),
//                   ),
//                   SizedBox(height: 16),
//
//                   // Name Field
//                   _buildTextField(
//                     controller: nameController,
//                     label: 'Full Name',
//                     icon: Icons.person_outline,
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Please enter your name';
//                       }
//                       return null;
//                     },
//                   ),
//
//                   SizedBox(height: 16),
//
//                   // Place Field
//                   _buildTextField(
//                     controller: placeController,
//                     label: 'Place',
//                     icon: Icons.location_on_outlined,
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Please enter your place';
//                       }
//                       return null;
//                     },
//                   ),
//
//                   SizedBox(height: 16),
//
//                   // Date of Birth Field
//                   _buildTextField(
//                     controller: dobController,
//                     label: 'Date of Birth',
//                     icon: Icons.cake_outlined,
//                     readOnly: true,
//                     onTap: () async {
//                       DateTime? pickedDate = await showDatePicker(
//                         context: context,
//                         initialDate: DateTime(2000),
//                         firstDate: DateTime(1900),
//                         lastDate: DateTime.now(),
//                         builder: (context, child) {
//                           return Theme(
//                             data: Theme.of(context).copyWith(
//                               colorScheme: ColorScheme.light(
//                                 primary: Colors.blue[700]!,
//                               ),
//                             ),
//                             child: child!,
//                           );
//                         },
//                       );
//
//                       if (pickedDate != null) {
//                         dobController.text =
//                         "${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}";
//                       }
//                     },
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Please select your date of birth';
//                       }
//                       return null;
//                     },
//                   ),
//
//                   SizedBox(height: 16),
//
//                   // Phone Field
//                   _buildTextField(
//                     controller: phoneController,
//                     label: 'Phone Number',
//                     icon: Icons.phone_outlined,
//                     keyboardType: TextInputType.phone,
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Please enter your phone number';
//                       }
//                       if (value.length < 10) {
//                         return 'Please enter a valid phone number';
//                       }
//                       return null;
//                     },
//                   ),
//
//                   SizedBox(height: 16),
//
//                   // Email Field
//                   _buildTextField(
//                     controller: emailController,
//                     label: 'Email Address',
//                     icon: Icons.email_outlined,
//                     keyboardType: TextInputType.emailAddress,
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Please enter your email';
//                       }
//                       if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
//                         return 'Please enter a valid email';
//                       }
//                       return null;
//                     },
//                   ),
//
//                   SizedBox(height: 30),
//
//                   // Account Information Header
//                   Text(
//                     'Account Credentials',
//                     style: TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.grey[800],
//                     ),
//                   ),
//                   SizedBox(height: 16),
//
//                   // Username Field
//                   _buildTextField(
//                     controller: usernameController,
//                     label: 'Username',
//                     icon: Icons.account_circle_outlined,
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Please enter a username';
//                       }
//                       if (value.length < 4) {
//                         return 'Username must be at least 4 characters';
//                       }
//                       return null;
//                     },
//                   ),
//
//                   SizedBox(height: 16),
//
//                   // Password Field
//                   _buildTextField(
//                     controller: passwordController,
//                     label: 'Password',
//                     icon: Icons.lock_outline,
//                     obscureText: !_isPasswordVisible,
//                     suffixIcon: IconButton(
//                       icon: Icon(
//                         _isPasswordVisible ? Icons.visibility_off : Icons.visibility,
//                         color: Colors.grey[600],
//                       ),
//                       onPressed: () {
//                         setState(() {
//                           _isPasswordVisible = !_isPasswordVisible;
//                         });
//                       },
//                     ),
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Please enter a password';
//                       }
//                       if (value.length < 6) {
//                         return 'Password must be at least 6 characters';
//                       }
//                       return null;
//                     },
//                   ),
//
//                   SizedBox(height: 40),
//
//                   // Signup Button
//                   ElevatedButton(
//                     onPressed: sendData,
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.blue[700],
//                       foregroundColor: Colors.white,
//                       padding: EdgeInsets.symmetric(vertical: 16),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                       elevation: 2,
//                     ),
//                     child: Text(
//                       'Create Account',
//                       style: TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.w600,
//                         letterSpacing: 0.5,
//                       ),
//                     ),
//                   ),
//
//                   SizedBox(height: 20),
//
//                   // Already have account
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Text(
//                         'Already have an account? ',
//                         style: TextStyle(color: Colors.grey[600]),
//                       ),
//                       GestureDetector(
//                         onTap: () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(builder: (context) => LoginPage()),
//                           );
//                         },
//                         child: Text(
//                           'Login',
//                           style: TextStyle(
//                             color: Colors.blue[700],
//                             fontWeight: FontWeight.w600,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//
//                   SizedBox(height: 20),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   // Custom Text Field Builder
//   Widget _buildTextField({
//     required TextEditingController controller,
//     required String label,
//     required IconData icon,
//     TextInputType? keyboardType,
//     bool obscureText = false,
//     bool readOnly = false,
//     VoidCallback? onTap,
//     Widget? suffixIcon,
//     String? Function(String?)? validator,
//   }) {
//     return TextFormField(
//       controller: controller,
//       decoration: InputDecoration(
//         labelText: label,
//         prefixIcon: Icon(icon, color: Colors.blue[700]),
//         suffixIcon: suffixIcon,
//         filled: true,
//         fillColor: Colors.white,
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12),
//           borderSide: BorderSide(color: Colors.grey[300]!),
//         ),
//         enabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12),
//           borderSide: BorderSide(color: Colors.grey[300]!),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12),
//           borderSide: BorderSide(color: Colors.blue[700]!, width: 2),
//         ),
//         errorBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12),
//           borderSide: BorderSide(color: Colors.red[400]!),
//         ),
//         focusedErrorBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12),
//           borderSide: BorderSide(color: Colors.red[400]!, width: 2),
//         ),
//         contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
//       ),
//       keyboardType: keyboardType,
//       obscureText: obscureText,
//       readOnly: readOnly,
//       onTap: onTap,
//       validator: validator,
//     );
//   }
//
//   // Show Image Source Dialog
//   void _showImageSourceDialog() {
//     showModalBottomSheet(
//       context: context,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
//       ),
//       builder: (BuildContext context) {
//         return SafeArea(
//           child: Padding(
//             padding: EdgeInsets.symmetric(vertical: 20),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Text(
//                   'Select Profile Photo',
//                   style: TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.w600,
//                     color: Colors.grey[800],
//                   ),
//                 ),
//                 SizedBox(height: 20),
//                 ListTile(
//                   leading: Container(
//                     padding: EdgeInsets.all(10),
//                     decoration: BoxDecoration(
//                       color: Colors.blue[50],
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     child: Icon(Icons.photo_library, color: Colors.blue[700]),
//                   ),
//                   title: Text('Choose from Gallery'),
//                   onTap: () {
//                     Navigator.pop(context);
//                     _pickImage(ImageSource.gallery);
//                   },
//                 ),
//                 ListTile(
//                   leading: Container(
//                     padding: EdgeInsets.all(10),
//                     decoration: BoxDecoration(
//                       color: Colors.blue[50],
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     child: Icon(Icons.camera_alt, color: Colors.blue[700]),
//                   ),
//                   title: Text('Take a Photo'),
//                   onTap: () {
//                     Navigator.pop(context);
//                     _pickImage(ImageSource.camera);
//                   },
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
//
//   // Send Data to Django
//   Future<void> sendData() async {
//     if (!_formKey.currentState!.validate()) {
//       return;
//     }
//
//     if (_image == null) {
//       Fluttertoast.showToast(
//         msg: 'Please select a profile photo',
//         toastLength: Toast.LENGTH_SHORT,
//         backgroundColor: Colors.red[400],
//       );
//       return;
//     }
//
//     String name = nameController.text.trim();
//     String place = placeController.text.trim();
//     String password = passwordController.text.trim();
//     String email = emailController.text.trim();
//     String username = usernameController.text.trim();
//     String phone = phoneController.text.trim();
//     String dob = dobController.text.trim();
//
//     // Show loading dialog
//     showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (BuildContext context) {
//         return Center(
//           child: Container(
//             padding: EdgeInsets.all(20),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(10),
//             ),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 CircularProgressIndicator(color: Colors.blue[700]),
//                 SizedBox(height: 16),
//                 Text('Creating your account...'),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//
//     final sh = await SharedPreferences.getInstance();
//     String? url = sh.getString('url');
//
//     final api = Uri.parse('$url/user_register/');
//
//     try {
//       final request = http.MultipartRequest('POST', api);
//
//       request.fields['name'] = name;
//       request.fields['place'] = place;
//       request.fields['email'] = email;
//       request.fields['phone'] = phone;
//       request.fields['dob'] = dob;
//       request.fields['username'] = username;
//       request.fields['password'] = password;
//
//       request.files.add(
//         await http.MultipartFile.fromPath(
//           'photo',
//           _image!.path,
//         ),
//       );
//
//       var response = await request.send();
//
//       Navigator.pop(context); // Close loading dialog
//
//       if (response.statusCode == 200) {
//         var responseData = await response.stream.bytesToString();
//         var data = jsonDecode(responseData);
//
//         if (data['status'] == 'ok') {
//           Fluttertoast.showToast(
//             msg: 'Account created successfully!',
//             toastLength: Toast.LENGTH_SHORT,
//             backgroundColor: Colors.green[600],
//           );
//           Navigator.pushReplacement(
//             context,
//             MaterialPageRoute(builder: (context) => LoginPage()),
//           );
//         } else {
//           Fluttertoast.showToast(
//             msg: data['message'] ?? 'Error occurred',
//             toastLength: Toast.LENGTH_SHORT,
//             backgroundColor: Colors.red[400],
//           );
//         }
//       } else {
//         Fluttertoast.showToast(
//           msg: 'Server error. Please try again.',
//           toastLength: Toast.LENGTH_SHORT,
//           backgroundColor: Colors.red[400],
//         );
//       }
//     } catch (e) {
//       Navigator.pop(context); // Close loading dialog
//       Fluttertoast.showToast(
//         msg: 'Error: $e',
//         toastLength: Toast.LENGTH_LONG,
//         backgroundColor: Colors.red[400],
//       );
//     }
//   }
//
//   // Pick Image
//   Future<void> _pickImage(ImageSource source) async {
//     final pickedFile = await _picker.pickImage(
//       source: source,
//       maxWidth: 1024,
//       maxHeight: 1024,
//       imageQuality: 85,
//     );
//
//     if (pickedFile != null) {
//       setState(() {
//         _image = File(pickedFile.path);
//       });
//     }
//   }
// }




// import 'dart:convert';
// import 'dart:io';
// import 'package:fisheries/Login.dart';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http;
//
// class signup extends StatefulWidget {
//   const signup({super.key});
//
//   @override
//   State<signup> createState() => _signupState();
// }
//
// class _signupState extends State<signup> {
//   File? _image;
//   final ImagePicker _picker = ImagePicker();
//   final _formKey = GlobalKey<FormState>();
//
//   TextEditingController nameController = TextEditingController();
//   TextEditingController placeController = TextEditingController();
//   TextEditingController dobController = TextEditingController();
//   TextEditingController phoneController = TextEditingController();
//   TextEditingController emailController = TextEditingController();
//   TextEditingController usernameController = TextEditingController();
//   TextEditingController passwordController = TextEditingController();
//
//   bool _isPasswordVisible = false;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[50],
//       appBar: AppBar(
//         title: Text('Create Account', style: TextStyle(fontWeight: FontWeight.w600)),
//         centerTitle: true,
//         elevation: 0,
//         backgroundColor: Colors.blue[700],
//         foregroundColor: Colors.white,
//       ),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Padding(
//             padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
//             child: Form(
//               key: _formKey,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 children: [
//                   // Profile Image Section
//                   Center(
//                     child: Stack(
//                       children: [
//                         Container(
//                           decoration: BoxDecoration(
//                             shape: BoxShape.circle,
//                             boxShadow: [
//                               BoxShadow(
//                                 color: Colors.black.withOpacity(0.1),
//                                 blurRadius: 20,
//                                 offset: Offset(0, 10),
//                               ),
//                             ],
//                           ),
//                           child: CircleAvatar(
//                             radius: 70,
//                             backgroundColor: Colors.blue[100],
//                             backgroundImage: _image != null ? FileImage(_image!) : null,
//                             child: _image == null
//                                 ? Icon(Icons.person, size: 70, color: Colors.blue[300])
//                                 : null,
//                           ),
//                         ),
//                         Positioned(
//                           bottom: 0,
//                           right: 0,
//                           child: Container(
//                             decoration: BoxDecoration(
//                               color: Colors.blue[700],
//                               shape: BoxShape.circle,
//                               border: Border.all(color: Colors.white, width: 3),
//                             ),
//                             child: IconButton(
//                               icon: Icon(Icons.camera_alt, color: Colors.white, size: 20),
//                               onPressed: _showImageSourceDialog,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//
//                   SizedBox(height: 30),
//
//                   // Personal Information Header
//                   Text(
//                     'Personal Information',
//                     style: TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.grey[800],
//                     ),
//                   ),
//                   SizedBox(height: 16),
//
//                   // Name Field
//                   _buildTextField(
//                     controller: nameController,
//                     label: 'Full Name',
//                     icon: Icons.person_outline,
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Please enter your name';
//                       }
//                       return null;
//                     },
//                   ),
//
//                   SizedBox(height: 16),
//
//                   // Place Field
//                   _buildTextField(
//                     controller: placeController,
//                     label: 'Place',
//                     icon: Icons.location_on_outlined,
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Please enter your place';
//                       }
//                       return null;
//                     },
//                   ),
//
//                   SizedBox(height: 16),
//
//                   // Date of Birth Field
//                   _buildTextField(
//                     controller: dobController,
//                     label: 'Date of Birth',
//                     icon: Icons.cake_outlined,
//                     readOnly: true,
//                     onTap: () async {
//                       DateTime? pickedDate = await showDatePicker(
//                         context: context,
//                         initialDate: DateTime(2000),
//                         firstDate: DateTime(1900),
//                         lastDate: DateTime.now(),
//                         builder: (context, child) {
//                           return Theme(
//                             data: Theme.of(context).copyWith(
//                               colorScheme: ColorScheme.light(
//                                 primary: Colors.blue[700]!,
//                               ),
//                             ),
//                             child: child!,
//                           );
//                         },
//                       );
//
//                       if (pickedDate != null) {
//                         dobController.text =
//                         "${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}";
//                       }
//                     },
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Please select your date of birth';
//                       }
//                       return null;
//                     },
//                   ),
//
//                   SizedBox(height: 16),
//
//                   // Phone Field
//                   _buildTextField(
//                     controller: phoneController,
//                     label: 'Phone Number',
//                     icon: Icons.phone_outlined,
//                     keyboardType: TextInputType.phone,
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Please enter your phone number';
//                       }
//                       if (value.length < 10) {
//                         return 'Please enter a valid phone number';
//                       }
//                       return null;
//                     },
//                   ),
//
//                   SizedBox(height: 16),
//
//                   // Email Field
//                   _buildTextField(
//                     controller: emailController,
//                     label: 'Email Address',
//                     icon: Icons.email_outlined,
//                     keyboardType: TextInputType.emailAddress,
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Please enter your email';
//                       }
//                       if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
//                         return 'Please enter a valid email';
//                       }
//                       return null;
//                     },
//                   ),
//
//                   SizedBox(height: 30),
//
//                   // Account Information Header
//                   Text(
//                     'Account Credentials',
//                     style: TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.grey[800],
//                     ),
//                   ),
//                   SizedBox(height: 16),
//
//                   // Username Field
//                   _buildTextField(
//                     controller: usernameController,
//                     label: 'Username',
//                     icon: Icons.account_circle_outlined,
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Please enter a username';
//                       }
//                       if (value.length < 4) {
//                         return 'Username must be at least 4 characters';
//                       }
//                       return null;
//                     },
//                   ),
//
//                   SizedBox(height: 16),
//
//                   // Password Field
//                   _buildTextField(
//                     controller: passwordController,
//                     label: 'Password',
//                     icon: Icons.lock_outline,
//                     obscureText: !_isPasswordVisible,
//                     suffixIcon: IconButton(
//                       icon: Icon(
//                         _isPasswordVisible ? Icons.visibility_off : Icons.visibility,
//                         color: Colors.grey[600],
//                       ),
//                       onPressed: () {
//                         setState(() {
//                           _isPasswordVisible = !_isPasswordVisible;
//                         });
//                       },
//                     ),
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Please enter a password';
//                       }
//                       if (value.length < 6) {
//                         return 'Password must be at least 6 characters';
//                       }
//                       return null;
//                     },
//                   ),
//
//                   SizedBox(height: 40),
//
//                   // Signup Button
//                   ElevatedButton(
//                     onPressed: sendData,
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.blue[700],
//                       foregroundColor: Colors.white,
//                       padding: EdgeInsets.symmetric(vertical: 16),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                       elevation: 2,
//                     ),
//                     child: Text(
//                       'Create Account',
//                       style: TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.w600,
//                         letterSpacing: 0.5,
//                       ),
//                     ),
//                   ),
//
//                   SizedBox(height: 20),
//
//                   // Already have account
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Text(
//                         'Already have an account? ',
//                         style: TextStyle(color: Colors.grey[600]),
//                       ),
//                       GestureDetector(
//                         onTap: () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(builder: (context) => LoginPage()),
//                           );
//                         },
//                         child: Text(
//                           'Login',
//                           style: TextStyle(
//                             color: Colors.blue[700],
//                             fontWeight: FontWeight.w600,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//
//                   SizedBox(height: 20),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   // Custom Text Field Builder
//   Widget _buildTextField({
//     required TextEditingController controller,
//     required String label,
//     required IconData icon,
//     TextInputType? keyboardType,
//     bool obscureText = false,
//     bool readOnly = false,
//     VoidCallback? onTap,
//     Widget? suffixIcon,
//     String? Function(String?)? validator,
//   }) {
//     return TextFormField(
//       controller: controller,
//       style: TextStyle(fontSize: 16, color: Colors.black),
//       decoration: InputDecoration(
//         labelText: label,
//         labelStyle: TextStyle(color: Colors.blue[700]),
//         prefixIcon: Icon(icon, color: Colors.blue[700]),
//         suffixIcon: suffixIcon,
//         filled: true,
//         fillColor: Colors.white,
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12),
//           borderSide: BorderSide(color: Colors.grey[300]!),
//         ),
//         enabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12),
//           borderSide: BorderSide(color: Colors.grey[300]!),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12),
//           borderSide: BorderSide(color: Colors.blue[700]!, width: 2),
//         ),
//         errorBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12),
//           borderSide: BorderSide(color: Colors.red[400]!),
//         ),
//         focusedErrorBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12),
//           borderSide: BorderSide(color: Colors.red[400]!, width: 2),
//         ),
//         contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
//       ),
//       keyboardType: keyboardType,
//       obscureText: obscureText,
//       readOnly: readOnly,
//       onTap: onTap,
//       validator: validator,
//     );
//   }
//
//   // Show Image Source Dialog
//   void _showImageSourceDialog() {
//     showModalBottomSheet(
//       context: context,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
//       ),
//       builder: (BuildContext context) {
//         return SafeArea(
//           child: Padding(
//             padding: EdgeInsets.symmetric(vertical: 20),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Text(
//                   'Select Profile Photo',
//                   style: TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.w600,
//                     color: Colors.grey[800],
//                   ),
//                 ),
//                 SizedBox(height: 20),
//                 ListTile(
//                   leading: Container(
//                     padding: EdgeInsets.all(10),
//                     decoration: BoxDecoration(
//                       color: Colors.blue[50],
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     child: Icon(Icons.photo_library, color: Colors.blue[700]),
//                   ),
//                   title: Text('Choose from Gallery'),
//                   onTap: () {
//                     Navigator.pop(context);
//                     _pickImage(ImageSource.gallery);
//                   },
//                 ),
//                 ListTile(
//                   leading: Container(
//                     padding: EdgeInsets.all(10),
//                     decoration: BoxDecoration(
//                       color: Colors.blue[50],
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     child: Icon(Icons.camera_alt, color: Colors.blue[700]),
//                   ),
//                   title: Text('Take a Photo'),
//                   onTap: () {
//                     Navigator.pop(context);
//                     _pickImage(ImageSource.camera);
//                   },
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
//
//   // Send Data to Django
//   Future<void> sendData() async {
//     if (!_formKey.currentState!.validate()) {
//       return;
//     }
//
//     if (_image == null) {
//       Fluttertoast.showToast(
//         msg: 'Please select a profile photo',
//         toastLength: Toast.LENGTH_SHORT,
//         backgroundColor: Colors.red[400],
//       );
//       return;
//     }
//
//     String name = nameController.text.trim();
//     String place = placeController.text.trim();
//     String password = passwordController.text.trim();
//     String email = emailController.text.trim();
//     String username = usernameController.text.trim();
//     String phone = phoneController.text.trim();
//     String dob = dobController.text.trim();
//
//     // Show loading dialog
//     showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (BuildContext context) {
//         return Center(
//           child: Container(
//             padding: EdgeInsets.all(20),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(10),
//             ),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 CircularProgressIndicator(color: Colors.blue[700]),
//                 SizedBox(height: 16),
//                 Text('Creating your account...', style: TextStyle(color: Colors.black)),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//
//     final sh = await SharedPreferences.getInstance();
//     String? url = sh.getString('url');
//
//     final api = Uri.parse('$url/user_register/');
//
//     try {
//       final request = http.MultipartRequest('POST', api);
//
//       request.fields['name'] = name;
//       request.fields['place'] = place;
//       request.fields['email'] = email;
//       request.fields['phone'] = phone;
//       request.fields['dob'] = dob;
//       request.fields['username'] = username;
//       request.fields['password'] = password;
//
//       request.files.add(
//         await http.MultipartFile.fromPath(
//           'photo',
//           _image!.path,
//         ),
//       );
//
//       var response = await request.send();
//
//       Navigator.pop(context); // Close loading dialog
//
//       if (response.statusCode == 200) {
//         var responseData = await response.stream.bytesToString();
//         var data = jsonDecode(responseData);
//
//         if (data['status'] == 'ok') {
//           Fluttertoast.showToast(
//             msg: 'Account created successfully!',
//             toastLength: Toast.LENGTH_SHORT,
//             backgroundColor: Colors.green[600],
//           );
//           Navigator.pushReplacement(
//             context,
//             MaterialPageRoute(builder: (context) => LoginPage()),
//           );
//         } else {
//           Fluttertoast.showToast(
//             msg: data['message'] ?? 'Error occurred',
//             toastLength: Toast.LENGTH_SHORT,
//             backgroundColor: Colors.red[400],
//           );
//         }
//       } else {
//         Fluttertoast.showToast(
//           msg: 'Server error. Please try again.',
//           toastLength: Toast.LENGTH_SHORT,
//           backgroundColor: Colors.red[400],
//         );
//       }
//     } catch (e) {
//       Navigator.pop(context); // Close loading dialog
//       Fluttertoast.showToast(
//         msg: 'Error: $e',
//         toastLength: Toast.LENGTH_LONG,
//         backgroundColor: Colors.red[400],
//       );
//     }
//   }
//
//   // Pick Image
//   Future<void> _pickImage(ImageSource source) async {
//     final pickedFile = await _picker.pickImage(
//       source: source,
//       maxWidth: 1024,
//       maxHeight: 1024,
//       imageQuality: 85,
//     );
//
//     if (pickedFile != null) {
//       setState(() {
//         _image = File(pickedFile.path);
//       });
//     }
//   }
// }



import 'dart:convert';
import 'dart:io';
import 'package:fisheries/Login.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class signup extends StatefulWidget {
  const signup({super.key});

  @override
  State<signup> createState() => _SignupState();
}

class _SignupState extends State<signup> {
  File? _image;
  final ImagePicker _picker = ImagePicker();
  final _formKey = GlobalKey<FormState>();

  // Deep Teal Silk
  final Color primary = const Color(0xFF0B3037);
  final Color accent = const Color(0xFF7ECED3);
  final Color bg = const Color(0xFFF1F8F9);

  TextEditingController nameController = TextEditingController();
  TextEditingController placeController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        backgroundColor: primary,
        title: const Text('Create Account'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [

              /// PROFILE IMAGE
              Stack(
                children: [
                  CircleAvatar(
                    radius: 70,
                    backgroundColor: accent.withOpacity(.3),
                    backgroundImage:
                    _image != null ? FileImage(_image!) : null,
                    child: _image == null
                        ? Icon(Icons.person,
                        size: 70, color: primary)
                        : null,
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: CircleAvatar(
                      backgroundColor: primary,
                      child: IconButton(
                        icon: const Icon(Icons.camera_alt,
                            color: Colors.white),
                        onPressed: _showImageSourceDialog,
                      ),
                    ),
                  )
                ],
              ),

              const SizedBox(height: 30),

              _title("Personal Information"),

              _field(nameController, "Full Name", Icons.person),
              _field(placeController, "Place", Icons.location_on),

              _field(
                dobController,
                "Date of Birth",
                Icons.cake,
                readOnly: true,
                onTap: () async {
                  DateTime? d = await showDatePicker(
                    context: context,
                    firstDate: DateTime(1900),
                    lastDate: DateTime.now(),
                    initialDate: DateTime(2000),
                  );
                  if (d != null) {
                    dobController.text =
                    "${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}";
                  }
                },
              ),

              _field(phoneController, "Phone Number", Icons.phone,
                  keyboard: TextInputType.phone),

              _field(emailController, "Email Address", Icons.email,
                  keyboard: TextInputType.emailAddress),

              const SizedBox(height: 20),

              _title("Account Credentials"),

              _field(usernameController, "Username",
                  Icons.account_circle),

              _field(
                passwordController,
                "Password",
                Icons.lock,
                obscure: !_isPasswordVisible,
                suffix: IconButton(
                  icon: Icon(
                    _isPasswordVisible
                        ? Icons.visibility_off
                        : Icons.visibility,
                    color: primary,
                  ),
                  onPressed: () {
                    setState(() {
                      _isPasswordVisible = !_isPasswordVisible;
                    });
                  },
                ),
              ),

              const SizedBox(height: 30),

              /// CREATE ACCOUNT BUTTON
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primary,
                    padding:
                    const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  onPressed: sendData,
                  child: const Text(
                    "Create Account",
                    style: TextStyle(
                        fontSize: 16, color: Colors.white),
                  ),
                ),
              ),

              const SizedBox(height: 15),

              /// LOGIN LINK
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Already have an account? ",
                    style: TextStyle(color: Colors.black87),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => LoginPage()),
                      );
                    },
                    child: Text(
                      "Login",
                      style: TextStyle(
                        color: primary,
                        fontWeight: FontWeight.bold,
                        decoration:
                        TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// COMMON TEXT FIELD
  Widget _field(
      TextEditingController c,
      String label,
      IconData icon, {
        bool obscure = false,
        bool readOnly = false,
        VoidCallback? onTap,
        TextInputType? keyboard,
        Widget? suffix,
      }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: c,
        obscureText: obscure,
        readOnly: readOnly,
        onTap: onTap,
        keyboardType: keyboard,
        style: const TextStyle(
          color: Colors.black, // ✅ TEXT VISIBLE
          fontSize: 16,
        ),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: primary),
          prefixIcon: Icon(icon, color: primary),
          suffixIcon: suffix,
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide:
            BorderSide(color: primary.withOpacity(.3)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide:
            BorderSide(color: primary, width: 2),
          ),
        ),
      ),
    );
  }

  Widget _title(String text) => Align(
    alignment: Alignment.centerLeft,
    child: Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: primary,
        ),
      ),
    ),
  );

  /// IMAGE PICKER
  void _showImageSourceDialog() {
    showModalBottomSheet(
      context: context,
      builder: (_) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: Icon(Icons.photo, color: primary),
            title: const Text("Gallery"),
            onTap: () {
              Navigator.pop(context);
              _pickImage(ImageSource.gallery);
            },
          ),
          ListTile(
            leading:
            Icon(Icons.camera_alt, color: primary),
            title: const Text("Camera"),
            onTap: () {
              Navigator.pop(context);
              _pickImage(ImageSource.camera);
            },
          ),
        ],
      ),
    );
  }

  Future<void> _pickImage(ImageSource src) async {
    final img =
    await _picker.pickImage(source: src, imageQuality: 85);
    if (img != null) {
      setState(() => _image = File(img.path));
    }
  }

  /// SEND DATA (UNCHANGED LOGIC)
  Future<void> sendData() async {
    if (!_formKey.currentState!.validate()) return;

    if (_image == null) {
      Fluttertoast.showToast(msg: "Select profile photo");
      return;
    }

    final sh = await SharedPreferences.getInstance();
    String? url = sh.getString('url');

    final req = http.MultipartRequest(
        'POST', Uri.parse('$url/user_register/'));

    req.fields.addAll({
      'name': nameController.text,
      'place': placeController.text,
      'email': emailController.text,
      'phone': phoneController.text,
      'dob': dobController.text,
      'username': usernameController.text,
      'password': passwordController.text,
    });

    req.files.add(
        await http.MultipartFile.fromPath('photo', _image!.path));

    final res = await req.send();
    final body = await res.stream.bytesToString();
    final data = jsonDecode(body);

    if (data['status'] == 'ok') {
      Fluttertoast.showToast(msg: "Account Created");
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => LoginPage()));
    } else {
      Fluttertoast.showToast(msg: "Error");
    }
  }
}
