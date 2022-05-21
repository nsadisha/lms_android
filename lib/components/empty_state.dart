import 'package:flutter/material.dart';

class EmptyState extends StatelessWidget {
  final String text;
  const EmptyState({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.warning, size: 40, color: Colors.grey,),
          const SizedBox(height: 10,),
          Text(
              text,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 20
            ),
          ),
        ],
      ),
    );
  }
}
