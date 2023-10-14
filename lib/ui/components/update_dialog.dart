import 'package:flutter/material.dart';
import 'package:launch_review/launch_review.dart';

class UpdatePage extends StatelessWidget {
  static const route = "/updateDialog";
  const UpdatePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = theme.textTheme;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Update Available',
                style: style.headline6,
              ),
              const SizedBox(
                height: 30,
              ),
              const Text(
                  'An Update of this app is available\nPlease update to continue.'),
              const SizedBox(
                height: 25,
              ),
              ElevatedButton(
                  onPressed: () {
                    LaunchReview.launch();
                  },
                  child: const Text('Update'))
            ],
          ),
        ),
      ),
    );
  }
}
