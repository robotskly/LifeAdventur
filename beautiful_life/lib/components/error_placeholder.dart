import 'package:flutter/material.dart';
import 'package:beautiful_life/app_theme.dart';

enum ErrorType { network, noData }

class ErrorPlaceholder extends StatelessWidget {
  final ErrorType type;
  final VoidCallback? onRetry;

  const ErrorPlaceholder({
    Key? key,
    required this.type,
    this.onRetry,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildIllustration(),
          const SizedBox(height: 24),
          _buildTitle(context),
          const SizedBox(height: 12),
          _buildDescription(context),
          if (type == ErrorType.network) _buildRetryButton(context),
        ],
      ),
    );
  }

  Widget _buildIllustration() {
    final assetPath = type == ErrorType.network
        ? 'assets/errors/network_error.svg'
        : 'assets/lifeicons/icon_suijiyige.svg';
    return SizedBox(
      width: 200,
      height: 200,
      child: Image.asset(assetPath),
    );
  }

  Widget _buildTitle(BuildContext context) {
    final text = type == ErrorType.network
        ? '网络连接异常'
        : '暂无相关内容';
    return Text(
      text,
      style: AppTheme.title,
      textAlign: TextAlign.center,
    );
  }

  Widget _buildDescription(BuildContext context) {
    final text = type == ErrorType.network
        ? '请检查网络连接后重试'
        : '尝试换个筛选条件看看吧';
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Text(
        text,
        style: AppTheme.body2,
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildRetryButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 24),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Color.fromRGBO(255, 185, 0, 1),
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
        ),
        onPressed: onRetry,
        child: const Text(
          '重新加载',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}