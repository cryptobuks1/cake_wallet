import 'package:cake_wallet/src/stores/account_list/account_list_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:cake_wallet/palette.dart';
import 'package:cake_wallet/src/widgets/primary_button.dart';
import 'package:cake_wallet/src/screens/base_page.dart';
import 'package:provider/provider.dart';
import 'package:cake_wallet/theme_changer.dart';
import 'package:cake_wallet/themes.dart';
import 'package:cake_wallet/src/domain/monero/account.dart';

class AccountPage extends BasePage {
  String get title => 'Account';
  final Account account;

  AccountPage({this.account});

  @override
  Widget body(BuildContext context) => AccountForm(account);
}

class AccountForm extends StatefulWidget {
  final Account account;

  AccountForm(this.account);

  @override
  createState() => AccountFormState();
}

class AccountFormState extends State<AccountForm> {
  final _formKey = GlobalKey<FormState>();
  final _textController = TextEditingController();

  @override
  void initState() {
    if (widget.account != null) _textController.text = widget.account.label;
    super.initState();
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final accountListStore = Provider.of<AccountListStore>(context);

    ThemeChanger _themeChanger = Provider.of<ThemeChanger>(context);
    bool _isDarkTheme = _themeChanger.getTheme() == Themes.darkTheme;

    return Form(
      key: _formKey,
      child: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            Expanded(
                child: Center(
                  child: TextFormField(
                    decoration: InputDecoration(
                        hintStyle: TextStyle(
                            color: _isDarkTheme ? PaletteDark.darkThemeGrey
                                : Palette.lightBlue
                        ),
                        hintText: 'Account',
                        focusedBorder: UnderlineInputBorder(
                            borderSide:
                            BorderSide(
                                color: _isDarkTheme ? PaletteDark.darkThemeGreyWithOpacity
                                    : Palette.lightGrey,
                                width: 1.0
                            )),
                        enabledBorder: UnderlineInputBorder(
                            borderSide:
                            BorderSide(
                                color: _isDarkTheme ? PaletteDark.darkThemeGreyWithOpacity
                                    : Palette.lightGrey,
                                width: 1.0
                            ))),
                controller: _textController,
                validator: (value) {
                  accountListStore.validateAccountName(value);
                  return accountListStore.errorMessage;
                },
              ),
            )),
            PrimaryButton(
              onPressed: () async {
                if (!_formKey.currentState.validate()) {
                  return;
                }

                if (widget.account != null) {
                  await accountListStore.renameAccount(index: widget.account.id,
                      label: _textController.text);
                } else {
                  await accountListStore.addAccount(
                      label: _textController.text);
                }
                Navigator.pop(context, _textController.text);
              },
              text: widget.account != null ? 'Rename' : 'Add',
              color: _isDarkTheme ? PaletteDark.darkThemePurpleButton
                  : Palette.purple,
              borderColor: _isDarkTheme ? PaletteDark.darkThemePurpleButtonBorder
                  : Palette.deepPink,
            )
          ],
        ),
      ),
    );
  }
}