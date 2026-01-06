import 'package:flutter/material.dart';
import 'book.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String selectedAuthor = authors[0];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadBooks();
  }

  Future<void> _loadBooks() async {
    await updateBooks();
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final filteredList = books.where((book) {
      return book.author.trim().toLowerCase() ==
          selectedAuthor.trim().toLowerCase();
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Show Books'),
        centerTitle: true,
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 10),

            /// AUTHOR SELECTION
            MyWidget(
              onAuthorSelected: (author) {
                setState(() {
                  selectedAuthor = author;
                });
              },
            ),

            const SizedBox(height: 20),

            /// BOOK LIST
            Expanded(
              child: filteredList.isEmpty
                  ? const Center(
                child: Text(
                  'No books found for the selected author.',
                  style: TextStyle(fontSize: 16),
                ),
              )
                  : ListView.builder(
                itemCount: filteredList.length,
                itemBuilder: (context, index) {
                  final book = filteredList[index];
                  return Card(
                    child: ListTile(
                      title: Text(book.title),
                      subtitle: Text(
                        'Genre: ${book.genre}\n'
                            'Stock: ${book.stock}\n'
                            'Price: ${book.price}\$',
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}