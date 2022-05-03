
import 'package:firebase_app/Pages/cadastro_cliente.dart';
import 'package:flutter/material.dart';

class Clientes extends StatefulWidget {
  const Clientes({ Key? key }) : super(key: key);

  @override
  State<Clientes> createState() => _ClientesState();
}

class _ClientesState extends State<Clientes> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: HomePage());
  }
}