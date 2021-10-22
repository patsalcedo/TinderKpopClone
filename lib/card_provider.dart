import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'models/user.dart';

enum CardStatus { like, dislike, superLike }

class CardProvider extends ChangeNotifier {
  List<User> _users = [];
  bool _isDragging = false;
  double _angle = 0;
  Offset _position = Offset.zero;
  Size _screenSize = Size.zero;

  List<User> get users => _users;
  bool get isDragging => _isDragging;
  Offset get position => _position;
  double get angle => _angle;

  CardProvider() {
    resetUsers();
  }

  void setScreenSize(Size screenSize) => _screenSize = screenSize;

  void startPosition(DragStartDetails details) {
    _isDragging = true;
  }

  void updatePosition(DragUpdateDetails details) {
    _position += details.delta;

    final x = _position.dx;
    _angle = 45 * x / _screenSize.width;

    notifyListeners();
  }

  void endPosition() {
    _isDragging = false;
    notifyListeners();

    final status = getStatus(force: true);
    final statusString = status.toString().split('.').last.toUpperCase();

    if(status != null) {
      Fluttertoast.cancel();
      Fluttertoast.showToast(
        msg: statusString,
        fontSize: 36,
      );
    }

    switch(status) {
      case CardStatus.like:
        like();
        break;
      case CardStatus.dislike:
        dislike();
        break;
      case CardStatus.superLike:
        superLike();
        break;
      default:
        resetPosition();
    }

    resetPosition();
  }

  void resetPosition() {
    _isDragging = false;
    _position = Offset.zero;
    _angle = 0;
    notifyListeners();
  }

  void resetUsers() {
    _users = <User>[
      const User(
        name: 'Nayeon',
        age: 25,
        assetImage: 'assets/twice/nayeon.jpg',
      ),
      const User(
        name: 'Jeongyeon',
        age: 24,
        assetImage: 'assets/twice/jeongyeon.jpg',
      ),
      const User(
        name: 'Momo',
        age: 25,
        assetImage: 'assets/twice/momo.jpg',
      ),
      const User(
        name: 'Squid Game Guard',
        age: 38,
        assetImage: 'assets/twice/squid_game_guard.PNG',
      ),
      const User(
        name: 'Sana',
        age: 25,
        assetImage: 'assets/twice/sana.jpg',
      ),
      const User(
        name: 'Jihyo',
        age: 24,
        assetImage: 'assets/twice/jihyo.jpg',
      ),
      const User(
        name: 'Mina',
        age: 24,
        assetImage: 'assets/twice/mina.jpg',
      ),
      const User(
        name: 'Front Man',
        age: 43,
        assetImage: 'assets/twice/squid_game_front_man.PNG',
      ),
      const User(
        name: 'Dahyun',
        age: 23,
        assetImage: 'assets/twice/dahyun.jpg',
      ),
      const User(
        name: 'Chaeyoung',
        age: 22,
        assetImage: 'assets/twice/chaeyoung.jpg',
      ),
      const User(
        name: 'Tzuyu',
        age: 22,
        assetImage: 'assets/twice/tzuyu.jpg',
      ),
    ].reversed.toList();

    notifyListeners();
  }

  double getStatusOpacity() {
    const delta = 100;
    final pos = max(_position.dx.abs(), _position.dy.abs());
    final opacity = pos / delta;

    return min(opacity, 1);
  }

  CardStatus? getStatus({bool force = false}) {
    final x = _position.dx;
    final y = _position.dy;
    final forceSuperLike = x.abs() < 20;


    if(force) {
      const delta = 100;
      if(x >= delta) {
        return CardStatus.like;
      } else if(x <= -delta) {
        return CardStatus.dislike;
      } else if(y <= -delta / 2 && forceSuperLike) {
        return CardStatus.superLike;
      }
    } else {
      const delta = 20;
      if(y <= -delta * 2 && forceSuperLike) {
        return CardStatus.superLike;
      } else if(x >= delta) {
        return CardStatus.like;
      } else if(y <= -delta) {
        return CardStatus.dislike;
      }
    }
  }

  void like() {
    _angle = 20;
    _position += Offset(2 * _screenSize.width, 0);
    _nextCard();

    notifyListeners();
  }

  void dislike() async {
    _angle = -20;
    _position -= Offset(2 * _screenSize.width, 0);
    _nextCard();

    notifyListeners();
  }

  void superLike() async {
    _angle = 0;
    _position -= Offset(0, _screenSize.height);
    _nextCard();

    notifyListeners();
  }

  Future _nextCard() async {
    if(_users.isEmpty) return;

    await Future.delayed(const Duration(milliseconds: 200));
    _users.removeLast();
    resetPosition();
  }
}