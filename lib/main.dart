import 'package:flutter/material.dart';

import 'package:flutter_restapi_ex/api_service.dart';
import 'package:flutter_restapi_ex/photo_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: const MyHomePage(title: 'Hello Flutter My Old Friend'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  //new_start
  late List<Photo>? _photo = [];
  @override
  void initState() {
    super.initState();
    _getData();
  }
  void _getData() async {
    _photo = (await ApiService().getPhotos())!;
    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {}));
  }
  //new_end


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('REST API Example'),
      ),
      body: _photo == null || _photo!.isEmpty
          ? const Center(
        child: CircularProgressIndicator(),
      )
          : ListView.builder(
        itemCount: _photo!.length,
        itemBuilder: (context, index) {
          return Card(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(_photo![index].id.toString()),
                    Text(_photo![index].title),
                  ],
                ),
                SizedBox(
                  height: 200.0,
                  child: Card(
                    child: Center(
                      child: Image.network(_photo![index].url, fit: BoxFit.cover)
                    ), //Center
                  ), //Card
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
