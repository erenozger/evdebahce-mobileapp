import 'package:story/models/story_model.dart';
import 'package:story/models/user_model.dart';

final User user = User(
  name: 'Description',
  profileImageUrl: 'https://wallpapercave.com/wp/AYWg3iu.jpg',
);
final List<Story> stories = [
  Story(
    //url:       'https://images.wallpaperscraft.com/image/green_color_background_153276_1080x1920.jpg',
    //url:   'https://images-na.ssl-images-amazon.com/images/I/61H1fAKBrnL._AC_SY450_.jpg',
    url:
        'https://static.videezy.com/system/resources/previews/000/051/303/original/_DSC5486.mp4',
    media: MediaType.video,
    duration: const Duration(seconds: 0),
    user: user,
    descriptionNumber1: 'Description ',
    descriptionNumber2: 'Page 1 Number2',
    descriptionNumber3: 'Page 1 Description Number3',
  ),
  Story(
    url:
        'https://images.wallpaperscraft.com/image/green_color_background_153276_1080x1920.jpg',
    //url: 'https://media.giphy.com/media/4a1BW6oEvxPhK/source.gif',
    media: MediaType.image,
    user: User(
      name: 'John Doe',
      profileImageUrl: 'https://wallpapercave.com/wp/AYWg3iu.jpg',
    ),
    duration: const Duration(seconds: 7),
    descriptionNumber1: ' Description ',
    descriptionNumber2: 'Page 2 Number2',
    descriptionNumber3: 'Page 2 Description Number3',
  ),
  Story(
    url:
        'https://static.videezy.com/system/resources/previews/000/005/529/original/Reaviling_Sjusj%C3%B8en_Ski_Senter.mp4',
    media: MediaType.video,
    duration: const Duration(seconds: 0),
    user: user,
    descriptionNumber1: 'Description ',
    descriptionNumber2: 'Page 3 Number2',
    descriptionNumber3: 'Page 3 Description Number3',
  ),
  Story(
    url:
        'https://images.wallpaperscraft.com/image/green_color_background_153276_1080x1920.jpg',
    //url:    'https://images.unsplash.com/photo-1531694611353-d4758f86fa6d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=564&q=80',
    media: MediaType.image,
    duration: const Duration(seconds: 5),
    user: user,
    descriptionNumber1: 'Description',
    descriptionNumber2: 'Page 4 Number2',
    descriptionNumber3: 'Page 4 Description Number3',
  ),
  /*Story(
    url:
        'https://static.videezy.com/system/resources/previews/000/007/536/original/rockybeach.mp4',
    media: MediaType.video,
    duration: const Duration(seconds: 0),
    user: user,
  ),
  */
  Story(
    //url: 'https://media2.giphy.com/media/M8PxVICV5KlezP1pGE/giphy.gif',
    url:
        'https://images.wallpaperscraft.com/image/green_color_background_153276_1080x1920.jpg',
    media: MediaType.image,
    duration: const Duration(seconds: 8),
    user: user,
    descriptionNumber1: 'Description',
    descriptionNumber2: 'Page 5 Number2',
    descriptionNumber3: 'Page 5 Description Number3',
  ),
];
