import 'package:flutter/material.dart';

void main() => runApp(BankingApp());

class User {
  final int accountNo;
  final String firstName;
  final String lastName;
  final String address;
  final String phone;
  double balance;

  User({
    required this.accountNo,
    required this.firstName,
    required this.lastName,
    required this.address,
    required this.phone,
    required this.balance,
  });
}

List<User> users = [];

void saveUserDetails(
  String firstName,
  String lastName,
  String address,
  String phone,
) {
  int accountNo = users.length + 1;
  users.add(User(
    accountNo: accountNo,
    firstName: firstName,
    lastName: lastName,
    address: address,
    phone: phone,
    balance: 1000.0,
  ));
}

void addBalance(int accountNo, double amount) {
  User? user = users.firstWhere(
    (user) => user.accountNo == accountNo,
    orElse: () => null,
  );
  if (user != null) {
    user.balance += amount;
  }
}

class BankingApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Banking App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatelessWidget {
  final TextEditingController _accountNoController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _accountNoController,
              decoration: InputDecoration(
                labelText: 'Account Number',
              ),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
              ),
              obscureText: true,
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // Perform login logic here
                int accountNo = int.tryParse(_accountNoController.text) ?? 0;
                String password = _passwordController.text;
                // Validate login credentials and navigate to the dashboard
                User? user = users.firstWhere(
                  (user) => user.accountNo == accountNo && password == 'password',
                  orElse: () => null,
                );
                if (user != null) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DashboardPage(user: user),
                    ),
                  );
                } else {
                  // Show error message
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('Login Error'),
                      content: Text('Invalid account number or password.'),
                      actions: <Widget>[
                        TextButton(
                          child: Text('OK'),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  );
                }
              },
              child: Text('Login'),
            ),
            SizedBox(height: 16.0),
            TextButton(
              onPressed: () {
                // Navigate to the registration page
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RegistrationPage(),
                  ),
                );
              },
              child: Text('Create an account'),
            ),
          ],
