import 'package:flutter/material.dart';
import 'package:sr_clone_flutter/presentation/colors.dart';
import 'package:sr_clone_flutter/presentation/constants.dart';

class PageWithTabs extends StatelessWidget {
  const PageWithTabs({required this.pageTitle, super.key});

  final String pageTitle;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SRColors.primaryBackground,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: SRConstants.spacing3),
          child: CustomScrollView(
            slivers: [
              _Header(
                pageTitle: pageTitle,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({required this.pageTitle});

  final String pageTitle;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: SRConstants.spacing5,
        ),
        child: Text(pageTitle, style: const TextStyle(color: SRColors.primaryForeground, fontSize: 20, fontWeight: FontWeight.w500)),
      ),
    );
  }
}
