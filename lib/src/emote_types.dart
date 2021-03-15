import 'resources_uris.dart';

enum EmoteType { TWITCH, BTTV, FFZ, UNKNOWED }

abstract class Emote {
  String word();
  String channel();
  String id();
  String link();
  EmoteType type();
}

class TwitchEmote extends Emote {
  final String _word;
  final String _channel;
  final String _idTwitch;
  final EmoteType _type = EmoteType.TWITCH;
  TwitchEmote(this._word, this._channel, this._idTwitch);
  @override
  String channel() => _channel;
  @override
  String id() => _idTwitch;
  @override
  String link() => TwitchURIs.cnd(_idTwitch);
  @override
  EmoteType type() => _type;
  @override
  String word() => _word;
}

class BTTVEmote extends Emote {
  final String _word;
  final String _channel;
  final String _idBTTV;
  final EmoteType _type = EmoteType.BTTV;
  BTTVEmote(this._word, this._channel, this._idBTTV);
  @override
  String channel() => _channel;
  @override
  String id() => _idBTTV;
  @override
  String link() => BttvURIs.cnd(_idBTTV);
  @override
  EmoteType type() => _type;
  @override
  String word() => _word;
}

class FFZEmote extends Emote {
  final String _word;
  final String _channel;
  final String _idFFZ;
  final EmoteType _type = EmoteType.FFZ;
  FFZEmote(this._word, this._channel, this._idFFZ);
  @override
  String channel() => _channel;
  @override
  String id() => _idFFZ;
  @override
  String link() => FfzURIs.cnd(_idFFZ);
  @override
  EmoteType type() => _type;
  @override
  String word() => _word;
}

class UnkowedChannelTwitchEmote extends Emote {
  final String _word;
  final String _channel = '';
  final String _idTwitch;
  final EmoteType _type = EmoteType.TWITCH;
  UnkowedChannelTwitchEmote(this._word, this._idTwitch);
  @override
  String channel() => _channel;
  @override
  String id() => _idTwitch;
  @override
  String link() => TwitchURIs.cnd(_idTwitch);
  @override
  EmoteType type() => _type;
  @override
  String word() => _word;
}

class EmptyEmote extends Emote {
  EmptyEmote();
  @override
  String channel() => '';
  @override
  String id() => '';
  @override
  String link() => TwitchURIs.cnd('');
  @override
  EmoteType type() => EmoteType.UNKNOWED;
  @override
  String word() => '';
}
