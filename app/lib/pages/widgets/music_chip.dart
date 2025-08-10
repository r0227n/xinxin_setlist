import 'package:app/data/services/setlist_service.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cores/cores.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

typedef MusicOnPressed = void Function(Music);

class WrapSetlist extends ConsumerStatefulWidget {
  const WrapSetlist({
    required List<String> musicOrderIds,
    required MusicOnPressed onPressed,
    super.key,
  }) : _musicOrderIds = musicOrderIds,
       _onPressed = onPressed;

  final List<String> _musicOrderIds;
  final MusicOnPressed _onPressed;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _WrapSetlistState();
}

class _WrapSetlistState extends ConsumerState<WrapSetlist> {
  late final Future<List<Music>> _asyncMusic;

  @override
  void initState() {
    super.initState();
    _asyncMusic = ref
        .read(setlistServiceProvider)
        .getMusicFromMusicOrderIds(widget._musicOrderIds);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _asyncMusic,
      builder: (context, snapshot) {
        return switch ((snapshot.connectionState, snapshot.hasData)) {
          (ConnectionState.done, true) => Wrap(
            spacing: 4,
            runSpacing: 4,
            children:
                snapshot.data
                    ?.map(
                      (e) => ActionChip(
                        avatar: CachedNetworkImage(
                          imageUrl: e.thumbnailUrl,
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.info),
                        ),
                        label: Text(e.title),
                        onPressed: () {
                          widget._onPressed(e);
                        },
                      ),
                    )
                    .toList() ??
                [],
          ),
          (ConnectionState.done, false) => const SizedBox.shrink(),
          (ConnectionState.waiting, _) => const CircularProgressIndicator(),
          (_, _) => const SizedBox.shrink(),
        };
      },
    );
  }
}
