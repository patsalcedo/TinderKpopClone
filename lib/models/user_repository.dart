import 'user.dart';

class UserRepository {
  static List<User> loadUsers() {
    const allUsers = <User> [
      User(
        name: 'Nayeon',
        age: 25,
        assetImage: 'assets/twice/nayeon.jpg',
      ),
      User(
        name: 'Jeongyeon',
        age: 24,
        assetImage: 'assets/twice/jeongyeon.jpg',
      ),
      User(
        name: 'Momo',
        age: 25,
        assetImage: 'assets/twice/momo.jpg',
      ),
      User(
        name: 'Squid Game Guard',
        age: 38,
        assetImage: 'assets/twice/squid_game_guard.PNG',
      ),
      User(
        name: 'Sana',
        age: 25,
        assetImage: 'assets/twice/sana.jpg',
      ),
      User(
        name: 'Jihyo',
        age: 24,
        assetImage: 'assets/twice/jihyo.jpg',
      ),
      User(
        name: 'Mina',
        age: 24,
        assetImage: 'assets/twice/mina.jpg',
      ),
      User(
        name: 'Front Man',
        age: 43,
        assetImage: 'assets/twice/squid_game_front_man.PNG',
      ),
      User(
        name: 'Dahyun',
        age: 23,
        assetImage: 'assets/twice/dahyun.jpg',
      ),
      User(
        name: 'Chaeyoung',
        age: 22,
        assetImage: 'assets/twice/chaeyoung.jpg',
      ),
      User(
        name: 'Tzuyu',
        age: 22,
        assetImage: 'assets/twice/tzuyu.jpg',
      ),
    ];
    return allUsers;
  }
}