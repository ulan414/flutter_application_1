import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class RegistrationProvider extends ChangeNotifier {
  String? name;
  int? age;
  List<String> interests = [];
  String? gender;
  List<String> photos = []; // пути к фото или url
  String? phone;
  String? email;

  void setName(String value) { name = value; notifyListeners(); }
  void setAge(int value) { age = value; notifyListeners(); }
  void setGender(String value) { gender = value; notifyListeners(); }
  void setPhone(String value) { phone = value; notifyListeners(); }
  void setEmail(String value) { email = value; notifyListeners(); }

  void setInterests(List<String> value) { interests = value; notifyListeners(); }
  void addInterest(String value) { interests.add(value); notifyListeners(); }
  void removeInterest(String value) { interests.remove(value); notifyListeners(); }

  void setPhotos(List<String> value) { photos = value; notifyListeners(); }
  void addPhoto(String value) { photos.add(value); notifyListeners(); }
  void removePhoto(String value) { photos.remove(value); notifyListeners(); }

Future<void> saveToSupabase() async {
  final supabase = Supabase.instance.client;
  final userId = supabase.auth.currentUser?.id;
  await supabase.from('profiles').upsert({
    'id': userId,  // важно!
    'username': name,
    'phone': phone,
    'email': email,
    'age': age,
    'gender': gender,
    'interests': interests,
    'photos': photos,
  });
}
}