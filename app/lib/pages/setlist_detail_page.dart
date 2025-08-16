import 'package:app/data/repositories/event_repository.dart';
import 'package:app/data/repositories/music_repository.dart';
import 'package:app/data/repositories/stage_repository.dart';
import 'package:app/data/services/setlist_service.dart';
import 'package:app/i18n/translations.g.dart';
import 'package:app/pages/widgets/share_button.dart';
import 'package:app/router/routes.dart';
import 'package:app_logger/app_logger.dart';
import 'package:app_preferences/app_preferences.dart';
import 'package:cores/cores.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// セットリスト詳細データ
typedef SetlistDetail = (Setlist, Event, Stage?);

/// セットリスト詳細表示ページ
///
/// 指定された[eventId]のセットリストを詳細表示する
class SetlistDetailPage extends ConsumerStatefulWidget {
  const SetlistDetailPage({
    required this.eventId,
    super.key,
  });

  /// 表示するセットリストのイベントID
  final String eventId;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('eventId', eventId));
  }

  @override
  ConsumerState<SetlistDetailPage> createState() => _SetlistDetailPageState();
}

class _SetlistDetailPageState extends ConsumerState<SetlistDetailPage>
    with LoggerMixin {
  late final Future<SetlistDetail> _setlistDetailAsync;

  @override
  void initState() {
    super.initState();
    _setlistDetailAsync = (
      ref.read(setlistServiceProvider).getSetlist(widget.eventId),
      ref.read(eventRepositoryProvider.notifier).get(widget.eventId),
      ref.read(stageRepositoryProvider.notifier).getFromEventId(widget.eventId),
    ).wait;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () => const SettingsRoute().go(context),
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
      body: FutureBuilder<SetlistDetail>(
        future: _setlistDetailAsync,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            logError('Setlist detail fetch error: ${snapshot.error}');
            return Center(
              child: Icon(
                Icons.error,
                size: AppIconSizes.xxl,
                color: Theme.of(context).colorScheme.error,
              ),
            );
          }

          final (setlist, event, stage) = snapshot.data!;
          logInfo('Showing setlist detail: ${setlist.id}');

          return SingleChildScrollView(
            padding: const EdgeInsets.all(AppSpacing.medium),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: AppSpacing.large,
              children: [
                // イベント情報カード
                _EventInfoCard(event: event, stage: stage),

                // セットリスト
                _MusicListWidget(musicIds: setlist.musicIds),
              ],
            ),
          );
        },
      ),
    );
  }
}

/// イベント情報カードWidget
class _EventInfoCard extends StatelessWidget {
  const _EventInfoCard({
    required Event event,
    Stage? stage,
  }) : _event = event,
       _stage = stage;

  final Event _event;
  final Stage? _stage;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.medium),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: AppSpacing.small,
          children: [
            _ContentHeader(
              leading: Icon(
                Icons.event,
                size: AppIconSizes.medium,
                color: Theme.of(context).colorScheme.primary,
              ),
              title: Text(
                t.setlist.detail.eventInfo,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              trailing: ShareButton(
                url:
                    'https://r0227n.github.io/xinxin_setlist/#/setlist/${_event.id}',
              ),
            ),
            const Divider(),
            _InfoRow(
              label: t.setlist.detail.eventTitle,
              value: _event.title,
            ),
            _InfoRow(
              label: t.setlist.date,
              value: _event.date.toString().split(' ')[0],
            ),
            if (_stage != null)
              _InfoRow(
                label: t.setlist.detail.venue,
                value: _stage.title,
              ),
            if (_event.order != null)
              _InfoRow(
                label: t.setlist.detail.eventOrder,
                value: _event.order.toString(),
              ),
          ],
        ),
      ),
    );
  }
}

/// 情報行Widget
class _InfoRow extends StatelessWidget {
  const _InfoRow({
    required String label,
    required String value,
  }) : _label = label,
       _value = value;

  final String _label;
  final String _value;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Text(
            _label,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ),
        Expanded(
          flex: 9,
          child: Text(
            _value,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
      ],
    );
  }
}

/// 音楽リストWidget
class _MusicListWidget extends ConsumerWidget with LoggerMixin {
  const _MusicListWidget({
    required List<String> musicIds,
  }) : _musicIds = musicIds;

  final List<String> _musicIds;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (_musicIds.isEmpty) {
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.large),
          child: Center(
            child: Column(
              spacing: AppSpacing.medium,
              children: [
                Icon(
                  Icons.library_music,
                  size: AppIconSizes.xxl,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
                Text(
                  t.setlist.empty.noSetlist,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(AppSpacing.medium),
            child: _ContentHeader(
              leading: Icon(
                Icons.library_music,
                size: AppIconSizes.medium,
                color: Theme.of(context).colorScheme.primary,
              ),
              title: Text(
                t.setlist.detail.musicList,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              trailing: Chip(
                label: Text(
                  t.setlist.detail.musicCount(count: _musicIds.length),
                ),
                backgroundColor: Theme.of(
                  context,
                ).colorScheme.primaryContainer,
              ),
            ),
          ),
          const Divider(height: 1),
          _OrderedMusicList(musicIds: _musicIds),
        ],
      ),
    );
  }
}

class _ContentHeader extends StatelessWidget {
  const _ContentHeader({
    required Widget title,
    Widget? leading,
    Widget? trailing,
    EdgeInsets padding = const EdgeInsets.symmetric(
      vertical: AppSpacing.extraSmall,
    ),
  }) : _title = title,
       _leading = leading,
       _trailing = trailing,
       _padding = padding;

  final Widget _title;
  final Widget? _leading;
  final Widget? _trailing;
  final EdgeInsets _padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: _padding,
      child: ListTile(
        leading: _leading,
        title: _title,
        trailing: _trailing,
        contentPadding: EdgeInsets.zero,
      ),
    );
  }
}

/// 順序付き音楽リストWidget
class _OrderedMusicList extends ConsumerWidget with LoggerMixin {
  const _OrderedMusicList({
    required List<String> musicIds,
  }) : _musicIds = musicIds;

  final List<String> _musicIds;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder<List<Music>>(
      future: ref
          .read(musicRepositoryProvider.notifier)
          .getByMusicIds(_musicIds),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Padding(
            padding: EdgeInsets.all(AppSpacing.large),
            child: Center(child: CircularProgressIndicator()),
          );
        }

        if (snapshot.hasError) {
          logError('Music data fetch error: ${snapshot.error}');
          return Center(
            child: Text(
              '${t.setlist.error.dataFetchFailed}: ${snapshot.error}',
              style: TextStyle(color: Theme.of(context).colorScheme.error),
            ),
          );
        }

        final musics = snapshot.data!;
        if (musics.isEmpty) {
          return Padding(
            padding: const EdgeInsets.all(AppSpacing.large),
            child: Center(
              child: Text(
                t.setlist.empty.noSetlist,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          );
        }

        // musicIdsの順序でソート
        final orderedMusics = <Music>[];
        for (final musicId in _musicIds) {
          final music = musics.where((m) => m.id == musicId).firstOrNull;
          if (music != null) {
            orderedMusics.add(music);
          }
        }

        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: orderedMusics.length,

          itemBuilder: (context, index) {
            final music = orderedMusics[index];

            return ListTile(
              contentPadding: const EdgeInsets.all(AppSpacing.small),
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(AppBorderRadius.medium),
                child: Image.network(
                  music.thumbnailUrl,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) =>
                      loadingProgress == null
                      ? child
                      : const Center(child: CircularProgressIndicator()),
                  errorBuilder: (context, error, stackTrace) => DecoratedBox(
                    decoration: BoxDecoration(
                      color: Theme.of(
                        context,
                      ).colorScheme.surfaceContainerHighest,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Icon(
                      Icons.music_note,
                      size: AppIconSizes.extraLarge,
                      color: Theme.of(
                        context,
                      ).colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),
              ),
              title: Text(
                music.title,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
              subtitle: Text(
                t.setlist.detail.musicNumber(number: index + 1),
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                  fontWeight: FontWeight.w100,
                ),
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios,
                size: AppIconSizes.small,
              ),
              onTap: () => MusicDetailRoute(musicId: music.id).go(context),
            );
          },
        );
      },
    );
  }
}
