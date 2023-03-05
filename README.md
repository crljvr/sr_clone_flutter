![alt text](https://github.com/crljvr/sr_clone_flutter/blob/main/assets/images/banner.png?raw=true)

# sr_clone_flutter

A clone of SR Play using Flutter

[![melos](https://img.shields.io/badge/maintained%20with-melos-f700ff.svg?style=flat-square)](https://github.com/invertase/melos) [![style: very good analysis](https://img.shields.io/badge/style-very_good_analysis-B22C89.svg)](https://pub.dev/packages/very_good_analysis)
___


## Project background

The purpose of this project is to showcase a way of creating a larger scale Flutter app using a **monorepo** structure and following the **Clean Architecture** principle.

It is an attempt to recreate the design and user experience of SR Play, a radio app from Swedish Public Radio, Sveriges Radio. The app makes use of Sveriges Radio’s open API to get content about shows, episodes and channels.

This app has no intentions of being published. It only serves as an example of how to structure a Flutter app.

### Todos

* Style the bottom navigation bar and set correct routes
* Refactor `MediaPlayer` and `NetworkManager` to be proper modules to make use of [melos](https://github.com/invertase/melos)
* Details page for featured episode
* Create a `UI Components` module and add [Widgetbook](https://github.com/widgetbook/widgetbook) 
* Write tests for modules and domain layer.
* More error handling

___

### Progress as of 2-3-2023

* Fetches and displays channels
* Plays/pauses a channel live audio
* Fetches and displays featured episode

| SR Play       | Flutter clone |
| ------------- | ------------- |
| ![alt text](https://github.com/crljvr/sr_clone_flutter/blob/main/assets/gifs/sr_play.gif?raw=true)      | ![alt text](https://github.com/crljvr/sr_clone_flutter/blob/main/assets/gifs/clone.gif?raw=true) |
