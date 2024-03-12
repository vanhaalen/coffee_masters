import 'package:flutter/material.dart';

class OffersPage extends StatelessWidget {
  const OffersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: ListView(
        children: const [
          Offer(
              title: "My greatest offer",
              description: "Buy 1, get 10 for free"),
          Offer(title: "Not great offer", description: "Buy 1, pay for 2"),
          Offer(title: "Not great offer", description: "Buy 1, pay for 2"),
          Offer(title: "Not great offer", description: "Buy 1, pay for 2"),
          Offer(title: "Not great offer", description: "Buy 1, pay for 2"),
          Offer(title: "Not great offer", description: "Buy 1, pay for 2"),
          Offer(title: "Not great offer", description: "Buy 1, pay for 2"),
        ],
      ),
    );
  }
}

class Offer extends StatelessWidget {
  // Properties
  final String title;
  final String description;

  const Offer({
    required this.title,
    required this.description,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
        child: Card(
          elevation: 4,
          color: Colors.amber.shade50,
          child: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(
                    "images/background.png",
                  )),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 6.0),
                  child: Center(
                      child: Container(
                    color: Colors.amber.shade50,
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        title,
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                    ),
                  )),
                ),
                Center(
                    child: Container(
                  color: Colors.amber.shade50,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      description,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
