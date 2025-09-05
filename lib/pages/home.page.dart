import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFE8F5E9), Color(0xFFFFFFFF)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(title: const Text("Calendrier de collecte")),
        body: const Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            "Calendrier statique :\n\n"
            "Lundi – Plastique (quartier A)\n"
            "Mardi – Papier (quartier B)\n"
            "Mercredi – Verre (quartier C)\n"
            "Jeudi – Organique (quartier D)\n"
            "Vendredi – Métaux (quartier E)",
            style: TextStyle(fontSize: 16),
          ),
        ),
      ),
    );
  }
}
