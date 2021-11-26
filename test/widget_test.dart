import 'package:donateplasma/providers/users.dart';
import 'package:flutter_test/flutter_test.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

void main() async {

  Uri url = Uri.parse("https://api.rajaongkir.com/starter/province");
  // Uri urlc = Uri.parse("https://api.rajaongkir.com/starter/city");

  final response = await  http.get(url, headers: {
    "key": "6cfef77420547f9bf2f093096cbe160d",
  });






  print(response.body);
  test('One Classroom Should Be Deleted, One Should Be Added', () {
    // final users = Users();
    final initialLength = 10;

    // expect(users.userList.length, initialLength);


  });

}
