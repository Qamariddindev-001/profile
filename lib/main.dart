import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<String> getPhoneNumber() async {
  print('started');
  String url = 'https://randomuser.me/api/';
  Uri uri = Uri.parse(url);

  http.Response response = await http.get(uri);

  Map m = jsonDecode(response.body);
  print('phone');

  return m['results'][0]['phone'];
}

Future<String> getImage() async {
  print('started');
  String url = 'https://randomuser.me/api/';
  Uri uri = Uri.parse(url);

  http.Response response = await http.get(uri);

  Map m = jsonDecode(response.body);
  print('image');

  return m['results'][0]['picture']['large'];
}

Future<String> getName() async {
  print('started');
  String url = 'https://randomuser.me/api/';
  Uri uri = Uri.parse(url);

  http.Response response = await http.get(uri);

  Map m = jsonDecode(response.body);
  print('name');

  return m['results'][0]['name']['first'] + '  ' + m['results'][0]['name']['last'];
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String phoneNumber = '1234';
  String name1 = 'men';
  String image = 'assets/Ellipse 4.png';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 21.0, top: 11),
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 211, 226, 248),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.arrow_back,
                                color: Color.fromARGB(255, 62, 127, 224),
                              )),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 17),
                  const Text(
                    'Profile',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.99,
                    ),
                  ),
                  const SizedBox(height: 43),
                  CircleAvatar(
                    radius: 80.5,
                    backgroundImage: NetworkImage(image),
                  ),
                  const SizedBox(height: 51),
                  Rectangle(name: name1, icon: Icons.person),
                  const SizedBox(height: 21),
                  Rectangle(name: phoneNumber, icon: Icons.phone),
                  const SizedBox(height: 21),
                  ElevatedButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))),
                      minimumSize: MaterialStateProperty.all(const Size(325, 50)),
                    ),
                    onPressed: () async {
                      phoneNumber = await getPhoneNumber();
                      name1 = await getName();
                      image = await getImage();
                      setState(() {});
                    },
                    child: const Text(
                      'Next',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                    ),
                  ),
                ],
              ),
              const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.medical_services_outlined, size: 40, color: Color.fromARGB(255, 62, 127, 224)),
                  Text(
                    'TALKBOX',
                    style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class Rectangle extends StatelessWidget {
  final String name;
  final IconData icon;
  const Rectangle({
    super.key,
    required this.name,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 325,
      height: 50,
      padding: const EdgeInsets.only(left: 19, right: 65, top: 16, bottom: 16),
      decoration: BoxDecoration(color: const Color.fromARGB(255, 228, 227, 227), borderRadius: BorderRadius.circular(30)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 24),
          const SizedBox(width: 49),
          Text(
            name,
            style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w400),
          ),
        ],
      ),
    );
  }
}
