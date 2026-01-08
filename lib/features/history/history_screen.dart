import 'package:flutter/material.dart';
import 'package:paktext/core/constraits/app_colors.dart';
import 'package:paktext/core/constraits/app_strings.dart';
import 'package:paktext/core/utils/date_utils.dart';
import 'package:provider/provider.dart';
import 'history_provider.dart';
import '../result/result_screen.dart'; // import your ResultScreen

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HistoryProvider()..loadHistory(),
      child: Consumer<HistoryProvider>(
        builder: (context, provider, _) {
          return Scaffold(
            appBar: AppBar(title: Text(AppStrings.appName, style: TextStyle(color: Colors.white),), backgroundColor: AppColors.background,),
            backgroundColor: AppColors.background,
                body: provider.history.isEmpty
                ? const Center(child: Text('No scans available'))
                : ListView.separated(
              itemCount: provider.history.length,
              itemBuilder: (context, index) {
                final item = provider.history[index];
                return ListTile(
                  title: Text(
                    item['text'],
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  subtitle: Text(DateUtilss.formatDate(item['date'])),
                  textColor: Colors.white,
                  onTap: () {
                    // Navigate to ResultScreen and pass full text
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ResultScreen(text: item['text']),
                      ),
                    );
                  },
                );
              },
              separatorBuilder: (context, index) => const Divider(
                color: Colors.grey,
                thickness: 1,
              ),
            ),
          );
        },
      ),
    );
  }
}
