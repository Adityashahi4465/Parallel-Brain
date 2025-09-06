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

          // Normalize data and sort by date manually
          final items = snapshot.data!.docs.map((doc) {
            final data = doc.data() as Map<String, dynamic>;
            dynamic addedOn =
                getValueIgnoreCase(data, 'added_on') ??
                getValueIgnoreCase(data, 'added on');
            DateTime addedOnDate;

            if (addedOn is Timestamp) {
              addedOnDate = addedOn.toDate();
            } else if (addedOn is String) {
              addedOnDate = DateTime.tryParse(addedOn) ?? DateTime(0);
            } else {
              addedOnDate = DateTime(0);
            }

            return {...data, 'added_on_normalized': addedOnDate};
          }).toList();

          // Sort descending by date
          items.sort(
            (a, b) => (b['added_on_normalized'] as DateTime).compareTo(
              a['added_on_normalized'] as DateTime,
            ),
          );

          return ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 8),
            itemCount: items.length,
            itemBuilder: (context, index) {
              final data = items[index];

              final name = getValueIgnoreCase(data, 'name') ?? 'Unnamed';
              final category = getValueIgnoreCase(data, 'category') ?? '-';
              final price = getValueIgnoreCase(data, 'price') ?? '-';
              final qty = getValueIgnoreCase(data, 'Qty') ?? '-';
              final isDeadStock =
                  getValueIgnoreCase(data, 'isDeadStock') ?? false;
              final addedOn = data['added_on_normalized'] as DateTime?;
              final recommendation =
                  getValueIgnoreCase(data, 'recommendation') ?? {};

              String addedOnStr = addedOn != null
                  ? DateFormat.yMMMd().add_Hm().format(addedOn)
                  : '-';

              // Recommendation only for non-dead stock items
              String? recommendationStr;
              if (!isDeadStock && recommendation is Map) {
                recommendationStr = recommendation.entries
                    .map((e) => '${e.key}: ${e.value}')
                    .join(' | ');
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
                      if (recommendationStr != null) ...[
                        const SizedBox(height: 4),
                        Text(
                          'Recommendation: $recommendationStr',
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ],
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
