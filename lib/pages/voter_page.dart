import 'package:flutter/material.dart';

class VoterPage extends StatefulWidget {
  const VoterPage({super.key});

  @override
  State<VoterPage> createState() => _VoterPageState();
}

class _VoterPageState extends State<VoterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'election name',
        ),
      ),
      body: GridView.builder(
        itemCount: 5,
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (context, index) {
          return Card(
            elevation: 4,
            margin: const EdgeInsets.all(18),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'Name',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: Text(
                    'Vote',
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
