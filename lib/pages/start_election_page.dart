import 'package:flutter/material.dart';
import 'package:vote_app/pages/owener_page.dart';
import 'package:vote_app/services/functions.dart';
import 'package:web3dart/web3dart.dart';

class StartElectionPage extends StatefulWidget {
  final Web3Client ethClient;
  const StartElectionPage({super.key, required this.ethClient});

  @override
  State<StartElectionPage> createState() => _StartElectionPageState();
}

class _StartElectionPageState extends State<StartElectionPage> {
  TextEditingController controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Election'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: controller,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  labelText: 'Election Name',
                  // filled: true,
                  hintText: 'e.g: presidential election'),
            ),
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              width: double.infinity,
              height: 45,
              child: ElevatedButton(
                onPressed: () async {
                  if (controller.text.isNotEmpty) {
                    const Center(child: CircularProgressIndicator());
                    await startElection(controller.text, widget.ethClient);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => OwenerPage(
                            ethClient: widget.ethClient,
                            electionName: controller.text),
                      ),
                    );
                  }
                },
                child: Text(
                  'Start Election',
                  style: Theme.of(context).textTheme.displaySmall,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
