import 'package:flutter/material.dart';

import '../../helpers/errors/errors.dart';

class EmailInput extends StatelessWidget {
  const EmailInput({super.key});

  @override
  Widget build(BuildContext context) {
    // final presenter = Provider.of<LoginPresenter>(context);
    return StreamBuilder<UIError?>(
      // stream: presenter.emailErrorStream,
      builder: (context, snapshot) {
        return TextFormField(
          decoration: InputDecoration(
            labelText: R.string.email,
            icon: Icon(Icons.email, color: Theme.of(context).primaryColorLight),
            errorText: snapshot.data?.description,
          ),
          keyboardType: TextInputType.emailAddress,
          // onChanged: presenter.validateEmail,
        );
      },
    );
  }
}
