
class UserModel{

  late final String? uid;
  final String? name;
  final String? email;
  final String? image;
  final String? provider;



  factory UserModel.fromMap(Map<String,dynamic> data){
    return UserModel(
      uid: data['uid'],
      name:data ['name'],
      email: data['email'],
      image: data['image'],
      provider: data['provider'],
    );
  }

  UserModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.image,
    required this.provider,
  });

  Map<String,dynamic>toJosn()=>{
    'uid':uid,
    'name':name,
    'email':email,
    'image':image,
    'provider':provider,
  };
}