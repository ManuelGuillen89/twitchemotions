import 'dart:convert';
import 'package:http/http.dart' as http;
import 'resources_uris.dart';
import 'emote_types.dart';

class EmoteFetcher {
  final Map<String, Emote> fetchedEmotesMappedByWord = {};

  EmoteFetcher._();
  static EmoteFetcher createEmptyFetcherAsObject() => EmoteFetcher._();

  static EmoteFetcher _emoteFetcherSingleton = EmoteFetcher._();

  static Future<EmoteFetcher> getPreloadedFetcherAsSingleton() async {
    if (_emoteFetcherSingleton.fetchedEmotesMappedByWord.isNotEmpty) {
      return _emoteFetcherSingleton;
    }
    final fetcher = EmoteFetcher._();
    print('Fetching emotes from BTTV, FFZ and TwitchEmotes APIs...');
    await fetcher.fetchTwitchEmotesFromChannel('global', 0);
    await fetcher.fetchBttvEmotesFromChannel('global');
    await fetcher.fetchFfzEmotesFromChannel('global');
    _emoteFetcherSingleton = fetcher;
    return _emoteFetcherSingleton;
  }

  Future<void> fetchAllEmoteTypesFromChannel(
      String channelName, int idChannel) async {
    await fetchTwitchEmotesFromChannel(channelName, idChannel);
    await fetchBttvEmotesFromChannel(channelName);
    await fetchFfzEmotesFromChannel(channelName);
  }

  Future<void> fetch3rdPartyEmotesFromChannel(String channelName) async {
    await fetchBttvEmotesFromChannel(channelName);
    await fetchFfzEmotesFromChannel(channelName);
  }

  Future<void> fetchTwitchEmotesFromChannel(
      String channelName, int channelId) async {
    final response = channelName == 'global'
        ? await http.get(TwitchURIs.globalEmotes)
        : await http.get(TwitchURIs.emotesFromChannel(channelId));
    if (response.statusCode != 200) {
      print(
          'TwitchEmotes API response error. Status code: ${response.statusCode}');
      print('Twitch emotes form channel #$channelName has not fetched');
      return;
    }
    final emoteFromResponse = _decodeTwitchEmotesFromResponse(response.body);
    final List<Emote> parsedEmotes = emoteFromResponse
        .map((e) => TwitchEmote(e['code'], channelName, e['id'].toString()))
        .toList();
    // ignore: omit_local_variable_types
    final Map<String, Emote> emotesMapedByWord = {
      for (var e in parsedEmotes) e.word(): e
    };
    print(
        '${emotesMapedByWord.length} Twitch emotes fetched from channel #$channelName');
    fetchedEmotesMappedByWord.addAll(emotesMapedByWord);
  }

  Future<void> fetchBttvEmotesFromChannel(String channelName) async {
    final response = channelName == 'global'
        ? await http.get(BttvURIs.globalEmotes)
        : await http.get(BttvURIs.emotesFromChannel(channelName));
    if (response.statusCode != 200) {
      print('BTTV response error. Status code: ${response.statusCode}');
      print('BTTV emotes form channel #$channelName has not fetched');
      return;
    }
    final emoteFromResponse = _decodeBTTVemotesFromResponse(response.body);
    final List<Emote> parsedEmotes = emoteFromResponse
        .map((e) => BTTVEmote(e['code'], channelName, e['id']))
        .toList();
    // ignore: omit_local_variable_types
    final Map<String, Emote> emotesMapedByWord = {
      for (var e in parsedEmotes) e.word(): e
    };
    print(
        '${emotesMapedByWord.length} BTTV emotes fetched from channel #$channelName');
    fetchedEmotesMappedByWord.addAll(emotesMapedByWord);
  }

  Future<void> fetchFfzEmotesFromChannel(String channelName) async {
    final response = channelName == 'global'
        ? await http.get(FfzURIs.globalEmotes)
        : await http.get(FfzURIs.emotesFromChannel(channelName));
    if (response.statusCode != 200) {
      print('FFZ response error. Status code: ${response.statusCode}');
      print('FFZ emotes form channel #$channelName has not fetched');
      return;
    }
    final emoteFromResponse = _decodeFFZemotesFromResponse(response.body);
    final List<Emote> parsedEmotes = emoteFromResponse
        .map((e) => FFZEmote(e['name'], channelName, e['id'].toString()))
        .toList();
    // ignore: omit_local_variable_types
    final Map<String, Emote> emotesMapedByWord = {
      for (var e in parsedEmotes) e.word(): e
    };
    print(
        '${emotesMapedByWord.length} FFZ emotes fetched from channel #$channelName');
    fetchedEmotesMappedByWord.addAll(emotesMapedByWord);
  }

  List<dynamic> _decodeTwitchEmotesFromResponse(String responseBody) {
    final decodedResponse = jsonDecode(responseBody) ?? {};
    final emotes = decodedResponse['emotes'] ?? [];
    return emotes;
  }

  List<dynamic> _decodeBTTVemotesFromResponse(String responseBody) {
    final decodedResponse = jsonDecode(responseBody) ?? {};
    final emotes = decodedResponse['emotes'] ?? [];
    return emotes;
  }

  List<dynamic> _decodeFFZemotesFromResponse(String responseBody) {
    final decodedResponse = jsonDecode(responseBody) ?? {};
    final emoteSets = decodedResponse['sets'] ?? {};
    final emoteEntries = emoteSets.entries;
    final List<dynamic> unparsedEmotes =
        emoteEntries.fold([], (accEmotes, thisSet) {
      var acc = accEmotes as List<dynamic>;
      var thisEmoteList = thisSet.value['emoticons'] ?? [];
      return acc + thisEmoteList;
    });
    return unparsedEmotes;
  }
}
