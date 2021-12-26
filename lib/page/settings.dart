import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:ajuda_app/utils/user_secure_storage.dart';
import 'package:ajuda_app/widgets/button_widget.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final controllerClientId = TextEditingController();
  final controllerSecretKey = TextEditingController();
  final controllerRefreshToken = TextEditingController();

  @override
  void initState() {
    super.initState();
    init();
  }

  Future init() async {
    final clientId = await UserSecureStorage.getClientId() ?? '';
    final clientSecret = await UserSecureStorage.getClientSecret() ?? '';
    final refreshToken = await UserSecureStorage.getRefreshToken() ?? '';

    setState(() {
      this.controllerClientId.text = clientId;
      this.controllerSecretKey.text = clientSecret;
      this.controllerRefreshToken.text = refreshToken;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Configurações"),
      ),
      body: SafeArea(
        child: ListView(padding: EdgeInsets.all(16), children: [
          const SizedBox(height: 32),
          buildTextInput('client id', this.controllerClientId),
          const SizedBox(height: 32),
          buildTextInput('secret key', this.controllerSecretKey),
          const SizedBox(height: 32),
          buildTextInput('refresh token', this.controllerRefreshToken),
          const SizedBox(height: 32),
          buildButton(),
        ]),
      ),
    );
  }

  Widget buildTextInput(String name, controllerName) => buildTitle(
        title: name,
        child: TextFormField(
          controller: controllerName,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
          ),
        ),
      );

  
  Widget buildTitle({
    required String title,
    required Widget child,
  }) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          const SizedBox(height: 8),
          child,
        ],
      );
  Widget buildButton() => ButtonWidget(
      text: 'Salvar',
      onClicked: () async {
        await UserSecureStorage.setClientId(controllerClientId.text);
        await UserSecureStorage.setClientSecret(controllerSecretKey.text);
        await UserSecureStorage.setRefreshToken(controllerRefreshToken.text);
        final snackBar = SnackBar(
            content: const Text('Dados salvos!!!'),
            action: SnackBarAction(
              label: 'Undo',
              onPressed: () {
                // Some code to undo the change.
              },
            ),
          );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      });
}
