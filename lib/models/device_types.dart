class DeviceType {
  final String deviceName;
  final String deviceDescription;
  final String deviceImage1;
  final String deviceImage2;
  final String deviceImage3;
  final List<String> deviceImages;

  DeviceType({
    this.deviceName,
    this.deviceDescription,
    this.deviceImage1,
    this.deviceImage2,
    this.deviceImage3,
    this.deviceImages,
  });
}

final allDevices = [
  DeviceType(
    deviceName: 'Infinia Device Type 1',
    deviceDescription:
        'Infinia Device Type 1 Description sentences.Please read this manual carefully and follow all safety rules and operating instructions before using the device.',
    deviceImage1:
        'https://assets.wsimgs.com/wsimgs/ab/images/dp/wcm/202012/0988/img26c.jpg',
    deviceImage2:
        'https://smartgardenguide.com/wp-content/uploads/2019/09/click-and-grow-smart-garden-9-photo-3-1024x680.jpeg',
    deviceImage3:
        'https://athomeinthefuture.com/wp-content/uploads/2016/08/clickandgrow-720x447@2x.jpg',
    deviceImages: [
      'https://assets.wsimgs.com/wsimgs/ab/images/dp/wcm/202012/0988/img26c.jpg',
      'https://smartgardenguide.com/wp-content/uploads/2019/09/click-and-grow-smart-garden-9-photo-3-1024x680.jpeg',
      'https://athomeinthefuture.com/wp-content/uploads/2016/08/clickandgrow-720x447@2x.jpg',
    ],
  )
];
