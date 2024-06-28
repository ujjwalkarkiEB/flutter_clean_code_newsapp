import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_code_news_app/src/features/daily_news/presentation/bloc/local/article_local_bloc_bloc.dart';

void showSuccessSnackbar(BuildContext context, String text,
    {bool isUndo = false}) {
  final snackBar = SnackBar(
    content: Text(text),
    backgroundColor: Colors.green,
    behavior: SnackBarBehavior.floating,
    duration: const Duration(seconds: 3),
    action: SnackBarAction(
      label: isUndo ? 'Undo' : 'OK',
      textColor: Colors.white,
      onPressed: () {
        if (isUndo) {
          context.read<ArticleLocalBloc>().add(UnsaveArticleEvent());
        }
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
      },
    ),
  );
  ScaffoldMessenger.of(context).clearSnackBars();
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
