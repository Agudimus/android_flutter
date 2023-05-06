// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:db/providers/transaction_provider.dart';
import 'package:provider/provider.dart';
import 'package:db/models/transactions.dart';

class FormEditScreen extends StatefulWidget {
  final Transactions data;

  //Controller

  const FormEditScreen({Key? key, required this.data}) : super(key: key);

  @override
  State<FormEditScreen> createState() => _FormEditScreenState();
}

class _FormEditScreenState extends State<FormEditScreen> {
  final formKey = GlobalKey<FormState>();

  final idController = TextEditingController();
  final titleController = TextEditingController();
  final directorController = TextEditingController();
  final durationController = TextEditingController();
  final ratingController = TextEditingController();
  final categoryController = TextEditingController();

  final ButtonStyle style =
      ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20));

  @override
  void initState() {
    super.initState();
    idController.text = widget.data.id.toString();
    titleController.text = widget.data.title.toString();
    directorController.text = widget.data.director.toString();
    durationController.text = widget.data.duration.toString();
    ratingController.text = widget.data.rating.toString();
    categoryController.text = widget.data.category.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Update Data'),
        ),
        body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Form(
              key: formKey,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
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
                      decoration:
                          const InputDecoration(labelText: "Durasi Film"),
                      keyboardType: TextInputType.number,
                      controller: durationController,
                      validator: (String? str) {
                        if (str!.isEmpty) {
                          return "Durasi film tidak boleh kosong.";
                        }
                        if (double.parse(str) <= 0) {
                          return "Nilai harus lebih dari 0.";
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      decoration: const InputDecoration(labelText: "rating"),
                      keyboardType: TextInputType.number,
                      controller: ratingController,
                      validator: (String? str) {
                        if (str!.isEmpty) {
                          return "Rating tidak boleh kosong.";
                        }
                        if (double.parse(str) <= 0) {
                          return "Nilai harus lebih dari 0.";
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      decoration: const InputDecoration(labelText: "Kategori "),
                      autofocus: false,
                      controller: categoryController,
                      validator: (String? str) {
                        if (str!.isEmpty) {
                          return "Kategori tidak boleh kosong.";
                        }
                        return null;
                      },
                    ),
                   
                    Container(
                        child: Align(
                            alignment: Alignment.centerRight,
                            child: ElevatedButton(
                                style: const ButtonStyle(
                                    overlayColor:
                                        MaterialStatePropertyAll(Colors.pink),
                                    backgroundColor:
                                        MaterialStatePropertyAll<Color>(
                                            Colors.purple),
                                    alignment: Alignment.centerRight,
                                    shadowColor:
                                        MaterialStatePropertyAll(Colors.black)),
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    var id = int.parse(idController.text);
                                    var title = titleController.text;
                                    var director = directorController.text;
                                    var duration =
                                        double.parse(durationController.text);
                                    var rating =
                                        double.parse(ratingController.text);
                                    var category = categoryController.text;

                                    // call provider
                                    var provider =
                                        Provider.of<TransactionProvider>(
                                            context,
                                            listen: false);
                                    Transactions item = Transactions(
                                      id: id,
                                      title: title,
                                      director: director,
                                      duration: duration,
                                      rating: rating,
                                      category: category,
                                    );
                                    provider.updateTransaction(item);
                                    Navigator.pop(context);
                                  }
                                },
                                child: const Text("Simpan data"))))
                  ]),
            )));
  }
}
