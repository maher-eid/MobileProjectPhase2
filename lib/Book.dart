import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

const String baseURL = 'project2mobileapp.great-site.net';


class Book {
  final int id;
  final String title;
  final String genre;
  final int stock;
  final double price;
  final String author;

  Book(this.id, this.title, this.genre, this.stock, this.price, this.author);

  @override
  String toString() {
    return 'BID: $id Title: ${title.toUpperCase()}\nGenre: $genre Stock: $stock Price: $price\$ Author: $author';
  }
}

List<Book> books = []; // List to store book data

List<String> authors = [
  'William Shakespeare',
  'Jane Austen',
  'Toni Morrison'
];

updateBooks() async {
  try {
    print('API TEST: START');

    final url = Uri.http(
      'project2mobileapp.great-site.net',
      'getBooks.php',
    );

    final response = await http.get(url);

    print('API STATUS: ${response.statusCode}');
    print('API BODY: ${response.body}');


    final List data = convert.jsonDecode(response.body);

    books.clear(); // important

    for (var row in data) {
      books.add(
        Book(
          int.parse(row['book_id']),
          row['title'],
          row['genre'],
          int.parse(row['stock']),
          double.parse(row['price'].toString()),
          row['author'],
        ),
      );
    }

    print('BOOKS LOADED: ${books.length}');
    print('FINAL BOOKS LIST: ${books.map((b) => b.author).toList()}');
  } catch (e) {
    print('API ERROR: $e');
  }
}

class MyWidget extends StatefulWidget {
  final Function(String) onAuthorSelected;

  const MyWidget({super.key, required this.onAuthorSelected});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  String? selectedAuthor = authors[0]; // Default selected author

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.only(bottom: 8.0),
          child: Text(
            'Select an Author:',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        Column(
          children: authors.map((author) {
            return RadioListTile<String>(
              title: Text(author),
              value: author,
              groupValue: selectedAuthor,
              onChanged: (value) {
                setState(() {
                  selectedAuthor = value;
                });
                widget.onAuthorSelected(value!); // Notify parent of selection
              },
            );
          }).toList(),
        ),
      ],
    );
  }
}