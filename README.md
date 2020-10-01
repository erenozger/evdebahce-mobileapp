# EvdeBahce

● During the Infinia Mühendislik internship program, all trainees are included in a new project and it is expected to start the project from scratch and finally produce a prototype.During this period, we started a project called "EvdeBahce". Short description of this project is Automatic plant growing system that is easy to use at home, does not require maintenance, can meet some of the grocery needs of the household, stylishly designed, to be used as furniture.

●	My part in the project is to develop a mobile application for this product. While these developments were taking place, it was an important point to create the entire scheme and to understand and apply the working logic of the system.

## Flutter
● Flutter is a cross-platform UI toolkit that is designed to allow code reuse across operating systems such as iOS and Android, while also allowing applications to interface directly with underlying platform services.For the above-mentioned reasons and because flutter is already used in the company, we developed the mobile application with flutter.
## Dart
● Dart is a client-optimized programming language for apps on multiple platforms. It is developed by Google and is used to build mobile, desktop, server, and web applications. Dart is an object-oriented, class-based, garbage-collected language with C-style syntax. Dart can compile to either native code or JavaScript.

![Image of Dart](https://github.com/erenozger/evdebahce-mobileapp/blob/master/assets/project_images/1-dart.png)

![Image of Dart](https://github.com/erenozger/evdebahce-mobileapp/blob/master/assets/project_images/2-dart.png)


# Work Done
## User-Flow Diagram
![Image of User-flow Diagram](https://github.com/erenozger/evdebahce-mobileapp/blob/master/assets/project_images/user-flowdiagram.png)

### User Login-Register Page 
● User can register and log in from this page where we control the login. APIs are used for these operations and the SQLite database on the Django backend is used.
![Image of Dart](https://github.com/erenozger/evdebahce-mobileapp/blob/master/assets/project_images/3-loginregister.png)

### Dashboard Page
● After the user completes his / her login, the home page appears first. On this page, you can see how the device works, the plants that can be added on the device and their details.
![Image of Dart](https://github.com/erenozger/evdebahce-mobileapp/blob/master/assets/project_images/4-dashboard%20page.png)

### Add device, view and detail page
● The user can view all of their devices from the pages seen above. Then he can add a new device and enter the details of the device. On the detail page of the device, it can measure the current water level of the device. These water level measurement processes are provided from the Arduino card on the device, and the measurement is updated to the database by running the API over the internet network to which it is connected. Then the user can view the current water level from the mobile application.
![Image of Dart](https://github.com/erenozger/evdebahce-mobileapp/blob/master/assets/project_images/5-adddevice.png)

### Detail Plant Page
● After adding the plant to the system, the user can access all the necessary information on a single plant page and can observe the growing status of the plant.
![Image of Dart](https://github.com/erenozger/evdebahce-mobileapp/blob/master/assets/project_images/6-detail%20plant.png)

### Detailed user profile page 
● The user can access his profile with the page opened from the side. You can access some statistics from your profile and easily check the status from other pages in a short time. If he wants, the user can also change his password.
![Image of Dart](https://github.com/erenozger/evdebahce-mobileapp/blob/master/assets/project_images/7-detaileduserprofile.png)

### Notification and Frequently asked Questions Pages
● Notification page is one of the key points of the system. Because the application is entirely about informing the user, it can send instant notifications to the user about the system and its plants if deemed necessary. In addition, the frequently asked questions section helps the user to answer the questions that the user is curious about.
![Image of Dart](https://github.com/erenozger/evdebahce-mobileapp/blob/master/assets/project_images/8-notifications.png)


