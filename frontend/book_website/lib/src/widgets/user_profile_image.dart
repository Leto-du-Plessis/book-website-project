import 'dart:typed_data';

import 'package:flutter/material.dart';

class UserProfileImage extends StatelessWidget {

  final Uint8List? profileImageBytes;
  final double size; 

  const UserProfileImage({super.key, this.profileImageBytes, this.size = 64});

  @override
  Widget build(BuildContext context) {
    return ClipOval(  
      child:SizedBox(  
        width: size,
        height: size,
        child: profileImageBytes != null  
          ? Image.memory(profileImageBytes!, fit: BoxFit.cover)
          : Icon(Icons.account_circle, size: size - 12)
      )
    );
  }

}