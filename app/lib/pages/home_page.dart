import 'package:app/data/repositories/event_repository.dart';
import 'package:app/data/repositories/music_repository.dart';
import 'package:app/router/routes.dart';
import 'package:app_logger/app_logger.dart';
import 'package:app_preferences/app_preferences.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cores/cores.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> with LoggerMixin {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final eventRepositoryAsync = ref.watch(eventRepositoryProvider);
    final musicRepositoryAsync = ref.watch(musicRepositoryProvider);
    final isWideScreen = MediaQuery.of(context).size.width > 1200;

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      body: CustomScrollView(
        slivers: [
          // Compact header
          _buildCompactHeader(context, theme),

          // Main content with Spotify-like sections
          SliverPadding(
            padding: EdgeInsets.symmetric(
              horizontal: isWideScreen ? 40.0 : AppSpacing.medium,
            ),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                const SizedBox(height: AppSpacing.large),
                
                // Welcome section
                _buildWelcomeSection(context, theme),
                const SizedBox(height: AppSpacing.extraLarge),

                // Recently Played Events (Spotify-like horizontal scrolling)
                _buildRecentlyPlayedSection(
                  context,
                  eventRepositoryAsync,
                  musicRepositoryAsync,
                  theme,
                ),
                const SizedBox(height: AppSpacing.extraLarge),

                // Made for You (Popular Songs) - Grid layout like Spotify
                _buildMadeForYouSection(
                  context,
                  musicRepositoryAsync,
                  theme,
                ),
                const SizedBox(height: AppSpacing.extraLarge),

                // Jump back in (Quick Actions as cards)
                _buildJumpBackInSection(context, theme),
                const SizedBox(height: AppSpacing.extraLarge * 2),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCompactHeader(BuildContext context, ThemeData theme) {
    return SliverAppBar(
      floating: true,
      snap: true,
      toolbarHeight: 64,
      backgroundColor: theme.colorScheme.surface,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      title: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  const Color(0xFF1DB954),
                  theme.colorScheme.primary,
                ],
              ),
              borderRadius: BorderRadius.circular(6),
            ),
            child: const Icon(
              Icons.music_note,
              color: Colors.white,
              size: 20,
            ),
          ),
          const SizedBox(width: AppSpacing.medium),
          Text(
            'XINXIN SETLIST',
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
      actions: [
        IconButton(
          onPressed: () => const SettingsRoute().go(context),
          icon: Icon(
            Icons.settings_outlined,
            color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
          ),
        ),
        const SizedBox(width: AppSpacing.small),
      ],
    );
  }

  Widget _buildWelcomeSection(BuildContext context, ThemeData theme) {
    final hour = DateTime.now().hour;
    String greeting;
    if (hour < 12) {
      greeting = 'おはよう';
    } else if (hour < 18) {
      greeting = 'こんにちは';
    } else {
      greeting = 'こんばんは';
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          greeting,
          style: theme.textTheme.headlineLarge?.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: 32,
          ),
        ),
        const SizedBox(height: AppSpacing.medium),
        Text(
          '今日も素敵な音楽を楽しもう',
          style: theme.textTheme.bodyLarge?.copyWith(
            color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
          ),
        ),
      ],
    );
  }

  Widget _buildJumpBackInSection(BuildContext context, ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'すぐにアクセス',
          style: theme.textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        const SizedBox(height: AppSpacing.large),
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          mainAxisSpacing: AppSpacing.medium,
          crossAxisSpacing: AppSpacing.medium,
          childAspectRatio: 3.5,
          children: [
            _buildQuickAccessCard(
              context,
              theme,
              title: 'セットリスト',
              icon: Icons.queue_music,
              onTap: () => const SetlistRoute().go(context),
            ),
            _buildQuickAccessCard(
              context,
              theme,
              title: '楽曲検索',
              icon: Icons.search,
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('検索機能は準備中です'),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildQuickAccessCard(
    BuildContext context,
    ThemeData theme, {
    required String title,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Material(
      color: theme.colorScheme.surfaceContainerHigh,
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.medium),
          child: Row(
            children: [
              Icon(
                icon,
                size: 24,
                color: theme.colorScheme.onSurface,
              ),
              const SizedBox(width: AppSpacing.medium),
              Expanded(
                child: Text(
                  title,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRecentlyPlayedSection(
    BuildContext context,
    AsyncValue<List<Event>> eventRepositoryAsync,
    AsyncValue<List<Music>> musicRepositoryAsync,
    ThemeData theme,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '最近のライブ',
              style: theme.textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
            TextButton(
              onPressed: () => const SetlistRoute().go(context),
              child: Text(
                'すべて表示',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.large),
        _buildRecentEventsHorizontal(
          context, eventRepositoryAsync, musicRepositoryAsync, theme),
      ],
    );
  }

  Widget _buildMadeForYouSection(
    BuildContext context,
    AsyncValue<List<Music>> musicRepositoryAsync,
    ThemeData theme,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'あなたにおすすめ',
          style: theme.textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        const SizedBox(height: AppSpacing.large),
        _buildPopularSongsGrid(context, musicRepositoryAsync, theme),
      ],
    );
  }

  Widget _buildRecentEventsHorizontal(
    BuildContext context,
    AsyncValue<List<Event>> eventRepositoryAsync,
    AsyncValue<List<Music>> musicRepositoryAsync,
    ThemeData theme,
  ) {
    return switch ((eventRepositoryAsync, musicRepositoryAsync)) {
      (
        AsyncData(value: final events),
        AsyncData(value: final musicList)
      ) => () {
          final recentEvents = [...events]
            ..sort((a, b) => b.date.compareTo(a.date))
            ..take(6);

          return SizedBox(
            height: 200,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: recentEvents.length,
              padding: const EdgeInsets.only(right: AppSpacing.medium),
              itemBuilder: (context, index) {
                final event = recentEvents.elementAt(index);
                return _buildSpotifyEventCard(context, event, musicList, theme);
              },
            ),
          );
        }(),
      (AsyncError(), _) => _buildErrorState(context, 'イベントの読み込みに失敗しました'),
      _ => _buildLoadingState(),
    };
  }

  Widget _buildSpotifyEventCard(
    BuildContext context,
    Event event,
    List<Music> musicList,
    ThemeData theme,
  ) {
    String? thumbnailUrl;
    if (event.setlist.isNotEmpty) {
      final firstMusicId = event.setlist.first.musicId.value;
      try {
        final music = musicList.firstWhere((m) => m.id.value == firstMusicId);
        thumbnailUrl = music.thumbnailUrl;
      } on Exception {
        // Music not found, use placeholder
      }
    }

    return Container(
      width: 160,
      margin: const EdgeInsets.only(right: AppSpacing.medium),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => SetlistDetailRoute(eventId: event.id.value).go(context),
          borderRadius: BorderRadius.circular(8),
          child: Container(
            padding: const EdgeInsets.all(AppSpacing.medium),
            decoration: BoxDecoration(
              color: theme.colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Thumbnail with rounded corners
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: theme.colorScheme.surfaceContainer,
                    ),
                    child: SizedBox(
                      width: double.infinity,
                      height: 128,
                      child: thumbnailUrl != null
                          ? CachedNetworkImage(
                              imageUrl: thumbnailUrl,
                              fit: BoxFit.cover,
                              errorWidget: (context, url, error) =>
                                  _buildSpotifyPlaceholder(theme),
                            )
                          : _buildSpotifyPlaceholder(theme),
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.medium),
                
                // Event title
                Text(
                  event.title,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                
                const SizedBox(height: AppSpacing.small),
                
                // Event info
                Text(
                  '${event.setlist.length}曲 • ${event.date.year}年',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSpotifyPlaceholder(ThemeData theme) {
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            theme.colorScheme.primary.withValues(alpha: 0.3),
            theme.colorScheme.secondary.withValues(alpha: 0.3),
          ],
        ),
      ),
      child: Icon(
        Icons.music_note,
        size: 40,
        color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
      ),
    );
  }

  Widget _buildPopularSongsGrid(
    BuildContext context,
    AsyncValue<List<Music>> musicRepositoryAsync,
    ThemeData theme,
  ) {
    return switch (musicRepositoryAsync) {
      AsyncData(value: final musicList) => () {
          final popularSongs = musicList.take(6).toList();

          return GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: AppSpacing.medium,
              mainAxisSpacing: AppSpacing.medium,
              childAspectRatio: 0.85,
            ),
            itemCount: popularSongs.length,
            itemBuilder: (context, index) {
              return _buildSpotifyMusicCard(
                context,
                popularSongs[index],
                theme,
              );
            },
          );
        }(),
      AsyncError() => _buildErrorState(context, '楽曲の読み込みに失敗しました'),
      _ => _buildLoadingState(),
    };
  }

  Widget _buildSpotifyMusicCard(
    BuildContext context,
    Music music,
    ThemeData theme,
  ) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => MusicDetailRoute(musicId: music.id.value).go(context),
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.all(AppSpacing.medium),
          decoration: BoxDecoration(
            color: theme.colorScheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Album art with rounded corners
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: theme.colorScheme.surfaceContainer,
                    ),
                    child: SizedBox(
                      width: double.infinity,
                      child: CachedNetworkImage(
                        imageUrl: music.thumbnailUrl,
                        fit: BoxFit.cover,
                        errorWidget: (context, url, error) => DecoratedBox(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                theme.colorScheme.primary
                                    .withValues(alpha: 0.3),
                                theme.colorScheme.secondary
                                    .withValues(alpha: 0.3),
                              ],
                            ),
                          ),
                          child: Icon(
                            Icons.music_note,
                            size: 32,
                            color: theme.colorScheme.onSurface
                                .withValues(alpha: 0.5),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              
              const SizedBox(height: AppSpacing.medium),
              
              // Song title
              Text(
                music.title,
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              
              const SizedBox(height: AppSpacing.small),
              
              // YouTube indicator
              if (music.youtubeId != null)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.small,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.play_circle_outline,
                        size: 12,
                        color: theme.colorScheme.primary,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'YouTube',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.primary,
                          fontWeight: FontWeight.w500,
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildErrorState(BuildContext context, String message) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.extraLarge),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.error_outline,
              size: 64,
              color: Theme.of(context).colorScheme.error,
            ),
            const SizedBox(height: AppSpacing.medium),
            Text(
              message,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Theme.of(context).colorScheme.error,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoadingState() {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(AppSpacing.extraLarge),
        child: CircularProgressIndicator(),
      ),
    );
  }
}
