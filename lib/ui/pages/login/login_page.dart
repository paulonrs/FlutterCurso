// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';

import '../../components/components.dart';
import '../home/home.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Form(
              child: Column(children: <Widget>[
                const Padding(
                  padding: EdgeInsets.only(bottom: 20),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: SizedBox(
                      width: 201,
                      child: Text(
                        'Acesse sua conta',
                        style: TextStyle(
                          fontSize: 32,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0, bottom: 20),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Email',
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                ),
                PasswordInputField(),
                const Padding(
                  padding: EdgeInsets.only(top: 10.0),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Text(
                      'Esqueci minha senha',
                      textAlign: TextAlign.end,
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
                ButtonPrimary(
                  text: 'Acessar',
                  function: () => {
                    Navigator.pop(context),
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => HomePage()))
                  },
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: 5),
                        child: Text(
                          'Não tem uma conta ?',
                          style: TextStyle(
                              fontSize: 18,
                              color: Color.fromARGB(255, 137, 137, 137)),
                        ),
                      ),
                      Text(
                        'Cadastre-se',
                        style: TextStyle(
                            fontWeight: FontWeight.w400, fontSize: 18),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 3,
                          decoration: ShapeDecoration(
                            color: const Color.fromARGB(83, 119, 119, 119),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                      const Expanded(
                        child: Column(
                          children: [
                            Text('OU'),
                            Text('Acesse com'),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: 3,
                          decoration: ShapeDecoration(
                            color: const Color.fromARGB(83, 119, 119, 119),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 50.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      MaterialButton(
                        onPressed: () {},
                        child: Container(
                          width: 120,
                          height: 62,
                          decoration: ShapeDecoration(
                            color: const Color(0xFF111111),
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(
                                  width: 1, color: Color(0xFF646464)),
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: 120,
                        height: 62,
                        decoration: ShapeDecoration(
                          color: const Color(0xFF111111),
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(
                                width: 1, color: Color(0xFF646464)),
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
