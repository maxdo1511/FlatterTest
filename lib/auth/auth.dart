import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {

  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      ),
      body: Center(
        child: Container(
          constraints: const BoxConstraints(
            maxWidth: 400.0,
          ),
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 40.0),
                child: Center(
                    child: Text('Авторизация', style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold)),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 128.0, left: 16.0, right: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const TextField(
                        decoration: InputDecoration(
                          labelText: 'Логин',
                          filled: true,
                          fillColor: Color.fromRGBO(230, 230, 230, 1),
                            border: InputBorder.none,
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      const TextField(
                        decoration: InputDecoration(
                          labelText: 'Пароль',
                          filled: true,
                          fillColor: Color.fromRGBO(230, 230, 230, 1),
                          border: InputBorder.none,
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Checkbox(value: true, onChanged: null),
                          Text('Запомнить меня', style: TextStyle(fontSize: 20.0, color: Colors.grey)),
                        ],
                      ),
                      const SizedBox(height: 10.0),
                      Center(
                        child: SizedBox(
                          width: double.infinity,
                          height: 50.0,
                          child: ElevatedButton(
                            style: ButtonStyle(
                              shape: WidgetStateProperty.all<OutlinedBorder>(
                                const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(6.0)),
                                ),
                              ),
                              backgroundColor: WidgetStateProperty.all<Color>(Colors.blue),
                            ),
                            onPressed: () {
                            },
                            child: const Text('Войти', style: TextStyle(fontSize: 17.0, color: Colors.white)),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      Center(
                        child: SizedBox(
                          width: double.infinity,
                          height: 50.0,
                          child: ElevatedButton(
                            style: ButtonStyle(
                              shape: WidgetStateProperty.all<OutlinedBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6.0),
                                ),
                              ),
                              side: WidgetStateProperty.all<BorderSide>(
                                const BorderSide(color: Colors.blue, width: 2.0), // Синий контур
                              ),
                            ),
                            onPressed: () {
                            },
                            child: const Text('Регистрация', style: TextStyle(fontSize: 17.0, color: Colors.blue)),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      const Text('Восстановить пароль', style: TextStyle(fontSize: 20.0, color: Colors.grey)),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10.0),
            ],
          ),
        ),
      ),
    );
  }
}