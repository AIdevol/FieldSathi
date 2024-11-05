import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class ImagePickerHelper {
  static Future<void> checkAndRequestPermission(Permission permission) async {
    final status = await permission.status;
    if (status.isDenied) {
      await permission.request();
    }
  }

  static Future<File?> pickImageFromSource(ImageSource source, BuildContext context) async {
    try {
      // Request relevant permissions first
      if (source == ImageSource.camera) {
        await checkAndRequestPermission(Permission.camera);
      } else {
        if (Platform.isAndroid) {
          if (await _isAndroid13OrAbove()) {
            await checkAndRequestPermission(Permission.photos);
            await checkAndRequestPermission(Permission.videos);
          } else {
            await checkAndRequestPermission(Permission.storage);
          }
        } else {
          await checkAndRequestPermission(Permission.photos);
        }
      }

      // Check if permissions are granted
      bool hasPermission = false;
      if (source == ImageSource.camera) {
        hasPermission = await Permission.camera.isGranted;
      } else {
        if (Platform.isAndroid) {
          if (await _isAndroid13OrAbove()) {
            hasPermission = await Permission.photos.isGranted;
          } else {
            hasPermission = await Permission.storage.isGranted;
          }
        } else {
          hasPermission = await Permission.photos.isGranted;
        }
      }

      if (!hasPermission) {
        _showPermissionDeniedDialog(context);
        return null;
      }

      final picker = ImagePicker();
      final XFile? pickedFile = await picker.pickImage(
        source: source,
        imageQuality: 80,
        maxWidth: 1200,
        maxHeight: 1200,
      );

      if (pickedFile != null) {
        return File(pickedFile.path);
      }
    } catch (e) {
      debugPrint('Error picking image: $e');
      _showErrorDialog(context, e.toString());
    }
    return null;
  }

  static Future<bool> _isAndroid13OrAbove() async {
    if (Platform.isAndroid) {
      final androidInfo = await DeviceInfoPlugin().androidInfo;
      return androidInfo.version.sdkInt >= 33;
    }
    return false;
  }

  static void _showPermissionDeniedDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Permission Required'),
          content: Text('This feature requires permission to access your photos/camera. Would you like to enable it in settings?'),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: Text('Settings'),
              onPressed: () {
                Navigator.of(context).pop();
                openAppSettings();
              },
            ),
          ],
        );
      },
    );
  }

  static void _showErrorDialog(BuildContext context, String error) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text('Failed to pick image: $error'),
          actions: [
            TextButton(
              child: Text('OK'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      },
    );
  }
}