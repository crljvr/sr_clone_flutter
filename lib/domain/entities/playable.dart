abstract class Playable {
  String get audioUrl;
}

class OnAirPlayable implements Playable {
  const OnAirPlayable(this.audioUrl);

  @override
  final String audioUrl;
}
