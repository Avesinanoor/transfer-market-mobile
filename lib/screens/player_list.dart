import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:transfer_market/models/player_entry.dart';
import 'package:transfer_market/widgets/app_drawer.dart';
import 'package:transfer_market/widgets/player_card.dart';
import 'package:transfer_market/screens/player_detail.dart';

class PlayerListPage extends StatefulWidget {
  final String filter; // 'all' or 'my'
  final String title;

  const PlayerListPage({
    super.key,
    required this.filter,
    required this.title,
  });

  @override
  State<PlayerListPage> createState() => _PlayerListPageState();
}

class _PlayerListPageState extends State<PlayerListPage> {
  Future<List<PlayerEntry>> fetchPlayers(CookieRequest request) async {
    final response = await request
        .get('http://localhost:8000/api/players/?filter=${widget.filter}');

    final List<dynamic> data = response['players'] ?? [];
    List<PlayerEntry> players = [];
    for (var d in data) {
      if (d != null) {
        players.add(PlayerEntry.fromJson(d as Map<String, dynamic>));
      }
    }
    return players;
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      drawer: const AppDrawer(),
      body: FutureBuilder<List<PlayerEntry>>(
        future: fetchPlayers(request),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Failed to load players.\n${snapshot.error}',
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }

          final players = snapshot.data ?? [];

          if (players.isEmpty) {
            return const Center(
              child: Text(
                'No players found.',
                style: TextStyle(fontSize: 16),
              ),
            );
          }

          return ListView.builder(
            itemCount: players.length,
            itemBuilder: (context, index) {
              final player = players[index];
              return PlayerCard(
                player: player,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PlayerDetailPage(player: player),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}

