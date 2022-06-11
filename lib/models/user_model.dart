class UserModel {
  String? uid;
  String? name;
  String? email;
  String? dob;
  String? gender;
  String? height;
  String? weight;

  UserModel({this.uid, this.name, this.email, this.dob, this.gender, this.height, this.weight});

  factory UserModel.fromMap(map) {
    return UserModel(
      uid: map["uid"],
      name: map["name"],
      email: map["email"],
      dob: map["dob"],
      gender: map["gender"],
      height: map["height"],
      weight: map["weight"],

    );
  }

  Map<String, dynamic> toMap(){
    return{
      "uid": uid,
      "name": name,
      "email": email,
      "dob": dob,
      "gender": gender,
      "height": height,
      "weight": weight,
    };
  }
}
