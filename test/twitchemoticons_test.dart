import 'package:twitchemoticons/twitchemoticons.dart';
import 'package:test/test.dart';

void main() {
  group('Test GLOBAL Emotes: ', () {
    var fetcher = EmoteFetcher.createEmptyFetcherAsObject();

    setUp(() async {
      fetcher = await EmoteFetcher.getPreloadedFetcherAsSingleton();
    });

    test(
        'Global Twitch Emotes fetched sucessfully, "TwitchUnity" emote is there',
        () {
      final emote =
          fetcher.fetchedEmotesMappedByWord['TwitchUnity'] ?? EmptyEmote();
      expect(emote.word() == 'TwitchUnity', isTrue);
    });

    test('Amount of Global Twitch Emotes fetched is the expected', () {
      final emotes = fetcher.fetchedEmotesMappedByWord.entries.where((e) =>
          e.value.type() == EmoteType.TWITCH && e.value.channel() == 'global');
      expect(emotes.length > 10, isTrue);
    });

    test('BTTV Global Emotes fetched sucessfully, "FeelsBadMan" emote is there',
        () {
      final emote =
          fetcher.fetchedEmotesMappedByWord['FeelsBadMan'] ?? EmptyEmote();
      expect(emote.word() == 'FeelsBadMan', isTrue);
    });

    test('Amount of BTTV Global Twitch Emotes fetched is the expected', () {
      final emotes = fetcher.fetchedEmotesMappedByWord.entries.where((e) =>
          e.value.type() == EmoteType.BTTV && e.value.channel() == 'global');
      expect(emotes.length > 10, isTrue);
    });

    test('FFZ Global Emotes fetched sucessfully, "LilZ" emote is there', () {
      final emote = fetcher.fetchedEmotesMappedByWord['LilZ'] ?? EmptyEmote();
      expect(emote.word() == 'LilZ', isTrue);
    });

    test('Amount of FFZ Global Twitch Emotes fetched is the expected', () {
      final emotes = fetcher.fetchedEmotesMappedByWord.entries.where((e) =>
          e.value.type() == EmoteType.FFZ && e.value.channel() == 'global');
      expect(emotes.length > 10, isTrue);
    });
  });

  group('Test FFZ: ', () {
    var fetcher = EmoteFetcher.createEmptyFetcherAsObject();
    final _channelToDoTest = 'xqcow';

    setUp(() async {
      fetcher = await EmoteFetcher.getPreloadedFetcherAsSingleton();
      await fetcher.fetchFfzEmotesFromChannel(_channelToDoTest);
    });

    test('FFZ Emotes fetched form channel "$_channelToDoTest" without problems',
        () {
      expect(fetcher.fetchedEmotesMappedByWord.isEmpty, isFalse);
    });

    test(
        'Amount of FFZ emotes fetched form channel "$_channelToDoTest" is the expected',
        () {
      final emotes = fetcher.fetchedEmotesMappedByWord.entries
          .where((e) => e.value.type() == EmoteType.FFZ);
      expect(emotes.length > 10, isTrue);
    });

    test('FFZ "Pog" emote from channel "$_channelToDoTest" is there', () {
      final emote = fetcher.fetchedEmotesMappedByWord['Pog'] ?? EmptyEmote();
      expect(emote.word() == 'Pog', isTrue);
    });
  });

  group('Test BTTV: ', () {
    var fetcher = EmoteFetcher.createEmptyFetcherAsObject();
    final _channelToDoTest = 'xqcow';

    setUp(() async {
      fetcher = await EmoteFetcher.getPreloadedFetcherAsSingleton();
      await fetcher.fetchBttvEmotesFromChannel(_channelToDoTest);
    });

    test(
        'BTTV Emotes fetched form channel "$_channelToDoTest" without problems',
        () {
      expect(fetcher.fetchedEmotesMappedByWord.isEmpty, isFalse);
    });

    test(
        'Amount of BTTV emotes fetched form channel "$_channelToDoTest" is the expected',
        () {
      final emotes = fetcher.fetchedEmotesMappedByWord.entries
          .where((e) => e.value.type() == EmoteType.BTTV);
      expect(emotes.length > 10, isTrue);
    });

    test('BTTV "POGGERS" emote from channel "$_channelToDoTest" is there', () {
      final emote =
          fetcher.fetchedEmotesMappedByWord['POGGERS'] ?? EmptyEmote();
      expect(emote.word() == 'POGGERS', isTrue);
    });
  });
}
