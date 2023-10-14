import 'auth_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

//firebase auth user get
final userProvider = StreamProvider<User?>(
  (ref) => ref.read(authProvider).userStream,
);
