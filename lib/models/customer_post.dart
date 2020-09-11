class CustomerPostModel {
  final String customerName;
  final String customerProfileImageUrl;
  final String postDescription;
  final String postDate;
  final String postImageUrl;

  CustomerPostModel(
      {this.customerName,
      this.customerProfileImageUrl,
      this.postDescription,
      this.postDate,
      this.postImageUrl});

  final allCustomerPosts = [
    CustomerPostModel(
        customerName: "Eren",
        customerProfileImageUrl: "https://wallpapercave.com/wp/AYWg3iu.jpg",
        postDescription: "Eren insta post",
        postDate: "06-09-2020 04:26 PM",
        postImageUrl: ""),
    CustomerPostModel(
        customerName: "Sedef",
        customerProfileImageUrl: "https://wallpapercave.com/wp/AYWg3iu.jpg",
        postDescription:
            "Sedef'ın cihaz yorumu , daha detaylı yorum , uzun yorum",
        postDate: "07-09-2020 04:26 PM",
        postImageUrl: ""),
    CustomerPostModel(
        customerName: "Babacan",
        customerProfileImageUrl: "https://wallpapercave.com/wp/AYWg3iu.jpg",
        postDescription:
            "Babacan'ın cihaz yorumu , daha detaylı yorum , uzun yorum",
        postDate: "08-09-2020 04:26 PM",
        postImageUrl: ""),
    CustomerPostModel(
        customerName: "Hilmi",
        customerProfileImageUrl: "https://wallpapercave.com/wp/AYWg3iu.jpg",
        postDescription:
            "Hilmi'ın cihaz yorumu , daha detaylı yorum , uzun yorum",
        postDate: "09-09-2020 04:26 PM",
        postImageUrl: ""),
    CustomerPostModel(
        customerName: "Kardelen",
        customerProfileImageUrl: "https://wallpapercave.com/wp/AYWg3iu.jpg",
        postDescription:
            "Kardelen'ın cihaz yorumu , daha detaylı yorum , uzun yorum",
        postDate: "10-09-2020 04:26 PM",
        postImageUrl: ""),
    CustomerPostModel(
        customerName: "Osman",
        customerProfileImageUrl: "https://wallpapercave.com/wp/AYWg3iu.jpg",
        postDescription:
            "Osman'ın cihaz yorumu , daha detaylı yorum , uzun yorum",
        postDate: "11-09-2020 04:26 PM",
        postImageUrl: ""),
  ];
}
