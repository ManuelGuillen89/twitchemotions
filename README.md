A library writed in Dart to fetch emotes form FFZ, BTTV and Twitch.

🚨 PLEASE DON'T USE FOR SERIOUS PROJECTS YET 🚨

## Usage

A simple usage example:

```dart
import 'package:twitchemoticons/twitchemoticons.dart';

main() async {
  final fetcher = await EmoteFetcher.getPreloadedFetcherAsSingleton();
  await fetcher.fetch3rdPartyEmotesFromChannel('summit1g');
  final emote = fetcher.fetchedEmotesMappedByWord['Pog'] ?? EmptyEmote();
  emote.word() != '' ? print(emote.link()) : () {};
}
```

