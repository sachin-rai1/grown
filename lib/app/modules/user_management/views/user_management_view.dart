import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/user_management_controller.dart';

class UserManagementView extends GetView<UserManagementController> {
  const UserManagementView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Management'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'UserManagement Coming Soon',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
