import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:junior_flutter/features/crud/presentation/view_model/user_view_model_provider.dart';

// Define Screen class with route names
class Screen {
  static const String loginScreen = '/login';
  static const String forgotPasswordScreen = '/forgot_password';
  static const String signupScreen = '/signup';
  static const String adminDashboardScreen = '/adminDashboard';
  static const String userProfileScreen = '/profile';
}

final userViewModelProvider = ChangeNotifierProvider((ref) => UserProvider(ref));

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  late TextEditingController emailCtr;
  late TextEditingController passwordCtr;
  late TextEditingController adminEmailCtr;
  late TextEditingController adminPasswordCtr;

  bool isPasswordVisible = false;
  bool isRememberMeChecked = false;
  bool isAdminLogin = false;

  @override
  void initState() {
    super.initState();
    emailCtr = TextEditingController();
    passwordCtr = TextEditingController();
    adminEmailCtr = TextEditingController();
    adminPasswordCtr = TextEditingController();
  }

  @override
  void dispose() {
    emailCtr.dispose();
    passwordCtr.dispose();
    adminEmailCtr.dispose();
    adminPasswordCtr.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userModel = ref.watch(userViewModelProvider);

    ref.listen(userViewModelProvider, (previous, next) {
      if (next.token != null && next.error == null && !next.loading) {
        if (next.user != null) {
          if (next.user!.role == 'admin') {
            print('Admin login successful');
            print('navigating to admin dashboard');
            Navigator.pushReplacementNamed(context, '/admin-dashboard');
          } else {
            print('navigating to user profile');
            Navigator.pushReplacementNamed(context, '/profile');
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Login successful, but user data missing. Redirecting to profile.')),
          );
          Navigator.pushNamedAndRemoveUntil(
            context,
            Screen.userProfileScreen,
                (route) => route.settings.name != Screen.loginScreen,
          );
        }
      } else if (next.error != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(next.error!)),
        );
      }
    });

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: userModel.loading
            ? const Center(child: CircularProgressIndicator())
            : Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 24),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    isAdminLogin ? 'Admin Login' : 'Login',
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall
                        ?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                const Divider(
                  color: Colors.black,
                  thickness: 1,
                  height: 16,
                ),
                Visibility(
                  visible: !isAdminLogin,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: emailCtr,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          labelStyle: const TextStyle(color: Colors.black, fontSize: 16),
                          prefixIcon: const Icon(Icons.mail_outline),
                          filled: true,
                          fillColor: const Color(0xFFE7E7E7),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide.none,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        style: const TextStyle(color: Colors.black, fontSize: 16),
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: passwordCtr,
                        obscureText: !isPasswordVisible,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          labelStyle: const TextStyle(color: Colors.black, fontSize: 16),
                          prefixIcon: const Icon(Icons.lock),
                          suffixIcon: IconButton(
                            icon: Icon(isPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off),
                            onPressed: () {
                              setState(() {
                                isPasswordVisible = !isPasswordVisible;
                              });
                            },
                          ),
                          filled: true,
                          fillColor: const Color(0xFFE7E7E7),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide.none,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        style: const TextStyle(color: Colors.black, fontSize: 16),
                      ),
                    ],
                  ),
                ),
                Visibility(
                  visible: isAdminLogin,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: adminEmailCtr,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: 'Admin Email',
                          labelStyle: const TextStyle(color: Colors.black, fontSize: 16),
                          prefixIcon: const Icon(Icons.mail_outline),
                          filled: true,
                          fillColor: const Color(0xFFE7E7E7),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide.none,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        style: const TextStyle(color: Colors.black, fontSize: 16),
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: adminPasswordCtr,
                        obscureText: !isPasswordVisible,
                        decoration: InputDecoration(
                          labelText: 'Admin Password',
                          labelStyle: const TextStyle(color: Colors.black, fontSize: 16),
                          prefixIcon: const Icon(Icons.lock),
                          suffixIcon: IconButton(
                            icon: Icon(isPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off),
                            onPressed: () {
                              setState(() {
                                isPasswordVisible = !isPasswordVisible;
                              });
                            },
                          ),
                          filled: true,
                          fillColor: const Color(0xFFE7E7E7),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide.none,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        style: const TextStyle(color: Colors.black, fontSize: 16),
                      ),
                    ],
                  ),
                ),
                if (userModel.error != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        userModel.error!,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.error,
                        ),
                      ),
                    ),
                  ),
                Row(
                  children: [
                    Checkbox(
                      value: isRememberMeChecked,
                      onChanged: (value) {
                        setState(() {
                          isRememberMeChecked = value ?? false;
                        });
                      },
                    ),
                    const Text('Remember me'),
                    const Spacer(),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          Screen.forgotPasswordScreen,
                        );
                      },
                      child: const Text(
                        'Forgot password',
                        style: TextStyle(color: Color(0xFFC5AE3D)),
                      ),
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      setState(() {
                        isAdminLogin = !isAdminLogin;
                        emailCtr.clear();
                        passwordCtr.clear();
                        adminEmailCtr.clear();
                        adminPasswordCtr.clear();
                        isPasswordVisible = false;
                        isRememberMeChecked = false;
                        ref.read(userViewModelProvider).clear();
                      });
                    },
                    child: Text(
                      isAdminLogin
                          ? 'Regular Login'
                          : 'Admin Login',
                      style: const TextStyle(color: Color(0xFFC5AE3D)),
                    ),
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: userModel.loading
                        ? null
                        : () {
                      final provider = ref.read(userViewModelProvider);
                      if (isAdminLogin) {
                        if (adminEmailCtr.text.isNotEmpty &&
                            adminPasswordCtr.text.isNotEmpty) {
                          provider.emailCtr.text = adminEmailCtr.text;
                          provider.passwordCtr.text = adminPasswordCtr.text;
                          provider.loginAdmin(); // Use loginAdmin for admin login
                        } else {
                          provider.error = 'Admin email and password cannot be empty';
                          provider.notifyListeners();
                        }
                      } else {
                        if (emailCtr.text.isNotEmpty &&
                            passwordCtr.text.isNotEmpty) {
                          provider.emailCtr.text = emailCtr.text;
                          provider.passwordCtr.text = passwordCtr.text;
                          provider.loginUser(); // Use loginUser for regular login
                        } else {
                          provider.error = 'Email and password cannot be empty';
                          provider.notifyListeners();
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFC5AE3D),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: userModel.loading
                        ? Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Text('Logging in...',
                            style: TextStyle(color: Colors.white)),
                        SizedBox(width: 8),
                        SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        ),
                      ],
                    )
                        : Text(
                      isAdminLogin ? 'Admin Login' : 'Login',
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Column(
                  children: [
                    const Text(
                      'Contact us',
                      style: TextStyle(color: Color(0xFFC5AE3D)),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: () {}, // TODO: Handle YouTube click
                          icon: const Icon(Icons.play_arrow),
                        ),
                        IconButton(
                          onPressed: () {}, // TODO: Handle Instagram click
                          icon: const Icon(Icons.camera_alt),
                        ),
                        IconButton(
                          onPressed: () {}, // TODO: Handle Phone click
                          icon: const Icon(Icons.call),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an account? "),
                    TextButton(
                      onPressed: () {
                        print('Signup button pressed');
                        print('navigating to user-signup');
                        Navigator.pushReplacementNamed(context, '/user-signup');
                      },
                      child: const Text(
                        'Signup',
                        style: TextStyle(color: Color(0xFFC5AE3D)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}