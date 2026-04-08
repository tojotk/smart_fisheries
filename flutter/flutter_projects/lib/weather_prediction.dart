import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'package:fluttertoast/fluttertoast.dart';

class WeatherForecast extends StatefulWidget {
  const WeatherForecast({super.key});

  @override
  State<WeatherForecast> createState() => _WeatherForecastState();
}

class _WeatherForecastState extends State<WeatherForecast> {
  final TextEditingController locationController = TextEditingController();
  Map<String, dynamic>? weatherData;
  bool isLoading = false;
  String currentLocation = '';
  double? latitude;
  double? longitude;

  @override
  void initState() {
    super.initState();
    _getCurrentLocationWeather();
  }

  Future<void> _getCurrentLocationWeather() async {
    setState(() {
      isLoading = true;
    });

    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        Fluttertoast.showToast(
          msg: 'Please enable location services',
          backgroundColor: Colors.red[400],
        );
        setState(() {
          isLoading = false;
        });
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          Fluttertoast.showToast(
            msg: 'Location permission denied',
            backgroundColor: Colors.red[400],
          );
          setState(() {
            isLoading = false;
          });
          return;
        }
      }

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      await _fetchWeatherByCoords(position.latitude, position.longitude);
    } catch (e) {
      Fluttertoast.showToast(
        msg: 'Error getting location: $e',
        backgroundColor: Colors.red[400],
      );
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _fetchWeatherByCoords(double lat, double lon) async {
    // Using Open-Meteo API - No API key required!
    final url = Uri.parse(
      'https://api.open-meteo.com/v1/forecast?latitude=$lat&longitude=$lon&current=temperature_2m,relative_humidity_2m,apparent_temperature,precipitation,weather_code,cloud_cover,pressure_msl,surface_pressure,wind_speed_10m,wind_direction_10m&timezone=auto',
    );

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        // Get location name using reverse geocoding (also free, no API key)
        final locationUrl = Uri.parse(
          'https://nominatim.openstreetmap.org/reverse?format=json&lat=$lat&lon=$lon',
        );

        final locationResponse = await http.get(
          locationUrl,
          headers: {'User-Agent': 'WeatherApp/1.0'},
        );

        String cityName = 'Current Location';
        if (locationResponse.statusCode == 200) {
          final locationData = jsonDecode(locationResponse.body);
          cityName = locationData['address']['city'] ??
              locationData['address']['town'] ??
              locationData['address']['village'] ??
              'Current Location';
        }

        setState(() {
          weatherData = data;
          currentLocation = cityName;
          latitude = lat;
          longitude = lon;
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load weather data');
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: 'Error fetching weather: $e',
        backgroundColor: Colors.red[400],
      );
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _fetchWeatherByLocation(String location) async {
    if (location.isEmpty) {
      Fluttertoast.showToast(
        msg: 'Please enter a location',
        backgroundColor: Colors.orange[400],
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    // Use Nominatim for geocoding (no API key required)
    final geocodeUrl = Uri.parse(
      'https://nominatim.openstreetmap.org/search?q=$location&format=json&limit=1',
    );

    try {
      final response = await http.get(
        geocodeUrl,
        headers: {'User-Agent': 'WeatherApp/1.0'},
      );

      if (response.statusCode == 200) {
        final List data = jsonDecode(response.body);

        if (data.isEmpty) {
          Fluttertoast.showToast(
            msg: 'Location not found. Try: "London" or "Mumbai"',
            backgroundColor: Colors.red[400],
            toastLength: Toast.LENGTH_LONG,
          );
          setState(() {
            isLoading = false;
          });
          return;
        }

        final lat = double.parse(data[0]['lat']);
        final lon = double.parse(data[0]['lon']);

        await _fetchWeatherByCoords(lat, lon);
      } else {
        Fluttertoast.showToast(
          msg: 'Error searching location',
          backgroundColor: Colors.red[400],
        );
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: 'Network error: $e',
        backgroundColor: Colors.red[400],
      );
      setState(() {
        isLoading = false;
      });
    }
  }

  String _getWeatherIcon(int weatherCode) {
    // WMO Weather interpretation codes
    if (weatherCode == 0) return '☀️'; // Clear
    if (weatherCode <= 3) return '⛅'; // Partly cloudy
    if (weatherCode <= 48) return '🌫️'; // Fog
    if (weatherCode <= 67) return '🌧️'; // Rain
    if (weatherCode <= 77) return '❄️'; // Snow
    if (weatherCode <= 82) return '🌧️'; // Rain showers
    if (weatherCode <= 86) return '🌨️'; // Snow showers
    if (weatherCode <= 99) return '⛈️'; // Thunderstorm
    return '🌤️';
  }

  String _getWeatherDescription(int weatherCode) {
    if (weatherCode == 0) return 'Clear Sky';
    if (weatherCode == 1) return 'Mainly Clear';
    if (weatherCode == 2) return 'Partly Cloudy';
    if (weatherCode == 3) return 'Overcast';
    if (weatherCode <= 48) return 'Foggy';
    if (weatherCode <= 67) return 'Rainy';
    if (weatherCode <= 77) return 'Snowy';
    if (weatherCode <= 82) return 'Rain Showers';
    if (weatherCode <= 86) return 'Snow Showers';
    if (weatherCode <= 99) return 'Thunderstorm';
    return 'Unknown';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF050b1f),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              const Color(0xFF0a2463),
              const Color(0xFF1e3a8a).withOpacity(0.8),
              const Color(0xFF050b1f),
            ],
            stops: const [0.0, 0.3, 0.8],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFF3b82f6), Color(0xFF60a5fa)],
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.cloud,
                        color: Colors.white,
                        size: 28,
                      ),
                    ),
                    const SizedBox(width: 16),
                    const Text(
                      "Weather Forecast",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              // Search Section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.2),
                    ),
                  ),
                  child: Column(
                    children: [
                      // Search Bar
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF3b82f6).withOpacity(0.3),
                              blurRadius: 15,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: TextField(
                          controller: locationController,
                          style: const TextStyle(fontSize: 16),
                          decoration: InputDecoration(
                            hintText: 'Enter city name (e.g., London, Mumbai)...',
                            prefixIcon: const Icon(
                              Icons.search,
                              color: Color(0xFF3b82f6),
                            ),
                            suffixIcon: IconButton(
                              icon: const Icon(
                                Icons.send,
                                color: Color(0xFF3b82f6),
                              ),
                              onPressed: () {
                                _fetchWeatherByLocation(locationController.text);
                              },
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide.none,
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 16,
                            ),
                          ),
                          onSubmitted: (value) {
                            _fetchWeatherByLocation(value);
                          },
                        ),
                      ),

                      const SizedBox(height: 16),

                      // Current Location Button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: _getCurrentLocationWeather,
                          icon: const Icon(Icons.my_location, size: 20),
                          label: const Text(
                            "Use Current Location",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF3b82f6),
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 5,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Weather Content
              Expanded(
                child: isLoading
                    ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFF3b82f6), Color(0xFF60a5fa)],
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 3,
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        "Fetching weather data...",
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                )
                    : weatherData == null
                    ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(30),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              const Color(0xFF3b82f6).withOpacity(0.2),
                              const Color(0xFF60a5fa).withOpacity(0.2),
                            ],
                          ),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.wb_sunny,
                          size: 80,
                          color: Color(0xFF60a5fa),
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        "Search for weather",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        "Enter a city name or use your location",
                        style: TextStyle(
                          color: Colors.white60,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                )
                    : _buildWeatherContent(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWeatherContent() {
    final current = weatherData!['current'];
    final temp = current['temperature_2m'].round();
    final feelsLike = current['apparent_temperature'].round();
    final weatherCode = current['weather_code'];
    final humidity = current['relative_humidity_2m'];
    final pressure = current['pressure_msl'];
    final windSpeed = current['wind_speed_10m'];
    final cloudCover = current['cloud_cover'];
    final precipitation = current['precipitation'] ?? 0.0;

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          // Location Card
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF3b82f6), Color(0xFF60a5fa)],
              ),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF3b82f6).withOpacity(0.4),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.location_on,
                      color: Colors.white,
                      size: 24,
                    ),
                    const SizedBox(width: 8),
                    Flexible(
                      child: Text(
                        currentLocation,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Text(
                  _getWeatherIcon(weatherCode),
                  style: const TextStyle(fontSize: 80),
                ),
                const SizedBox(height: 16),
                Text(
                  '$temp°C',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 64,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  _getWeatherDescription(weatherCode).toUpperCase(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 2,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Feels like $feelsLike°C',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.8),
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // Weather Details Grid
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            childAspectRatio: 1.3,
            children: [
              _buildWeatherCard(
                icon: Icons.air,
                label: 'Wind Speed',
                value: '${windSpeed.toStringAsFixed(1)} km/h',
                color: const Color(0xFF10b981),
              ),
              _buildWeatherCard(
                icon: Icons.water_drop,
                label: 'Humidity',
                value: '$humidity%',
                color: const Color(0xFF3b82f6),
              ),
              _buildWeatherCard(
                icon: Icons.compress,
                label: 'Pressure',
                value: '${pressure.round()} hPa',
                color: const Color(0xFFf59e0b),
              ),
              _buildWeatherCard(
                icon: Icons.cloud,
                label: 'Cloud Cover',
                value: '$cloudCover%',
                color: const Color(0xFF6366f1),
              ),
              _buildWeatherCard(
                icon: Icons.grain,
                label: 'Precipitation',
                value: '${precipitation.toStringAsFixed(1)} mm',
                color: const Color(0xFF3b82f6),
              ),
              _buildWeatherCard(
                icon: Icons.explore,
                label: 'Wind Direction',
                value: '${current['wind_direction_10m']}°',
                color: const Color(0xFF10b981),
              ),
            ],
          ),

          const SizedBox(height: 20),

          // Info Card
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  const Color(0xFF10b981).withOpacity(0.1),
                  const Color(0xFF3b82f6).withOpacity(0.1),
                ],
              ),
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                color: const Color(0xFF3b82f6).withOpacity(0.3),
              ),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.check_circle,
                  color: Color(0xFF10b981),
                  size: 24,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    "Weather data from Open-Meteo •",
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.8),
                      fontSize: 13,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildWeatherCard({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.2),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [color, color.withOpacity(0.7)],
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: Colors.white,
              size: 28,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            label,
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              color: Colors.grey[900],
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    locationController.dispose();
    super.dispose();
  }
}