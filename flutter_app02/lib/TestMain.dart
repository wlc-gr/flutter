import './User.dart';
import './Address.dart';
import 'package:path/path.dart' as path;

// void main() {
//   // User user = User('wanglaicai', 'wanglaicai@163.com', 29);

//   // //print(user.toJson());
//   // var usermap = {
//   //   'name': 'wanglaicai88',
//   //   'email': 'wanglaicai888@163.com',
//   //   'age': 29
//   // };
//   // User user2 = User.fromJson(usermap);
//   // print(user2.toJson());
//   Address address = Address("My st.", "New York");
//   User user = User("John", 'sxxx',23,address);
//   print(user.toJson());
// }

void main() {
  String _path = path.join('directory', 'file.txt');
  print('$_path -------------');

  print('Current path style: ${path.style}');

  print('Current process path: ${path.current}');

  print('Separators');
  for (var entry in [path.posix, path.windows, path.url]) {
    print('  ${entry.style.toString().padRight(7)}: ${entry.separator}');
  }
}
