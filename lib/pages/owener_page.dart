import 'package:flutter/material.dart';
import 'package:vote_app/services/functions.dart';
import 'package:web3dart/web3dart.dart';

class OwenerPage extends StatefulWidget {
  final Web3Client ethClient;
  final String electionName;
  const OwenerPage(
      {super.key, required this.ethClient, required this.electionName});

  @override
  State<OwenerPage> createState() => _OwenerPageState();
}

class _OwenerPageState extends State<OwenerPage> {
  TextEditingController addCandidateController = TextEditingController();
  TextEditingController authorizeVoterController = TextEditingController();
  @override
  void dispose() {
    addCandidateController.dispose();
    authorizeVoterController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.electionName),
        actions: [
          IconButton(
              onPressed: () {
                setState(() {});
              },
              icon: const Icon(Icons.refresh)),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(14),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    FutureBuilder<List>(
                        future: getCandidatesNum(widget.ethClient),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          return Text(
                            snapshot.data![0].toString(),
                            style: const TextStyle(
                                fontSize: 50, fontWeight: FontWeight.bold),
                          );
                        }),
                    const Text('Total Candidates')
                  ],
                ),
                Column(
                  children: [
                    FutureBuilder<List>(
                        future: getTotalVotes(widget.ethClient),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          return Text(
                            snapshot.data![0].toString(),
                            style: const TextStyle(
                                fontSize: 50, fontWeight: FontWeight.bold),
                          );
                        }),
                    const Text('Total Votes')
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: addCandidateController,
                    decoration:
                        const InputDecoration(hintText: 'Enter Candidate Name'),
                  ),
                ),
                ElevatedButton(
                    onPressed: () async {
                      await addCandidate(
                          addCandidateController.text, widget.ethClient);
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('Candidate added successfully')));
                      addCandidateController.clear();
                    },
                    child: Text(
                      'Add Candidate',
                      style: Theme.of(context).textTheme.displaySmall,
                    ))
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: authorizeVoterController,
                    decoration:
                        const InputDecoration(hintText: 'Enter Voter address'),
                  ),
                ),
                ElevatedButton(
                    onPressed: () {
                      authorizeVoter(
                          authorizeVoterController.text, widget.ethClient);
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('Candidate added successfully')));
                      authorizeVoterController.clear();
                    },
                    child: Text(
                      'Add Voter',
                      style: Theme.of(context).textTheme.displaySmall,
                    ))
              ],
            ),
            const Divider(thickness: 5),
            Expanded(
              child: FutureBuilder<List>(
                future: getCandidatesNum(widget.ethClient),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: snapshot.data![0].toInt(),
                      itemBuilder: (context, i) {
                        return FutureBuilder<List>(
                          future: candidateInfo(i, widget.ethClient),
                          builder: (context, candidatesnapshot) {
                            if (candidatesnapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            } else {
                              return ListTile(
                                title: Text(
                                    'Name: ${candidatesnapshot.data![0][0]}'),
                                subtitle: Text(
                                    'Votes: ${candidatesnapshot.data![0][1]}'),
                                // trailing: ElevatedButton(
                                //     onPressed: () {
                                //       vote(i, widget.ethClient);
                                //     },
                                //     child: const Text('Vote')),
                              );
                            }
                          },
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
