import 'package:app/data/repositories/music_repository.dart';
import 'package:app/router/routes.dart';
import 'package:app_logger/app_logger.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({required this.title, super.key});

  final String title;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('title', title));
  }

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> with LoggerMixin {
  @override
  Widget build(BuildContext context) {
    final musicListAsync = ref.watch(musicRepositoryProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        actions: [
          IconButton(
            onPressed: () => const SetlistRoute().push<void>(context),
            icon: const Icon(Icons.library_music),
            tooltip: 'セットリスト',
          ),
          IconButton(
            onPressed: () => const SettingsRoute().push<void>(context),
            icon: const Icon(Icons.settings),
            tooltip: '設定',
          ),
        ],
      ),
      body: musicListAsync.when(
        data: (musicList) => ListView.builder(
          itemCount: musicList.length,
          itemBuilder: (context, index) {
            final music = musicList[index];
            return ListTile(
              leading: Image.network(
                music.thumbnailUrl,
                width: 60,
                height: 60,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => const Icon(
                  Icons.music_note,
                  size: 60,
                ),
              ),
              title: Text(music.title),
              subtitle: Text('ID: ${music.id}'),
            );
          },
        ),
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
        error: (error, stackTrace) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error, size: 64, color: Colors.red),
              const SizedBox(height: 16),
              Text('エラーが発生しました: $error'),
            ],
          ),
        ),
      ),
    );
  }
}
