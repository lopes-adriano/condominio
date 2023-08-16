import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ReadUsers extends StatefulWidget {
  const ReadUsers({super.key});

  @override
  State<ReadUsers> createState() => _ReadUsersState();
}

class _ReadUsersState extends State<ReadUsers> {
  late CollectionReference<Map<String, dynamic>> usersCollection;
  late QuerySnapshot<Map<String, dynamic>> usersSnapshot;
  List<DocumentSnapshot<Map<String, dynamic>>> filteredUsers = [];

  @override
  void initState() {
    super.initState();
    usersCollection = FirebaseFirestore.instance.collection('usuarios');
    fetchUsers();
  }

  Future<void> fetchUsers() async {
    usersSnapshot = await usersCollection.get();
    setState(() {
      filteredUsers = usersSnapshot.docs;
    });
  }

  void filterUsers(String searchText) {
    setState(() {
      filteredUsers = usersSnapshot.docs.where((user) {
        final data = user.data();
        final userName = data['nome'].toString().toLowerCase();
        return userName.contains(searchText.toLowerCase());
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Usuários'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (value) => filterUsers(value),
              decoration: const InputDecoration(
                labelText: 'Pesquisar',
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredUsers.length,
              itemBuilder: (context, index) {
                final user = filteredUsers[index].data();
                return ListTile(
                  title: Text(user!['nome'].toString()),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('acesso: ${user['tipoUsuario'].toString()}'),
                      Text('Apartamento: ${user['apartamento'].toString()}'),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
