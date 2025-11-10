import 'package:flutter/material.dart';
import 'package:green_sense/constants/app_colors.dart';
import 'package:green_sense/services/share_service.dart';

class ShareButton extends StatelessWidget {
  final String title;
  final String url;
  final SharePlatform? specificPlatform;

  const ShareButton({
    Key? key,
    required this.title,
    required this.url,
    this.specificPlatform,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (specificPlatform != null) {
      return IconButton(
        icon: Icon(_getPlatformIcon(specificPlatform!)),
        color: _getPlatformColor(specificPlatform!),
        tooltip: 'Share on ${_getPlatformName(specificPlatform!)}',
        onPressed: () {
          ShareService.share(title, url, specificPlatform!);
        },
      );
    }

    return PopupMenuButton<SharePlatform>(
      icon: const Icon(
        Icons.share,
        color: AppColors.primaryColor,
      ),
      tooltip: 'Share',
      onSelected: (platform) {
        ShareService.share(title, url, platform);
      },
      itemBuilder: (context) => [
        PopupMenuItem(
          value: SharePlatform.twitter,
          child: Row(
            children: [
              Icon(
                _getPlatformIcon(SharePlatform.twitter),
                color: _getPlatformColor(SharePlatform.twitter),
              ),
              const SizedBox(width: 12),
              const Text('Twitter'),
            ],
          ),
        ),
        PopupMenuItem(
          value: SharePlatform.facebook,
          child: Row(
            children: [
              Icon(
                _getPlatformIcon(SharePlatform.facebook),
                color: _getPlatformColor(SharePlatform.facebook),
              ),
              const SizedBox(width: 12),
              const Text('Facebook'),
            ],
          ),
        ),
        PopupMenuItem(
          value: SharePlatform.linkedin,
          child: Row(
            children: [
              Icon(
                _getPlatformIcon(SharePlatform.linkedin),
                color: _getPlatformColor(SharePlatform.linkedin),
              ),
              const SizedBox(width: 12),
              const Text('LinkedIn'),
            ],
          ),
        ),
        PopupMenuItem(
          value: SharePlatform.whatsapp,
          child: Row(
            children: [
              Icon(
                _getPlatformIcon(SharePlatform.whatsapp),
                color: _getPlatformColor(SharePlatform.whatsapp),
              ),
              const SizedBox(width: 12),
              const Text('WhatsApp'),
            ],
          ),
        ),
        PopupMenuItem(
          value: SharePlatform.email,
          child: Row(
            children: [
              Icon(
                _getPlatformIcon(SharePlatform.email),
                color: _getPlatformColor(SharePlatform.email),
              ),
              const SizedBox(width: 12),
              const Text('Email'),
            ],
          ),
        ),
      ],
    );
  }

  IconData _getPlatformIcon(SharePlatform platform) {
    switch (platform) {
      case SharePlatform.twitter:
        return Icons.near_me; // Using Flutter icon as substitute
      case SharePlatform.facebook:
        return Icons.facebook;
      case SharePlatform.linkedin:
        return Icons.business;
      case SharePlatform.whatsapp:
        return Icons.message;
      case SharePlatform.email:
        return Icons.email;
    }
  }

  Color _getPlatformColor(SharePlatform platform) {
    switch (platform) {
      case SharePlatform.twitter:
        return const Color(0xFF1DA1F2);
      case SharePlatform.facebook:
        return const Color(0xFF4267B2);
      case SharePlatform.linkedin:
        return const Color(0xFF0077B5);
      case SharePlatform.whatsapp:
        return const Color(0xFF25D366);
      case SharePlatform.email:
        return Colors.grey;
    }
  }

  String _getPlatformName(SharePlatform platform) {
    return platform.toString().split('.').last;
  }
}
