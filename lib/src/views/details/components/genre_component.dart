import 'package:flutter/material.dart';
import 'package:movie_app/src/configs/color_config.dart';
import 'package:movie_app/src/configs/configs.dart';
import 'package:movie_app/src/models/details/common_details_models.dart';
import 'package:movie_app/src/views/details/components/header_text.dart';

Widget genreBuilder({required List<Genre> genres}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      headerBuilder(headerText: "Genre"),
      const SizedBox(height: 8),
      Wrap(
        spacing: 4,
        runSpacing: 6,
        runAlignment: WrapAlignment.start,
        children: List.from(
          genres.map(
            (e) => Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: primaryDarkBlue.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                e.name ?? "",
                style: TextStyle(
                  fontSize: n - 2,
                  color: primaryDarkBlue.withOpacity(0.7),
                ),
              ),
            ),
          ),
        ),
      ),
    ],
  );
}