import 'package:flutter/material.dart';

void main() {
  runApp(const Signinandsignup());
}

class Signinandsignup extends StatelessWidget {
  const Signinandsignup ({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Clinic Booking App',
      home: const Signinandsignup(),
    );
  }
}

class SignInAndSignUp extends StatefulWidget {
  const SignInAndSignUp({super.key});

  @override
  State<SignInAndSignUp> createState() => _LoginPageState();
}

class _LoginPageState extends State<SignInAndSignUp> {
  bool _obscurePassword = true; // For password visibility toggle

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Background Gradient
          Container(
            height: MediaQuery.of(context).size.height * 0.45,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xff206c64), Color(0xff2e7d32)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),

          // Floating Circles
          Positioned(
            top: 60,
            right: 40,
            child: CircleAvatar(
              radius: 40,
              backgroundColor: Colors.white.withOpacity(0.1),
            ),
          ),
          Positioned(
            top: 120,
            left: 30,
            child: CircleAvatar(
              radius: 25,
              backgroundColor: Colors.white.withOpacity(0.08),
            ),
          ),

          // Main Content
          Align(
            alignment: Alignment.topCenter,
            child: Column(
              children: [
                const SizedBox(height: 80),

                // App Icon
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Icon(Icons.favorite_border,
                      size: 50, color: Colors.white),
                ),

                const SizedBox(height: 12),
                const Text(
                  "MediCare+",
                  style: TextStyle(
                    fontSize: 28,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 30),

                //Card Container
                Expanded(
                  child: Container(
                    width: double.infinity,
                    margin: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 16),
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: DefaultTabController(
                      length: 2,
                      child: Column(
                        children: [
                          // Tabs
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.zero,
                            ),
                            child: const TabBar(
                              indicator: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.zero),
                              ),
                              dividerColor: Colors.transparent,
                              labelColor: Colors.black,
                              unselectedLabelColor: Colors.grey,
                              tabs: [
                                SizedBox(
                                  width: 150,
                                  child: Tab(text: "Sign In"),
                                ),
                                 SizedBox(
                                  width: 150,
                                  child: Tab(text: "Sign Up"),
                                 )
                                
                              ],
                            ),
                          ),

                          const SizedBox(height: 20),

                          // Tab Views
                          Expanded(
                            child: TabBarView(
                              children: [
                                // Sign In Tab
                                SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // Email / Phone
                                      const Text(
                                        "Email or Phone Number",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black87,
                                        ),
                                      ),
                                      TextField(
                                        decoration: InputDecoration(
                                          prefixIcon:
                                              const Icon(Icons.email_outlined),
                                          hintText:
                                              "Enter your email or phone number",
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 16),

                                      // Password
                                       const Text(
                                        "Password",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black87,
                                        ),
                                      ),
                                      TextField(
                                        obscureText: _obscurePassword,
                                        decoration: InputDecoration(
                                          prefixIcon:
                                              const Icon(Icons.lock_outline),
                                          hintText: "Enter your password",
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          suffixIcon: IconButton(
                                            icon: Icon(
                                              _obscurePassword
                                                  ? Icons.visibility_off
                                                  : Icons.visibility,
                                            ),
                                            onPressed: () {
                                              setState(() {
                                                _obscurePassword =
                                                    !_obscurePassword;
                                              });
                                            },
                                          ),
                                        ),
                                      ),

                                      const SizedBox(height: 10),

                                      // Forgot Password
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: TextButton(
                                          onPressed: () {},
                                          child: const Text(
                                            "Forgot Password?",
                                            style: TextStyle(
                                              color: Colors.teal,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),

                                      const SizedBox(height: 10),

                                      // Sign In Button
                                      SizedBox(
                                        width: double.infinity,
                                        height: 50,
                                        child: ElevatedButton(
                                          onPressed: () {},
                                          style: ElevatedButton.styleFrom(
                                            padding: EdgeInsets.zero,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                            ),
                                          ),
                                          child: Ink(
                                            decoration: BoxDecoration(
                                              gradient:
                                                  const LinearGradient(
                                                colors: [
                                                  Color(0xff206c64),
                                                  Color(0xff2e7d32),
                                                ],
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                            ),
                                            child: Container(
                                              alignment: Alignment.center,
                                              child: const Text(
                                                "Sign In",
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                // Sign Up Tab - FIXED
                                SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // Full Name
                                      const Text(
                                        "Full Name",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black87,
                                        ),
                                      ),
                                      TextField(
                                        decoration: InputDecoration(
                                          prefixIcon:
                                              const Icon(Icons.person_outline),
                                          hintText: "Enter your full name",
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 16),

                                      // Email / Phone
                                      const Text(
                                        "Email Address(Optional)",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black87,
                                        ),
                                      ),
                                      TextField(
                                        decoration: InputDecoration(
                                          prefixIcon:
                                              const Icon(Icons.email_outlined),
                                          hintText:
                                              "Enter your email Address",
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 16),

                                      //phone number
                                      const Text(
                                        "Phone Number",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black87,
                                        ),
                                      ),
                                      TextField(
                                        decoration: InputDecoration(
                                          prefixIcon:
                                              const Icon(Icons.email_outlined),
                                          hintText:
                                              "Enter Your Phone Number",
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 16),

                                      // Password
                                      const Text(
                                        "Password",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black87,
                                        ),
                                      ),
                                      TextField(
                                        obscureText: _obscurePassword,
                                        decoration: InputDecoration(
                                          prefixIcon:
                                              const Icon(Icons.lock_outline),
                                          hintText: "Enter your password",
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          suffixIcon: IconButton(
                                            icon: Icon(
                                              _obscurePassword
                                                  ? Icons.visibility_off
                                                  : Icons.visibility,
                                            ),
                                            onPressed: () {
                                              setState(() {
                                                _obscurePassword =
                                                    !_obscurePassword;
                                              });
                                            },
                                          ),
                                        ),
                                      ),

                                      const SizedBox(height: 20),

                                      // Sign Up Button
                                      SizedBox(
                                        width: double.infinity,
                                        height: 50,
                                        child: ElevatedButton(
                                          onPressed: () {},
                                          style: ElevatedButton.styleFrom(
                                            padding: EdgeInsets.zero,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                            ),
                                          ),
                                          child: Ink(
                                            decoration: BoxDecoration(
                                              gradient:
                                                  const LinearGradient(
                                                colors: [
                                                  Color(0xff206c64),
                                                  Color(0xff2e7d32),
                                                ],
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                            ),
                                            child: Container(
                                              alignment: Alignment.center,
                                              child: const Text(
                                                "Create Account",
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}