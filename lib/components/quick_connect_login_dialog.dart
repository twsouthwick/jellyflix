import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:jellyflix/services/auth_service.dart';

class QuickConnectLoginDialog extends HookConsumerWidget {
  final String serverUrl;
  final Provider<AuthService> authProvider;

  const QuickConnectLoginDialog(
      {super.key, required this.serverUrl, required this.authProvider});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final code = useState<String?>(null);
     
     useEffect((){
        ref.read(authProvider).loginByQuickConnect( serverUrl, (c) => code.value = c, CancelToken());
     },[]);


    return Dialog(
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              AppLocalizations.of(context)!.quickConnect,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 20),
            Text(AppLocalizations.of(context)!.quickConnectDescription),
            const SizedBox(height: 20),
            SizedBox(
              width: 250,
              child: Text(code.value ?? ""),
            )
          ],
        ),
      ),
    );
  }
}
