import '../../data/models/user.dart';

class ProfileHolder {
  User user = const User(
    email: '',
    image: '',
    name: '',
    surname: '',
    id: 0,
    activeTransfersCount: 0,
    inactiveTransfersCount: 0,
  );

  void updateUser(User updatedUser) => user = updatedUser;
}