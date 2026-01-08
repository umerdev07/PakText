import 'package:flutter/material.dart';
import 'package:paktext/core/constraits/app_colors.dart';
import 'package:provider/provider.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/text_card.dart';
import '../../core/constraits/app_strings.dart';
import 'result_provider.dart';

class ResultScreen extends StatelessWidget {
  final String text;
  const ResultScreen({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ResultProvider()..setText(text),
      child: Consumer<ResultProvider>(
        builder: (context, provider, _) {
          return Scaffold(
            appBar: AppBar(title: Text(AppStrings.appName, style: TextStyle(color: Colors.white),), backgroundColor: AppColors.background,),
            backgroundColor: AppColors.background,            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    // ✅ Scrollable text area
                    Expanded(
                      child: SingleChildScrollView(
                        child: TextCard(
                          text: provider.text ?? '',
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    // ✅ Responsive buttons
                    Row(
                      children: [
                        Expanded(
                          child: PrimaryButton(
                            text: AppStrings.copyButton,
                            onPressed: () {
                              provider.copyToClipboard();
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content:
                                  Text('Text copied to clipboard'),
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: PrimaryButton(
                            text: 'Save',
                            onPressed: () async {
                              await provider.saveText(context);
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Text saved'),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
