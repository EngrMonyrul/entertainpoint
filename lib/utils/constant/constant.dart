import 'package:entertainpoint/modules/downloadScreen/download_screen_view.dart';
import 'package:entertainpoint/modules/homeScreen/home_screen_view.dart';
import 'package:entertainpoint/modules/movieScreen/movie_screen_view.dart';
import 'package:entertainpoint/modules/tvshowScreen/tvshow_screen_view.dart';
import 'package:flutter/material.dart';

const animated_image_1 = 'assets/images/animation_lmztvbfw.json';
const animated_image_2 = 'assets/images/animation_lmztxzgd.json';
const animated_image_3 = 'assets/images/animation_lmztyff1.json';
const update_animation = 'assets/images/update_animation.json';
const downloadAnimation = 'assets/icons/download.json';
const facebookImage = 'assets/icons/facebook (1).png';
const instaImage = 'assets/icons/instagram.png';
const tiktokImage = 'assets/icons/tik-tok.png';
const youtubeImage = 'assets/icons/youtube.png';
const gmailImage = 'assets/icons/gmail.png';
const shareImage = 'assets/icons/share.png';

const navbarButtonColors = [Colors.purple, Colors.pink, Colors.blue, Colors.amber];
const List<Map<String, dynamic>> shortsList = [
  {'name': 'Facebook Reels', 'image': facebookImage, 'link': 'https://www.facebook.com/reel/'},
  {'name': 'Instagram Reels', 'image': instaImage, 'link': 'https://www.instagram.com/reels/'},
  {'name': 'TikTok Videos', 'image': tiktokImage, 'link': 'https://www.tiktok.com/en/'},
  {'name': 'YouTube Shorts', 'image': youtubeImage, 'link': 'https://www.youtube.com/shorts/'}
];

Map<String, dynamic> appUpdate = {};
List<Map<String, dynamic>> ytVideos = [];
List<Map<String, dynamic>> hindiMovies = [];
List<Map<String, dynamic>> englishMovies = [];
List<Map<String, dynamic>> otherMovies = [];
List<Map<String, dynamic>> allMovieList = [];
List<Map<String, dynamic>> circleFtpVdo = [];
List<Map<String, dynamic>> ftpVideo = [];
List<Map<String, dynamic>> tvShows = [];
List<Map<String, dynamic>> allItems = [];

List<Widget> allPages = [
  const HomeScreenView(),
  const MovieScreenPageView(),
  const TvShowsScreenView(),
  const DownloadScreenView()
];

String streamUrl = '';
List<String> streamVdo = [];
