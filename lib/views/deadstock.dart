import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class DeadStockScreen extends StatelessWidget {
  const DeadStockScreen({super.key});

  // Helper to get values ignoring case
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
      appBar: AppBar(
        title: const Text('Dead Stock Inventory'),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('items').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No items found.'));
          }

          // Normalize and filter dead stock items
          final items = snapshot.data!.docs
              .map((doc) {
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
              })
              .where((data) => getValueIgnoreCase(data, 'isDeadStock') == true)
              .toList();

          // Sort descending by date
          items.sort(
            (a, b) => (b['added_on_normalized'] as DateTime).compareTo(
              a['added_on_normalized'] as DateTime,
            ),
          );
          // Calculate total dead stock cost and total quantity
          double totalCost = 0;
          int totalQty = 0;
          for (var item in items) {
            final price = getValueIgnoreCase(item, 'price') ?? 0;
            final qty = getValueIgnoreCase(item, 'Qty') ?? 0;
            totalCost += (price as num) * (qty as int);
            totalQty += qty;
          }

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Card(
                        color: Colors.red[100],
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              const Text(
                                'Total Cost',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                '\$${totalCost.toStringAsFixed(2)}',
                                style: const TextStyle(
                                  fontSize: 18,
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Card(
                        color: Colors.orange[100],
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              const Text(
                                'Total Quantity',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                '$totalQty',
                                style: const TextStyle(
                                  fontSize: 18,
                                  color: Colors.orange,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 4),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Dead Stock Items',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    final data = items[index];

                    final name = getValueIgnoreCase(data, 'name') ?? 'Unnamed';
                    final category =
                        getValueIgnoreCase(data, 'category') ?? '-';
                    final price = getValueIgnoreCase(data, 'price') ?? '-';
                    final qty = getValueIgnoreCase(data, 'Qty') ?? '-';
                    final addedOn = getValueIgnoreCase(data, 'added_on');
                    final recommendation =
                        getValueIgnoreCase(data, 'recommendation') ?? {};

                    String addedOnStr = '-';
                    if (addedOn is Timestamp) {
                      addedOnStr = DateFormat.yMMMd().add_jms().format(
                        addedOn.toDate(),
                      );
                    } else if (addedOn is String) {
                      addedOnStr = addedOn;
                    }

                    // Recommendation: show all key-value pairs
                    List<Widget> recommendationWidgets = [];
                    if (recommendation is Map) {
                      recommendation.forEach((key, value) {
                        recommendationWidgets.add(Text('$key: $value'));
                      });
                    }

                    return Card(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      elevation: 3,
                      color: Colors.grey[100],
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
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 4),
                            Text('Category: $category'),
                            Text('Price: \$${price.toString()}'),
                            Text('Qty: $qty'),
                            Text('Added On: $addedOnStr'),
                            const SizedBox(height: 4),
                            Text(
                              'Recommendations:',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 4),

                            ...recommendationWidgets,
                          ],
                        ),
                        isThreeLine: false,
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
