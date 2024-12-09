import 'package:flutter/material.dart';
import 'package:sign_dictionary/services/words_fetcher.dart';

class WordListScreen extends StatelessWidget {
  final String category;

  const WordListScreen({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Words in $category'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: WordService.fetchWordsByCategory(category, 0, 10),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error loading words.'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No words found for this category.'));
          }

          final words = snapshot.data!;
          return ListView.builder(
            itemCount: words.length,
            itemBuilder: (context, index) {
              final word = words[index];
              return Card(
                margin: const EdgeInsets.all(10),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        word['name'][Localizations.localeOf(context).languageCode],
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 5),
                      Text(word['meaning'][Localizations.localeOf(context).languageCode]),
                      if (word['videoLink'] != null)
                        const SizedBox(height: 5),
                      if (word['videoLink'] != null)
                        GestureDetector(
                          onTap: () {
                            // Handle video playback here
                          },
                          child: const Text(
                            'Watch Video',
                            style: TextStyle(color: Colors.blue, decoration: TextDecoration.underline),
                          ),
                        ),
                    ],
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
