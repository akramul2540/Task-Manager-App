import 'package:flutter/material.dart';

Expanded task_summary(int counter, String tittle) {
  return Expanded(
    child: Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [Text('$counter', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),), Text(tittle, style: TextStyle(fontSize: 12),),],
        ),
      ),
    ),
  );
}
