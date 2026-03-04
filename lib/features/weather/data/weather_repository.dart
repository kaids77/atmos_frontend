import 'package:shared_preferences/shared_preferences.dart';

/// Manages the persistence of searched city names using SharedPreferences.
class WeatherRepository {
  static const String _key = 'weather_search_history';

  /// Load the list of saved city names.
  Future<List<String>> loadSearchHistory() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_key) ?? [];
  }

  /// Add a city to the search history (avoid duplicates, most recent first).
  Future<void> addCity(String city) async {
    final prefs = await SharedPreferences.getInstance();
    final list = prefs.getStringList(_key) ?? [];
    // Remove if exists so it moves to front
    list.remove(city);
    list.insert(0, city);
    await prefs.setStringList(_key, list);
  }

  /// Remove a city from the search history.
  Future<void> removeCity(String city) async {
    final prefs = await SharedPreferences.getInstance();
    final list = prefs.getStringList(_key) ?? [];
    list.remove(city);
    await prefs.setStringList(_key, list);
  }
}
