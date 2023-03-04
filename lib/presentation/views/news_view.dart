import 'package:flutter/material.dart';
import 'package:sr_clone_flutter/presentation/components/page_with_tabs.dart';

class NewsView extends StatelessWidget {
  const NewsView({super.key});

  @override
  Widget build(BuildContext context) {
    return const PageWithTabs(pageTitle: 'Nyheter');
  }
}
