import 'dart:async';

import 'package:apialbum/screen/update.dart';
import 'package:apialbum/services/services.dart';
import 'package:flutter/material.dart';

import '../services/models.dart';

class MyhomePage extends StatefulWidget {
  const MyhomePage({Key? key}) : super(key: key);

  @override
  State<MyhomePage> createState() => _MyhomePageState();
}

class _MyhomePageState extends State<MyhomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fetch Data Example'),
      ),
      body: Center(
        child: FutureBuilder<List<Post>>(
          future: Services.getProductList(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GridView.builder(
                      itemCount: snapshot.data!.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                      ),
                      itemBuilder: (BuildContext context, index) {
                        var uid = snapshot.data![index].id.toString();
                        return Card(
                          child: Container(
                            decoration: BoxDecoration(
                                border:
                                    Border.all(width: 0.5, color: Colors.grey)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: <Widget>[
                                  Text(
                                    snapshot.data![index].userId.toString(),
                                  ),
                                  Text(
                                    snapshot.data![index].id.toString(),
                                  ),
                                  Text(
                                    snapshot.data![index].title.toString(),
                                  ),
                                  Row(
                                    children: [
                                      ElevatedButton(
                                          onPressed: () {
                                            setState(() {
                                              print(uid);
                                              Services.deletePost(uid);
                                            });
                                          },
                                          child: Text('Delete')),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      ElevatedButton(
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      UpdateScreen()),
                                            );
                                          },
                                          child: Text('update')),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      }));
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }

            // By default, show a loading spinner.
            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
