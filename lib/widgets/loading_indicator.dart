import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../core/constraits/app_colors.dart';

class LoadingIndicator extends StatelessWidget {

  final double size;

  const LoadingIndicator({Key? key, this.size = 50.0}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SpinKitFadingCircle(
        color: AppColors.primary,
        size: size,
      )
    );
  }
}
