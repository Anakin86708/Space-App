import 'package:flutter/material.dart';

abstract class InterfacePage extends Widget {
  Icon get pageIcon;
  String get pageName;

  @override
  Element createElement();
}
