// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:db/providers/transaction_provider.dart';
import 'package:provider/provider.dart';
import 'package:db/models/transactions.dart';
import 'package:intl/intl.dart';

class FormScreen extends StatelessWidget {
  final formKey = GlobalKey<FormState>();

  //Controller
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  final durationController = TextEditingController();
  final directorController = TextEditingController();
  final ratingController = TextEditingController();
  final categoryController = TextEditingController();

  final ButtonStyle style =
      ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20));

  FormScreen({super.key});

//widget untuk membuat form terdiri dari TextFormField dan ElevatedButton untuk trigger update data

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Tambah Data'),
        ),
        body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Form(
              key: formKey,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      //Title
                      decoration:
                          const InputDecoration(labelText: "Judul Film"),
                      autofocus: false,
                      controller: titleController,
                      validator: (String? str) {
                        if (str!.isEmpty) {
                          return "Judul film tidak boleh kosong.";
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      //Title
                      decoration:
                          const InputDecoration(labelText: "Nama Sutradara"),
                      autofocus: false,
                      controller: directorController,
                      validator: (String? str) {
                        if (str!.isEmpty) {
                          return "Nama sutradara tidak boleh kosong.";
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      //Title
                      decoration: const InputDecoration(labelText: "Kategori"),
                      autofocus: false,
                      controller: categoryController,
                      validator: (String? str) {
                        if (str!.isEmpty) {
                          return "Kategori tidak boleh kosong.";
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      //Title
                      decoration: const InputDecoration(labelText: "rating"),
                      keyboardType: TextInputType.number,
                      autofocus: false,
                      controller: ratingController,
                      validator: (String? str) {
                        if (str!.isEmpty) {
                          return "Rating tidak boleh kosong.";
                        }
                        if (double.parse(str) <= 0) {
                          return "Nilai harus lebih dari 0 0.";
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      //Duration
                      decoration: const InputDecoration(labelText: "Durasi"),
                      keyboardType: TextInputType.number,
                      controller: durationController,
                      validator: (String? str) {
                        if (str!.isEmpty) {
                          return "Durasi tidak boleh kosong.";
                        }
                        if (double.parse(str) <= 0) {
                          return "Nilai harus lebih dari 0 0.";
                        }
                        return null;
                      },
                    ),
                    Container(
                        child: Align(
                      alignment: Alignment.centerRight,
                      child: ElevatedButton(
                        style: const ButtonStyle(
                          overlayColor: MaterialStatePropertyAll(Colors.pink),
                          backgroundColor:
                              MaterialStatePropertyAll<Color>(Colors.purple),
                          alignment: Alignment.centerRight,
                          shadowColor: MaterialStatePropertyAll(Colors.black),
                        ),
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            var title = titleController.text;
                            var director = directorController.text;
                            var duration =
                                double.parse(durationController.text);
                            var rating = double.parse(ratingController.text);
                            var category = categoryController.text;

                            // call provider
                            var provider = Provider.of<TransactionProvider>(
                                context,
                                listen: false);
                            Transactions item = Transactions(
                              title: title,
                              director: director,
                              duration: duration,
                              rating: rating,
                              category: category,
                            );
                            provider.addTransaction(item);
                            Navigator.pop(context);
                          }
                        },
                        child: const Text("Tambah data"),
                      ),
                    ))
                  ]),
            )));
  }
}
