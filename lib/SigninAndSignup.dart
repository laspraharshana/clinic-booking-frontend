import 'package:flutter/material.dart';
import 'dashboard.dart';

class SignInAndSignUp extends StatefulWidget {
  const SignInAndSignUp({super.key});

  @override
  State<SignInAndSignUp> createState() => _SignInAndSignUpState();
}

class _SignInAndSignUpState extends State<SignInAndSignUp> {
  bool _obscurePassword = true;

  // FORM KEYS
  final GlobalKey<FormState> _signInKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _signUpKey = GlobalKey<FormState>();

  // Sign In Controllers
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Sign Up Controllers
  final TextEditingController _signUpNameController = TextEditingController();
  final TextEditingController _signUpEmailController = TextEditingController();
  final TextEditingController _signUpPhoneController = TextEditingController();
  final TextEditingController _signUpPasswordController =
      TextEditingController();

  // Sign In Logic
  void _handleSignIn() {
    if (_signInKey.currentState?.validate() ?? false) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Dashboard()),
      );
    }
  }

  // Sign Up Logic
  void _handleSignUp() {
    if (_signUpKey.currentState?.validate() ?? false) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Account created! Please sign in.")),
      );

      // Switch back to Sign In tab after signup success
      final tabController = DefaultTabController.of(context);
      tabController?.animateTo(0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Gradient background
          Container(
            height: MediaQuery.of(context).size.height * 0.45,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF1B5E57), Color(0xFF00695C)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),

          // Floating circles
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

          // Main content
          Align(
            alignment: Alignment.topCenter,
            child: Column(
              children: [
                const SizedBox(height: 80),
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

                // Card with Tabs
                Expanded(
                  child: Container(
                    width: double.infinity,
                    margin:
                        const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
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
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const TabBar(
                              indicator: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12)),
                              ),
                              labelColor: Colors.black,
                              unselectedLabelColor: Colors.grey,
                              tabs: [
                                SizedBox(width: 150, child: Tab(text: "Sign In")),
                                SizedBox(width: 150, child: Tab(text: "Sign Up")),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),

                          // Tab Views
                          Expanded(
                            child: TabBarView(
                              children: [
                                // ------------------- Sign In -------------------
                                SingleChildScrollView(
                                  child: Form(
                                    key: _signInKey,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text("Email or Phone Number",
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500)),
                                        TextFormField(
                                          controller: _emailController,
                                          validator: (value) {
                                            if (value == null ||
                                                value.trim().isEmpty) {
                                              return "Email/Phone is required";
                                            }
                                            return null;
                                          },
                                          decoration: InputDecoration(
                                            prefixIcon: const Icon(
                                                Icons.email_outlined),
                                            hintText:
                                                "Enter your email or phone number",
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 16),

                                        const Text("Password",
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500)),
                                        TextFormField(
                                          controller: _passwordController,
                                          obscureText: _obscurePassword,
                                          validator: (value) {
                                            if (value == null ||
                                                value.trim().isEmpty) {
                                              return "Password is required";
                                            }
                                            if (value.trim().length < 6) {
                                              return "Password must be at least 6 characters";
                                            }
                                            return null;
                                          },
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
                                        const SizedBox(height: 20),

                                        SizedBox(
                                          width: double.infinity,
                                          height: 50,
                                          child: ElevatedButton(
                                            onPressed: _handleSignIn,
                                            style: ElevatedButton.styleFrom(
                                              padding: EdgeInsets.zero,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                              ),
                                            ),
                                            child: Ink(
                                              decoration: BoxDecoration(
                                                gradient: const LinearGradient(
                                                  colors: [
                                                    Color(0xFF1B5E57),
                                                    Color(0xFF00695C),
                                                  ],
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                              ),
                                              child: Container(
                                                alignment: Alignment.center,
                                                child: const Text("Sign In",
                                                    style: TextStyle(
                                                        fontSize: 18,
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),

                                // ------------------- Sign Up -------------------
                                SingleChildScrollView(
                                  child: Form(
                                    key: _signUpKey,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text("Full Name",
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500)),
                                        TextFormField(
                                          controller: _signUpNameController,
                                          validator: (value) {
                                            if (value == null ||
                                                value.trim().isEmpty) {
                                              return "Full Name is required";
                                            }
                                            return null;
                                          },
                                          decoration: InputDecoration(
                                            prefixIcon:
                                                const Icon(Icons.person),
                                            hintText: "Enter your full name",
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 16),

                                        const Text("Email Address (Optional)",
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500)),
                                        TextFormField(
                                          controller: _signUpEmailController,
                                          decoration: InputDecoration(
                                            prefixIcon: const Icon(
                                                Icons.email_outlined),
                                            hintText: "Enter your email",
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 16),

                                        const Text("Phone Number",
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500)),
                                        TextFormField(
                                          controller: _signUpPhoneController,
                                          validator: (value) {
                                            if (value == null ||
                                                value.trim().isEmpty) {
                                              return "Phone number is required";
                                            }
                                            if (!RegExp(r'^[0-9]+$')
                                                .hasMatch(value.trim())) {
                                              return "Enter a valid number";
                                            }
                                            return null;
                                          },
                                          decoration: InputDecoration(
                                            prefixIcon:
                                                const Icon(Icons.phone),
                                            hintText: "Enter your phone number",
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 16),

                                        const Text("Password",
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500)),
                                        TextFormField(
                                          controller: _signUpPasswordController,
                                          obscureText: _obscurePassword,
                                          validator: (value) {
                                            if (value == null ||
                                                value.trim().isEmpty) {
                                              return "Password is required";
                                            }
                                            if (value.trim().length < 6) {
                                              return "Password must be at least 6 characters";
                                            }
                                            return null;
                                          },
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

                                        SizedBox(
                                          width: double.infinity,
                                          height: 50,
                                          child: ElevatedButton(
                                            onPressed: _handleSignUp,
                                            style: ElevatedButton.styleFrom(
                                              padding: EdgeInsets.zero,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                              ),
                                            ),
                                            child: Ink(
                                              decoration: BoxDecoration(
                                                gradient: const LinearGradient(
                                                  colors: [
                                                    Color(0xFF1B5E57),
                                                    Color(0xFF00695C),
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
                                                            FontWeight.bold)),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
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