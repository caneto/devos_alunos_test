// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/cupertino.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';

import '../ui/messages.dart';
import 'default_change_notifier.dart';

class DefaultListenerNotifier {
  final DefaultChangeNotifier changeNotifier;

  const DefaultListenerNotifier({required this.changeNotifier});

  void listener({
    required BuildContext context,
    required SucessVoidCallback sucessVoidCallback,
    EverVoidCallback? everVoidCallback,
    ErrorVoidCallback? errorCallback,
  }) {
    changeNotifier.addListener(() {
      if(everVoidCallback != null) {
        everVoidCallback(changeNotifier, this);
      }

      if (changeNotifier.loading) {
        Loader.show(context);
      } else {
        Loader.hide();
      }

      if (changeNotifier.hasError) {
        if(errorCallback != null) {
          errorCallback(changeNotifier, this);
        }
        Messages.of(context).showError(changeNotifier.error ?? 'Erro interno');
      } else if (changeNotifier.isSuccess) {
        // ignore: unnecessary_null_comparison
        if(sucessVoidCallback != null) {
          sucessVoidCallback(changeNotifier, this);
        }
      }
    });
  }

  void dispose() {
    changeNotifier.removeListener(() { });
  }
}

typedef SucessVoidCallback = void Function(
    DefaultChangeNotifier notifier, DefaultListenerNotifier listenerNotifier);

typedef ErrorVoidCallback = void Function(
    DefaultChangeNotifier notifier, DefaultListenerNotifier listenerNotifier);

typedef EverVoidCallback = void Function(
    DefaultChangeNotifier notifier, DefaultListenerNotifier listenerNotifier);
