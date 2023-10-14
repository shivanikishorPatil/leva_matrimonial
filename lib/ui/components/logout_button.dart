import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../auth/providers/auth_provider.dart';

class LogoutButton extends ConsumerWidget {
  const LogoutButton({
    Key? key,
  }) : super(key: key);


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.read(authProvider);
    return IconButton(
      onPressed: () {
        auth.signOut();
      },
      icon: const Icon(Icons.logout),
    );
  }
}
