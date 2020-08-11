import 'package:meta/meta.dart';
import 'package:story/models/user_model.dart';

enum MediaType {
  image,
  video,
}

class Story {
  final String url;
  final MediaType media;
  final Duration duration;
  final User user;
  final String descriptionNumber1;
  final String descriptionNumber2;
  final String descriptionNumber3;

  const Story({
    @required this.url,
    @required this.media,
    @required this.duration,
    @required this.user,
    @required this.descriptionNumber1,
    @required this.descriptionNumber2,
    @required this.descriptionNumber3,
  });
}
