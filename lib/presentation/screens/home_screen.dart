import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:go_router/go_router.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:technical_test/presentation/providers/book_provider.dart';
import 'package:technical_test/presentation/providers/search_provider.dart';
import 'package:technical_test/widgets/text_field_container.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: PinteresGrid(),
    );
  }
}

class PinteresGrid extends StatefulWidget {
  const PinteresGrid({super.key});

  @override
  State<PinteresGrid> createState() => _PinteresGridState();
}

class _PinteresGridState extends State<PinteresGrid> {
  @override
  Widget build(BuildContext context) {
    final textFieldProvider = context.watch<FieldProvider>();
    final booksProvider = context.watch<BookProvider>();
    final color = Theme.of(context).colorScheme;

    return SafeArea(
      child: Stack(alignment: AlignmentDirectional.topCenter, children: [
        booksProvider.books.isEmpty
            ? Center(
                child: booksProvider.loader
                    ? LoadingAnimationWidget.inkDrop(
                        color: color.primary,
                        size: 100,
                      )
                    : const Text('Realiza una busquead / Sin resultados'))
            : Container(
                margin: const EdgeInsetsDirectional.only(top: 80),
                child: MasonryGridView.count(
                  itemCount: booksProvider.books.length,
                  crossAxisCount: 2,
                  mainAxisSpacing: 4,
                  crossAxisSpacing: 4,
                  itemBuilder: (context, index) {
                    final book = booksProvider.books[index];
                    return Tile(
                      index: index,
                      extent: (index % 5 + 1) * 100,
                      imageUrl: book.coverIImage,
                      onTap: () {
                        final sptl = book.key.split('/');
                        context.go('/home/${sptl[sptl.length - 1]}');
                      },
                      title: book.title,
                      keyBook: book.key,
                    );
                  },
                ),
              ),
        TextFieldContainer(
          onValue: (value) {
            textFieldProvider.sendText(value);
            booksProvider.setBooks(value);
          },
        ),
      ]),
    );
  }
}

class Tile extends StatelessWidget {
  final int index;
  final double extent;
  final String imageUrl;
  final VoidCallback onTap;
  final String title;
  final String keyBook;

  const Tile({
    required this.title,
    required this.index,
    required this.extent,
    required this.imageUrl,
    required this.onTap,
    required this.keyBook,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: onTap,
      child: Hero(
        tag: keyBook,
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(30)),
          child: Stack(
            children: [
              Container(
                padding: const EdgeInsets.all(5),
                width: 210,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: FadeInImage(
                    placeholder: const AssetImage('assets/no-image.jpg'),
                    image: imageUrl != 'assets/no-image.jpg'
                        ? NetworkImage(imageUrl)
                        : const AssetImage('assets/no-image.jpg'),
                    fit: BoxFit.cover, 
                  ),
                ),
              ),
              Positioned(
                bottom: -4,
                left: 5,
                right: 5,
                child: Container(
                  constraints: BoxConstraints(
                    maxWidth: extent - 10,
                  ),
                  padding: const EdgeInsets.all(9),
                  decoration: BoxDecoration(
                    color: color.primary,
                    borderRadius: const BorderRadius.vertical(
                        bottom: Radius.circular(30)),
                  ),
                  child: Text(
                    title,
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
