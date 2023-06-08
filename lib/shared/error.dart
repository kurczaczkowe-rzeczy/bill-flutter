import 'package:flutter/material.dart';
import 'package:paragony/shared/loading.dart';

Widget showError() {
  return Text('Nie można pobrać danych', style: TextStyle(color: Colors.red));
}

WidgetfutureBuilderGlobal(AsyncSnapshot<dynamic> snapshot,
    {Widget errorWidget = const Text('Nie można pobrać danych',
        style: TextStyle(color: Colors.red)),
    required ValueSetter<dynamic> resultWidget}) {
  if (snapshot.hasError) {
    return showError();
  }

  switch (snapshot.connectionState) {
    case ConnectionState.done:
      {
        return resultWidget(snapshot.data);
      }
    default:
      {
        return Loading();
      }
  }
}
