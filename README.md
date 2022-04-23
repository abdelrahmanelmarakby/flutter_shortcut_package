<!-- 
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages). 

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages). 
-->

# Ease

This packa is for anything that can be reusable in flutter like custom widgets 🟥, animations 🌟and more.

## Features

* 1-custom `text` widget to ease its usage
* 2- custom `text field` widget with cool validation
* 3-super cool animated `splash screen`
* 4- easy to use `geolocator` and `connectivity` service in one line
* 5- Super useful `extensions`.
* 6-dynamic theme with persistence that can be implemented in 1 min (coming soon)
* 7-the easiest localization implementation (coming soon)
* 8-credit card widget
* 9-Animated `ProductCard` widget
* 10- 2 awesome Animated `NavBars` widgets and easy to use
* many validators to use

## Getting started

go to your ```Android/app/build.gradle file and edit your compileSdkVersion to 31```

``` dart
android {
    compileSdkVersion 31
```

## Usage

### Widgets and how to use them

TextFormField with simple validation indicator

```dart
EaseTxtForm(
controller:myEditingController, 
)
```

Text with simplified usage

```dart
EaseTxt("Hello World",
color:Colors.blue
)
```

Glass Container

```dart
EaseGlassContainer(
child:Txt("Hello World",
color:Colors.blue
    )
)
```

Animated ProductCard

```dart
 EaseProductCard(
                                  image: NetworkImage(
                                      "https://cdn-icons.flaticon.com/png/512/2930/premium/2930679.png?token=exp=1638474347~hmac=f895ca5646f06b4e9703ebd80aa8fa9a"),
                                  title: "GOOD PACKAGE",
                                  primarytActionLabel: "PRIMARY ACTION",
                                  price:"300 EGP",
                                  rate: 3,
                                ),
```

Awesome TabBar and Easy to use

```dart
EaseTabBar(
    iconButtons=[]
    child:Column(
        
    )
)
```

SplashScreen With animation

```dart
EaseSplashScreen(
    homePage:HomeScreen(),
    logo:Image.asset("assets/logo");
    slogan:"PR are welcome"
)
```

### Services and how to use them

in each service, you will find what to import and how to use

eg:
Location Service will tell you to use Getx and geolocator package.
and use it like that

```dart
Position location= await EaseLocatorService.determinePosition();
```

easy isn't it ??

## Additional information

if you have any idea that you think will be a good addittion contribure or add an issue to the github repo feel stuck on something ? join our telegram group

## <https://t.me/joinchat/p9O1YRT_NlQwZDZk>

### I will do my best to add it super fast,Please Star and support this repo
