

class UserModel {
  String uid;
  String? name;
  String email;
  String? mobile;
  String? image;
  String? deviceToken;

  UserModel(
      { required this.uid,
        this.name,
        required this.email,
        this.mobile,
        this.image,
        this.deviceToken});

  Map<String, dynamic> toMap() {
    return <String, dynamic> {
      'uid' : uid,
      'name' : name,
      'mobile' : mobile,
      'email' : email,
      'image' : image,
      'deviceToken' : deviceToken
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) => UserModel(
    uid: map['uid'],
    name: map['name'],
    mobile: map['mobile'],
    email: map['email'],
    // address: map['address'] == null ? null : AddressModel.fromMap(map['address']),
    image: map['image'],
    deviceToken: map['deviceToken']
  );
}