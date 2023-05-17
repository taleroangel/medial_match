// ignore_for_file: prefer-match-file-name

import 'package:medial_match/models/news.dart';
import 'package:medial_match/models/service.dart';

abstract interface class IDatabaseService {
  Set<Service> get services;
  Set<News> get news;
}
