import 'package:ui_components/colors.dart';
import 'package:ui_components/ui_components.dart';
import 'package:widgetbook/widgetbook.dart';

class SRChannelsRowComponent extends WidgetbookComponent {
  SRChannelsRowComponent()
      : super(
          name: 'Channels Row',
          useCases: [
            WidgetbookUseCase(
              name: 'Loading',
              builder: (context) {
                return SRChannelsRow(
                  numberOfItems: context.knobs.number(label: 'Number of channels', initialValue: 5) as int,
                  itemSpacing: double.parse(context.knobs.number(label: 'Spacing', initialValue: 10.0).toString()),
                  channelBuilder: (context, index, size) {
                    return SRChannelCard.loading();
                  },
                );
              },
            ),
            WidgetbookUseCase(
              name: 'Failure',
              builder: (context) {
                return SRChannelsRow(
                  numberOfItems: context.knobs.number(label: 'Number of channels', initialValue: 5) as int,
                  itemSpacing: double.parse(context.knobs.number(label: 'Spacing', initialValue: 10.0).toString()),
                  channelBuilder: (context, index, size) {
                    return SRChannelCard.create(
                      channelImageUrl: 'invalidURL',
                      fallbackColor: context.knobs.options(
                        label: 'Fallback color',
                        options: const [
                          Option(label: 'Primary Highlight', value: SRColors.primaryHighlight),
                          Option(label: 'Secondary Highlight', value: SRColors.secodaryHighlight),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
            WidgetbookUseCase(
              name: 'Default',
              builder: (context) {
                return SRChannelsRow(
                  numberOfItems: context.knobs.number(label: 'Number of channels', initialValue: 5) as int,
                  itemSpacing: double.parse(context.knobs.number(label: 'Spacing', initialValue: 10.0).toString()),
                  channelBuilder: (context, index, size) {
                    return SRChannelCard.create(
                      channelImageUrl: 'invalidURL',
                      fallbackColor: context.knobs.options(
                        label: 'Fallback color',
                        options: const [
                          Option(label: 'Primary Highlight', value: SRColors.primaryHighlight),
                          Option(label: 'Secondary Highlight', value: SRColors.secodaryHighlight),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ],
        );
}
