class TwitchURIs {
  static Uri emotesFromChannel(int id) =>
      Uri.https('api.twitchemotes.com', '/api/v4/channels/${id.toString()}');
  static Uri globalEmotes =
      Uri.https('api.twitchemotes.com', '/api/v4/channels/0');
  static String cnd(String id) =>
      'https://static-cdn.jtvnw.net/emoticons/v1/$id/1.0';
}

class BttvURIs {
  static Uri emotesFromChannel(String name) =>
      Uri.https('api.betterttv.net', '/2/channels/$name');
  static Uri globalEmotes = Uri.https('api.betterttv.net', '/2/emotes');
  static String cnd(String id) => 'https://cdn.betterttv.net/emote/$id/1x';
}

class FfzURIs {
  static Uri emotesFromChannel(String name) =>
      Uri.https('api.frankerfacez.com', '/v1/room/$name');
  static Uri globalEmotes = Uri.https('api.frankerfacez.com', '/v1/set/global');
  static String cnd(String id) => 'https://cdn.frankerfacez.com/emote/$id/1';
}
