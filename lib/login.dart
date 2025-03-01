// This is build by using shared_preferences we canalso make with use of firebase

// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Login/Register',
//       home: LoginScreen(),
//     );
//   }
// }

// class LoginScreen extends StatefulWidget {
//   @override
//   _LoginScreenState createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();

//   Future<void> login() async {
//     final prefs = await SharedPreferences.getInstance();
//     String? registeredEmail = prefs.getString('email');
//     String? registeredPassword = prefs.getString('password');

//     if (emailController.text == registeredEmail && passwordController.text == registeredPassword) {
//       prefs.setBool('isLoggedIn', true);
//       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()));
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Invalid credentials')));
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Login')),
//       body: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             TextField(controller: emailController, decoration: InputDecoration(labelText: 'Email')),
//             TextField(controller: passwordController, decoration: InputDecoration(labelText: 'Password'), obscureText: true),
//             SizedBox(height: 20),
//             ElevatedButton(onPressed: login, child: Text('Login')),
//             TextButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterScreen())), child: Text('Register'))
//           ],
//         ),
//       ),
//     );
//   }
// }

// class RegisterScreen extends StatefulWidget {
//   @override
//   _RegisterScreenState createState() => _RegisterScreenState();
// }

// class _RegisterScreenState extends State<RegisterScreen> {
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();

//   Future<void> register() async {
//     final prefs = await SharedPreferences.getInstance();
//     prefs.setString('email', emailController.text);
//     prefs.setString('password', passwordController.text);
//     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Registration Successful!')));
//     Navigator.pop(context);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Register')),
//       body: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             TextField(controller: emailController, decoration: InputDecoration(labelText: 'Email')),
//             TextField(controller: passwordController, decoration: InputDecoration(labelText: 'Password'), obscureText: true),
//             SizedBox(height: 20),
//             ElevatedButton(onPressed: register, child: Text('Register'))
//           ],
//         ),
//       ),
//     );
//   }
// }

// class HomeScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Home')),
//       body: Center(child: Text('Welcome!')),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:matrimony/home.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final Map<String, String> user = {
    'test@example.com': 'password123',
  };

  void login() {
    String email = emailController.text;
    String password = passwordController.text;

    if (user.containsKey(email) && user[email] == password) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => UserList()));
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Login Failed'),
          content: Text('Please make an account first.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[50],
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.pink, width: 4),
                ),
                child: CircleAvatar(
                  radius: 80,
                  backgroundImage: AssetImage('assets/love.jpg'),
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Find Your Perfect Match',
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.pink),
              ),
              SizedBox(height: 20),
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.email, color: Colors.pink),
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  prefixIcon: Icon(Icons.lock, color: Colors.pink),
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: login,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pink,
                  foregroundColor: Colors.white,
                ),
                child: Text('Login'),
              ),
              SizedBox(height: 10),
              TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => RegisterPage(userMap: user)));
                },
                child: Text('Don’t have an account? Register here',
                    style: TextStyle(
                        color: Colors.pink, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

int calculateAge(String birthdate) {
  try {
    DateTime parsedDate = DateFormat('dd-MM-yyyy').parse(birthdate);
    DateTime today = DateTime.now();
    int age = today.year - parsedDate.year;

    if (today.month < parsedDate.month ||
        (today.month == parsedDate.month && today.day < parsedDate.day)) {
      age--;
    }

    return age;
  } catch (e) {
    print("Error parsing date: $e");
    return 0; // Default value in case of error
  }
}

class RegisterPage extends StatefulWidget {
  Map<String, String> userMap = {};
  RegisterPage({super.key, required Map<String, String> userMap});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  void register() {
    String email = emailController.text;
    String password = passwordController.text;
    String confirmPassword = confirmPasswordController.text;

    if (email.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
      _showDialog('Error', 'All fields are required');
      return;
    }
    if (password != confirmPassword) {
      _showDialog('Error', 'Passwords do not match');
      return;
    }

    if (widget.userMap.containsKey(email)) {
      _showDialog('Error', 'This email is already registered.');
      return;
    }

    setState(() {
      widget.userMap[email] = password;
    });

    Navigator.push(
        context, MaterialPageRoute(builder: (context) => HomePage()));
  }

  void _showDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => {print("Hello"), HomePage()},
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[50],
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Create an Account',
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.pink),
              ),
              SizedBox(height: 20),
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.email, color: Colors.pink),
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  prefixIcon: Icon(Icons.lock, color: Colors.pink),
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: confirmPasswordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Confirm Password',
                  prefixIcon: Icon(Icons.lock, color: Colors.pink),
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: register,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pink,
                  foregroundColor: Colors.white,
                ),
                child: Text('Create Account'),
              ),
              SizedBox(height: 10),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('Already have an account? Login',
                    style: TextStyle(
                        color: Colors.pink, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
