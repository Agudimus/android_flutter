import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:db/screens/form_edit_screen.dart';
import 'package:provider/provider.dart';

import '../models/transactions.dart';
import '../providers/transaction_provider.dart';
import 'form_screen.dart';
import 'about_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<TransactionProvider>(context, listen: false).initAllData();
  }

//widget dengan kontek iconButton untuk berpindah halaman ke halaman FormScreen dan About Screen
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Ensiklopedia Film"),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return FormScreen();
                  }));
                },
                icon: const Icon(Icons.add)),
            IconButton(
                icon: const Icon(Icons.warning_rounded),
                onPressed: () {
                  // SystemNavigator.pop();
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const AboutScreen();
                  }));
                }),
          ],
        ),
        body: Consumer(
          builder: (context, TransactionProvider providers, Widget? child) {
            var count = providers.transactions.length;
            if (count <= 0) {
              return const Center(
                child: Text(
                  "Tidak Ada Data.",
                  style: TextStyle(fontSize: 35),
                ),
              );
            } else {
              //widget list view untuk menampilkan daftar dari input yang sudah diinput di form
              return ListView.builder(
                itemCount: providers.transactions.length,
                itemBuilder: (context, int index) {
                  Transactions data = providers.transactions[index];

                  return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(24)),
                      ),
                      elevation: 4,
                      color: Color.fromARGB(255, 245, 231, 250),
                      margin: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 12),
                      child: ListTile(
                          enabled: true,
                          leading: CircleAvatar(
                              radius: 30,
                              child: FittedBox(
                                child: Text(
                                  data.rating.toString(),
                                  style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold),
                                ),
                              )),
                          title: Text(
                            data.title,
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            "Duration: " +
                                data.duration.toString() +
                                " min" +
                                "\nDirector: " +
                                data.director.toString(),
                            style: TextStyle(fontSize: 15),
                          ),
                          onTap: () {
                            //untuk berpindah ke FormEditScreen
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return FormEditScreen(data: data);
                            }));
                          },
                          //untuk menghapus data
                          trailing: IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () {
                                var provider = Provider.of<TransactionProvider>(
                                    context,
                                    listen: false);
                                provider.deleteTransaction(data);
                              })));
                },
              );
            }
          },
        ));
  }
}
