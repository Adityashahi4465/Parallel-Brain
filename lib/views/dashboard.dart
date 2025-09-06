import 'package:fintech/views/chat_bot_screen.dart';
import 'package:fintech/views/create_stock.dart';
import 'package:fintech/views/deadstock.dart';
import 'package:fintech/views/inventry.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Dashboard'),
          actions: [
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
              },
            ),
          ],
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.all(20),
                height: 150,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => InventoryScreen()),
                    );
                  },
                  child: const Text(
                    'Inventory',
                    style: TextStyle(fontSize: 24),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(20),
                height: 150,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => DeadStockScreen()),
                    );
                  },
                  child: const Text(
                    'DeadStock',
                    style: TextStyle(fontSize: 24),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(20),
                height: 150,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const ChatBotScreen()),
                    );
                  },
                  child: const Text('Chatbot', style: TextStyle(fontSize: 24)),
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const AddItemScreen()),
            );
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
