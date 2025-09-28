import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String? email;
  final String? username;

  const User({
    this.email,
    this.username,
  });

  @override
  List<Object?> get props => [
        email,
        username,
      ];
}
