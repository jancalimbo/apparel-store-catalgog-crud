// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, sized_box_for_whitespace, avoid_print

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'api/function.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  CreatedData obj = CreatedData();
  TextEditingController name = TextEditingController();
  TextEditingController type = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController stock = TextEditingController();

  @override
  void initState() {
    super.initState();
    getData();
    dataDelete(id);
    update(id);
    // obj.dataCreate(name.text, type.text,price.text,stock.text);
    dataCreate();
  }

  List data = [];
  String? id;



  Future dataCreate() async {
    final response =
    await http.post(Uri.parse('http://192.168.1.239:4000/api/apparel/store'),
        body: jsonEncode({
          "name":name.text,
          "type": type.text,
          "price": price.text,
          "stock": stock.text,
        }),
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
        });

    print(response.statusCode);
    if (response.statusCode == 200) {

      print('Data Created Successfully');
      print(response.body);
      name.clear();
      price.clear();
      type.clear();
      stock.clear();
    } else {
      print('error from create');
    }
  }

  Future getData() async {
    final response =
        await http.get(Uri.parse('http://192.168.1.239:4000/api/apparel'));

    if (response.statusCode == 200) {
      setState(() {
        data = jsonDecode(response.body);
      });
      print('Add data-> $data');
    } else {
      print('error');
    }
  }

  Future dataDelete(id) async {
    final response = await http
        .delete(Uri.parse('http://192.168.1.239:4000/api/apparel/delete/$id'));
    print('outside');
    print(response.statusCode);
    final responseShow = await http
        .get(Uri.parse('http://192.168.1.239:4000/api/apparel/$id'));
    print(responseShow.body);
    if (response.statusCode == 200) {
      print('Deleted');
      print(responseShow.body);
    } else {
      print('Not deleted');
    }
  }

  Future update(id) async {
    final response = await http
        .put(Uri.parse('http://192.168.1.239:4000/api/apparel/update/$id'),
            body: jsonEncode({
              "name": name.text,
              "type": type.text,
              "price": price.text,
              "stock": stock.text,
            }),
            headers: {
              'Content-type': 'application/json',
              'Accept': 'application/json',
        });
    print(response.statusCode);
    if (response.statusCode == 200) {
      print('Data updated successfully');
      print(response.body);
      name.clear();
      type.clear();
      price.clear();
      stock.clear();
    } else {
      print('error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Apparel Store Inventory',
          style: TextStyle(
            color: Colors.black,
            fontSize: 30,
            fontFamily: 'GreatVibes',
            fontWeight: FontWeight.bold
          ),
        ),
        backgroundColor: Colors.purple,
        leading: IconButton(
          color: Colors.black,
          onPressed: () => {},
          icon: Icon(Icons.storefront_outlined),
        )
      ),
      body:RefreshIndicator(
        onRefresh: () async {
        await Future.delayed(Duration(seconds: 2));
        getData();
        dataCreate();
    },
        child: SafeArea(
          child: Padding(
          padding: const EdgeInsets.all(20),
            child: Container(

              // color: Colors.black,
              child: Column(
                children: <Widget>[
                TextField(
                  controller: name,
                  decoration: InputDecoration(
                    labelText: 'Product name',
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.purple),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      prefixIcon: Icon(Icons.star, color: Colors.orangeAccent,)
                  ),
                ), SizedBox(height: 10,),
                TextField(
                  controller: type,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.purple),
                        borderRadius: BorderRadius.circular(20.0)
                    ),
                    labelText: 'Stock code',
                    prefixIcon: Icon(Icons.qr_code, color: Colors.black,),
                  ),
                ),
                SizedBox(height: 10,),
                TextField(
                  controller: price,
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.purple),
                          borderRadius: BorderRadius.circular(20.0)
                      ),
                    labelText: 'Price',
                    prefixIcon: Icon(Icons.price_change, color: Colors.green,)
                  ),
                ),
                  SizedBox(height: 10,),
                TextField(
                  controller: stock,
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.purple),
                          borderRadius: BorderRadius.circular(20.0)
                      ),
                    labelText: 'Stocks',
                    prefixIcon: Icon(Icons.production_quantity_limits, color: Colors.blue,)
                  ),
                ),
                  SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.purple,
                        onPrimary: Colors.white,
                        padding: EdgeInsets.fromLTRB(162.0, 15.0, 162.0, 15.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)
                        )
                      ),
                        onPressed: () {
                          setState(() {
                            dataCreate();
                            print('submit button is pressed!');
                          });
                        },
                        child: Text(
                            'Add',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Walkester',
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        )
                    ),
                    // ElevatedButton(
                    //     onPressed: () {
                    //       setState(() {
                    //         update(7);
                    //       });
                    //     },
                    //     child: Text('Update')),
                  ],
                ),
                  SizedBox(height: 20,),
                  Container(
                    // color: Colors.black,
                    child: Text('ITEM LIST',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Walkester',
                    ),
                    ),
                  ),
                  SizedBox(height: 20,),
                  Expanded(
                    child: ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        return Container(
                          height: 200,
                          // width: 50,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.purple, width: 2),
                            // color: Colors.grey,
                          ),
                          // padding: EdgeInsets.all(10.0),
                          margin: EdgeInsets.fromLTRB(0, 10.0, 0, 0),
                          padding: EdgeInsets.fromLTRB(0, 10.0, 0, 10.0),
                          child: ListTile(
                            title: Text(
                                data[index]['name'],
                              style: TextStyle(
                                color: Colors.purple,
                                fontFamily: 'Boho Style',
                                fontSize: 25,
                                fontWeight: FontWeight.bold
                              ),
                            ),
                            subtitle: Text(data[index]['type'], style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),),
                            trailing: Container(
                              padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
                              width: 145,
                              height: 100,
                                // color: Colors.black,
                              child: Row(
                                children: [
                                  Container(
                                    child: IconButton(
                                        onPressed: () {
                                          name.text =
                                          data[index]['name'];
                                          type.text =
                                          data[index]['type'];
                                          price.text =
                                          data[index]['price'];
                                          stock.text =
                                          data[index]['stock'];
                                        },
                                        icon: Icon(Icons.edit, color: Colors.green, size: 30,)),

                                  ),
                                  // SizedBox(height: 10,),
                                  Container(
                                    child: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            update(data[index]['id']);
                                          });
                                        },
                                        icon: Icon(Icons.update, color: Colors.blue, size: 30,)
                                    ),
                                  ),
                                  // SizedBox(height: 10,),
                                  Container(
                                    child: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            dataDelete(data[index]['id']);
                                          });
                                        },
                                        icon: Icon(Icons.delete, color: Colors.red, size: 30,)
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                )
              ],
            ),
          ),
        ),
      ),
    ),
    );
  }
}
