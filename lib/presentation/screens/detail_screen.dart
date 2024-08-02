import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:technical_test/presentation/providers/book_provider.dart';

class DetailScreen extends StatelessWidget {
  final String id;

  const DetailScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    final booksProvider = context.read<BookProvider>();

    return FutureBuilder(
      future: booksProvider.getBookByIdSelected(id),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        } else if (snapshot.hasError) {
          return Scaffold(
            body: Center(child: Text('Error: ${snapshot.error}')),
          );
        }

        final book = booksProvider.bookSelected;
        if (book.key == '') {
          return const Scaffold(
            body: Center(child: Text('Book not found')),
          );
        }

        return Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              context.go('/');
            },
            child: const Icon(Icons.arrow_back_ios_new_outlined),
          ),
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 250.0,
                flexibleSpace: Hero(
                  tag: book.key,
                  
                  child: FlexibleSpaceBar(
                    background: book.coverIImage == 'assets/no-image.jpg'
                        ? Image.asset(
                            book.coverIImage,
                            fit: BoxFit.cover,
                          )
                        : Image.network(
                            book.coverIImage,
                            fit: BoxFit.cover,
                          ),
                  ),
                ),
                pinned: true,
              ),
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            book.title,
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                          const SizedBox(height: 8.0),
                          Text(
                            '${book.authorName} - Publicado ${book.firstPublishYear}',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          const SizedBox(
                            height: 8.0,
                          ),
                          Text(
                            book.firstSentence,
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
