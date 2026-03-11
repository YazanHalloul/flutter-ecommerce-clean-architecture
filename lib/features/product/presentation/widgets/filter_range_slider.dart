import 'package:flutter/material.dart';

class FilterRangeSlider extends StatelessWidget {
  final String title;
  final double min;
  final double max;
  final double currentMin;
  final double currentMax;
  final String suffixText;
  final Function(RangeValues) onChanged;

  const FilterRangeSlider({
    super.key,
    required this.title,
    required this.min,
    required this.max,
    required this.currentMin,
    required this.currentMax,
    required this.onChanged,
    required this.suffixText,
  });

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;

    return Column(
      children: [
        Align(
          alignment: AlignmentGeometry.topLeft,
          child: Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
          ),
        ),

        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            activeTrackColor: primaryColor,
            thumbColor: primaryColor,
            overlayColor: const Color(0x29FFD369),
            trackHeight: 1,
            rangeThumbShape: RoundRangeSliderThumbShape(enabledThumbRadius: 6),

            valueIndicatorColor: primaryColor,
            rangeValueIndicatorShape: DropRangeSliderValueIndicatorShape(),
            valueIndicatorTextStyle: TextStyle(
              color: const Color(0xFF222831),
              fontWeight: FontWeight.bold,
            ),
            showValueIndicator: ShowValueIndicator.onDrag,
          ),
          child: RangeSlider(
            values: RangeValues(currentMin, currentMax),
            min: min,
            max: max,
            labels: RangeLabels(
              "$suffixText${currentMin.round().toString()}",
              "$suffixText${currentMax.round().toString()}",
            ),
            onChanged: onChanged,
          ),
        ),
        Text(
          "${currentMin.toStringAsFixed(2)} - ${currentMax.toStringAsFixed(2)}",
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
