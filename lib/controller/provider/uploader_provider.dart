

import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import '../../model/models.dart';


class UploaderProvider with ChangeNotifier{
  Map<String,UploadTask> mapUploadTask={};
  Map<String,bool> checkClickDownload={};
  Map<String,bool> checkCompleteDownload={};


}