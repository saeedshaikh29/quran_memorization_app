import 'package:flutter/material.dart';

import '../../../../core/constants/surah_data.dart';
import '../../../reader/presentation/pages/reader_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quran Memorization'),
      ),
      body: ListView.builder(
        itemCount: surahs.length,
        itemBuilder: (context, index) {
          final surah = surahs[index];

          return ListTile(
            title: Text(surah.name),
            subtitle: Text('Page ${surah.startPage}'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ReaderPage(
                    initialPage: surah.startPage,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}