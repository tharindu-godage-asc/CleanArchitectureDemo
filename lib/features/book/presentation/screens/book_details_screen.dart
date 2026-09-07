import 'package:clean_architecture_demo/features/book/presentation/providers/book_details_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/extensions/context_extensions.dart';

class BookDetailsScreen extends ConsumerStatefulWidget {
  const new({super.key, required this.bookId});

  final int bookId;

  @override
  ConsumerState<BookDetailsScreen> createState() => _BookDetailsScreenState();
}

class _BookDetailsScreenState extends ConsumerState<BookDetailsScreen> {
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(),
    body: ref
        .watch(bookDetailsProvider(widget.bookId))
        .when(
          data: (book) => Column(
            crossAxisAlignment: .start,
            children: [
              Text(context.l10n.bookAuthors(book.author)),
              Text(context.l10n.bookIsbn(book.isbn)),
              Text(context.l10n.bookYear(book.publishedYear)),
            ],
          ),
          error: (error, _) => Center(child: Text('Error: $error')),
          loading: () => Center(child: CircularProgressIndicator()),
        ),
  );
}
