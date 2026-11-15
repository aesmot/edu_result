

// ছোট উইজেট হিসেবে ব্যবহারের জন্য একটি কম্পোনেন্ট
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdminResultViewCard extends StatelessWidget {
  const AdminResultViewCard({super.key});

  @override
  Widget build(BuildContext context) {
    // এখানে আপনার রেজাল্ট পেজের ভেতরের ডিজাইন বা লিস্ট ভিউ থাকবে
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Result Summary', style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          // আপনার রেজাল্টের ছোট কন্টেন্ট বা লিস্ট
          Text('Total Published Results: 45'),
        ],
      ),
    );
  }
}