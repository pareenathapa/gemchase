// import 'package:http/http.dart' as http;
// import 'dart:convert';

class ApiEndpoints {
  ApiEndpoints._();

  static const Duration connectionTimeout = Duration(seconds: 1000);
  static const Duration receiveTimeout = Duration(seconds: 1000);
  static const String baseUrl = "http://10.0.2.2:5000/api/";

  // ====================== Auth Routes ======================
  static const String login = "user/login";
  static const String register = "user/create";
  static const String Image = "http://10.0.2.2:5000/jewelerys/";
  static const String uploadImage = "auth/uploadImage";
  static const String getJewelerys = "jewelery/get_all_jewelerys";
  static const limitPage = 5;
}

// class ApiService {
//   // Function to register a user
//   Future<void> registerUser(String firstName, String lastName, String email, String password, String confirmPassword) async {
//     final url = Uri.parse('${ApiEndpoints.baseUrl}${ApiEndpoints.register}');
//     final response = await http.post(
//       url,
//       headers: {'Content-Type': 'application/json'},
//       body: json.encode({
//         'firstName': firstName,
//         'lastName': lastName,
//         'email': email,
//         'password': password,
//         'confirmPassword': confirmPassword,
//       }),
//     );

//     if (response.statusCode == 201) {
//       // Successfully registered
//       print('User registered successfully');
//     } else {
//       // Error
//       print('Failed to register user: ${response.body}');
//     }
//   }

//   // Function to login a user
//   Future<void> loginUser(String email, String password) async {
//     final url = Uri.parse('${ApiEndpoints.baseUrl}${ApiEndpoints.login}');
//     final response = await http.post(
//       url,
//       headers: {'Content-Type': 'application/json'},
//       body: json.encode({
//         'email': email,
//         'password': password,
//       }),
//     );

//     if (response.statusCode == 200) {
//       // Successfully logged in
//       print('Login successful');
//     } else {
//       // Error
//       print('Failed to login: ${response.body}');
//     }
//   }
// }