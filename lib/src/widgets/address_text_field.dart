import 'package:cake_wallet/routes.dart';
import 'package:flutter/material.dart';
import 'package:cake_wallet/palette.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:cake_wallet/src/domain/common/contact.dart';
import 'package:provider/provider.dart';
import 'package:cake_wallet/themes.dart';
import 'package:cake_wallet/theme_changer.dart';

class AddressTextField extends StatelessWidget {
  final TextEditingController controller;
  final bool isActive;
  final String placeholder;
  final Function(Uri) onURIScanned;

  AddressTextField(
      {@required this.controller,
      this.isActive = true,
      this.placeholder = 'Address',
      this.onURIScanned});

  @override
  Widget build(BuildContext context) {
    ThemeChanger _themeChanger = Provider.of<ThemeChanger>(context);
    bool _isDarkTheme;

    if (_themeChanger.getTheme() == Themes.darkTheme)
      _isDarkTheme = true;
    else
      _isDarkTheme = false;

    return TextField(
        enabled: isActive,
        controller: controller,
        decoration: InputDecoration(
          suffixIcon: SizedBox(
            width: 90,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(width: 5),
                Container(
                    width: 34,
                    height: 34,
                    padding: EdgeInsets.only(top: 0),
                    child: InkWell(
                      onTap: () async => _presetAddressBookPicker(context),
                      child: Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              color: Palette.wildDarkBlueWithOpacity,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8))),
                          child: Image.asset(
                              'assets/images/address_book_icon.png')),
                    )),
                Container(
                    width: 34,
                    height: 34,
                    padding: EdgeInsets.only(top: 0),
                    child: InkWell(
                      onTap: () async => _presentQRScanner(context),
                      child: Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              color: Palette.wildDarkBlueWithOpacity,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8))),
                          child: Image.asset('assets/images/qr_code_icon.png')),
                    ))
              ],
            ),
          ),
          hintStyle: TextStyle(
              color:
                  _isDarkTheme ? PaletteDark.darkThemeGrey : Palette.lightBlue),
          hintText: placeholder,
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                  color: _isDarkTheme
                      ? PaletteDark.darkThemeGreyWithOpacity
                      : Palette.lightGrey,
                  width: 1.0)),
          enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                  color: _isDarkTheme
                      ? PaletteDark.darkThemeGreyWithOpacity
                      : Palette.lightGrey,
                  width: 1.0)),
        ));
  }

  Future _presentQRScanner(BuildContext context) async {
    try {
      String code = await BarcodeScanner.scan();
      var uri = Uri.parse(code);
      var address = '';

      if (uri == null) {
        controller.text = code;
        return;
      }

      address = uri.path;
      controller.text = address;

      if (onURIScanned != null) {
        onURIScanned(uri);
      }
    } catch (e) {
      print('Error $e');
    }
  }

  Future _presetAddressBookPicker(BuildContext context) async {
    final contact = await Navigator.of(context, rootNavigator: true)
        .pushNamed(Routes.pickerAddressBook);

    if (contact is Contact && contact.address != null) {
      controller.text = contact.address;
    }
  }
}
