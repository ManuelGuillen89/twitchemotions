import 'package:twitchemoticons/twitchemoticons.dart';

Future<void> main() async {
  final fetcher = await EmoteFetcher.getPreloadedFetcherAsSingleton();
  await fetcher.fetch3rdPartyEmotesFromChannel('summit1g');
  if (fetcher.fetchedEmotesMappedByWord.containsKey('Pog')) {
    print(fetcher.fetchedEmotesMappedByWord['Pog']);
  }
}
