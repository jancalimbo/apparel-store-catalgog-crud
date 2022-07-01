import 'dart:convert';

import 'package:http/http.dart' as http;



class CreatedData {



  Future dataCreate(name, type, price,stock) async {
    final response =
    await http.post(Uri.parse('http://192.168.1.239:4000/api/apparel/store'),
        body: jsonEncode({
          "name":name,
          "type": type,
          "price": price,
          "stock": stock,
        }),
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
        });
    print(response.statusCode);
    if (response.statusCode == 200) {

      print('Data Created Successfully');
      print(response.body);

    } else {
      print('no item added');
    }
  }

}

