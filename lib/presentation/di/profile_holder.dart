import '../../data/models/user.dart';

class ProfileHolder{
  User user = const User(email: '',image: '',name: '',surname: '', id: 0,transfersCount: 0,);

  void updateUser(User updatedUser) => user = updatedUser;
}