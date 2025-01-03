import 'package:flutter/material.dart';
import 'package:country_flags/country_flags.dart';

class CountriesList extends StatelessWidget {
  final Map<String, double> countries;

  const CountriesList({super.key, required this.countries});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: countries.entries.map((entry) {
        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: CountryFlag.fromCountryCode(
                      _getCountryCode(entry.key),
                      height: 20,
                      width: 30,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    entry.key,
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              Text(
                '${entry.value}%',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  String _getCountryCode(String country) {
    switch (country) {
      case 'United States':
        return 'US';
      case 'Germany':
        return 'DE';
      case 'Spain':
        return 'ES';
      case 'Italy':
        return 'IT';
      case 'France':
        return 'FR';
      case 'United Kingdom':
        return 'GB';
      case 'China':
        return 'CN';
      case 'Japan':
        return 'JP';
      default:
        return 'UN';
    }
  }
}