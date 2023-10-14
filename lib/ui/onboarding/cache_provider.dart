import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

//method get onboarding check data
final cacheProvider = FutureProvider((ref)=>SharedPreferences.getInstance());