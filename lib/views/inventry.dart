import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class InventoryScreen extends StatelessWidget {
  const InventoryScreen({super.key});

  // Helper to get values safely ignoring case
  dynamic getValueIgnoreCase(Map<String, dynamic> map, String key) {
    final lowerKey = key.toLowerCase();
    return map.entries
        .firstWhere(
          (e) => e.key.toLowerCase() == lowerKey,
          orElse: () => const MapEntry('', null),
        )
        .value;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Inventory'), centerTitle: true),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('items').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No items found.'));
          }

          final items = snapshot.data!.docs;

          return ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 8),
            itemCount: items.length,
            itemBuilder: (context, index) {
              final data = items[index].data() as Map<String, dynamic>;

              final name = getValueIgnoreCase(data, 'name') ?? 'Unnamed';
              final category = getValueIgnoreCase(data, 'category') ?? '-';
              final price = getValueIgnoreCase(data, 'price') ?? '-';
              final qty = getValueIgnoreCase(data, 'Qty') ?? '-';
              final isDeadStock =
                  getValueIgnoreCase(data, 'isDeadStock') ?? false;
              final addedOn = getValueIgnoreCase(data, 'added_on');
              final recommendation =
                  getValueIgnoreCase(data, 'recommendation') ?? {};

              // Format timestamp
              String addedOnStr = '-';
              if (addedOn is Timestamp) {
                addedOnStr = DateFormat.yMMMd().add_jms().format(
                  addedOn.toDate(),
                );
              } else if (addedOn is String) {
                addedOnStr = addedOn;
              }

              // Recommendation only for non-dead stock items
              String? recommendationStr;
              if (!isDeadStock && recommendation is Map) {
                if (recommendation['Liquidity'] != null) {
                  recommendationStr = 'Email: ${recommendation['Liquidity']}';
                } else if (recommendation['Discount'] != null) {
                  recommendationStr =
                      'Discount: ${recommendation['Discount']}%';
                }
              }

              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                elevation: 4,
                color: isDeadStock ? Colors.grey[200] : Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  title: Text(
                    name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: isDeadStock ? Colors.grey : Colors.black,
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 4),
                      Text('Category: $category'),
                      Text('Price: \$${price.toString()}'),
                      Text('Qty: $qty'),
                      Text(
                        'Dead Stock: ${isDeadStock ? 'Yes' : 'No'}',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: isDeadStock ? Colors.red : Colors.green,
                        ),
                      ),
                      Text('Added On: $addedOnStr'),
                    ],
                  ),
                  isThreeLine: false,
                ),
              );
            },
          );
        },
      ),
    );
  }
}
