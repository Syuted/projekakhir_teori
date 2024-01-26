import 'package:flutter/material.dart';
import 'package:projekakhir_teori/login.dart';
import 'package:projekakhir_teori/stasiun_list.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: IndexedStack(
          index: _currentIndex,
          children: [
            // Konten untuk Stasiun (Index 0)
            const StationList(),
            // Konten untuk Mata Uang (Index 1)
            CurrencyConverterScreen(),
            // Konten untuk Waktu (Index 2)
            TimeConverterScreen(),
            // Konten untuk Profil (Index 3)
            ProfileBody(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          if (index == 4) {
          } else {
            setState(() {
              _currentIndex = index;
            });
          }
        },
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.train),
              label: 'Stasiun',
              backgroundColor: Colors.black),
          BottomNavigationBarItem(
            icon: Icon(Icons.monetization_on),
            label: 'Mata Uang',
            backgroundColor: Colors.black,
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.access_time),
              label: 'Waktu',
              backgroundColor: Colors.black),
          BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profil',
              backgroundColor: Colors.black),

        ],
      ),
    );
  }

}

class CurrencyConverterScreen extends StatefulWidget {
  @override
  _CurrencyConverterScreenState createState() =>
      _CurrencyConverterScreenState();
}

class _CurrencyConverterScreenState extends State<CurrencyConverterScreen> {
  double idrAmount = 0.0;
  double usdAmount = 0.0;
  double eurAmount = 0.0;
  double jpyAmount = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Konversi Mata Uang'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              decoration: const InputDecoration(labelText: 'IDR'),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  idrAmount = double.tryParse(value) ?? 0.0;
                  usdAmount = idrAmount /
                      15000; // Ganti nilai konversi sesuai kebutuhan
                  eurAmount = idrAmount /
                      17000; // Ganti nilai konversi sesuai kebutuhan
                  jpyAmount =
                      idrAmount / 140; // Ganti nilai konversi sesuai kebutuhan
                });
              },
            ),
            const SizedBox(height: 20),
            const Text('Hasil Konversi:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Text('USD: ${usdAmount.toStringAsFixed(2)}'),
            Text('EUR: ${eurAmount.toStringAsFixed(2)}'),
            Text('JPY: ${jpyAmount.toStringAsFixed(2)}'),
          ],
        ),
      ),
    );
  }
}

class TimeConverterScreen extends StatefulWidget {
  @override
  _TimeConverterScreenState createState() => _TimeConverterScreenState();
}

class _TimeConverterScreenState extends State<TimeConverterScreen> {
  DateTime _selectedTime = DateTime.now();
  String _wibTime = '';
  String _witTime = '';
  String _witaTime = '';
  String _londonTime = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Konversi Waktu'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Pilih Waktu:'),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                _selectTime(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
              ),
              child: const Text('Pilih Waktu'),
            ),
            const SizedBox(height: 20),
            Text('Waktu Terpilih: $_selectedTime'),
            const SizedBox(height: 20),
            const Text('Hasil Konversi:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Text('WIB: $_wibTime'),
            Text('WIT: $_witTime'),
            Text('WITA: $_witaTime'),
            Text('London: $_londonTime'),
          ],
        ),
      ),
    );
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(_selectedTime),
    );

    if (pickedTime != null) {
      setState(() {
        _selectedTime = DateTime(
          _selectedTime.year,
          _selectedTime.month,
          _selectedTime.day,
          pickedTime.hour,
          pickedTime.minute,
        );

        // Perform time zone conversions here
        _wibTime = _convertToTimeZone(_selectedTime, 7); // WIB: UTC+7
        _witTime = _convertToTimeZone(_selectedTime, 9); // WIT: UTC+9
        _witaTime = _convertToTimeZone(_selectedTime, 8); // WITA: UTC+8
        _londonTime = _convertToTimeZone(_selectedTime, 0); // London: UTC+0
      });
    }
  }

  String _convertToTimeZone(DateTime dateTime, int timeZoneOffset) {
    final convertedTime = dateTime.toUtc().add(Duration(hours: timeZoneOffset));
    return convertedTime.toString();
  }
}

class ProfileBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'feedback') {
                _navigateToFeedbackScreen(context);
              } else if (value == 'logout') {
                _logOut(context);
              }
            },
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem<String>(
                  value: 'feedback',
                  child: const Text('Pesan dan Kesan'),
                ),
                PopupMenuItem<String>(
                  value: 'logout',
                  child: const Text('Log Out'),
                ),
              ];
            },
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            _buildProfileImageWithBorder(),
            const SizedBox(height: 16),
            const Text(
              'Data Diri',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Divider(
              color: Colors.black,
              height: 20,
              thickness: 2,
            ),
            const SizedBox(height: 10),
            _buildProfileInfo('Nama', 'Tedi Raharja'),
            _buildProfileInfo('NIM', '124210080'),
            _buildProfileInfo(
                'Tempat/Tanggal Lahir', 'Probolinggo, 14 Januari 2001'),
            _buildProfileInfo('Hobi', 'Olahraga'),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileImageWithBorder() {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.black,
          width: 4,
        ),
      ),
      child: CircleAvatar(
        radius: 70,
        backgroundImage: AssetImage('assets/img/suted.jpg'),
      ),
    );
  }

  Widget _buildProfileInfo(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(fontSize: 14),
        ),
        const SizedBox(height: 10),
      ],
    );
  }

  void _navigateToFeedbackScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => FeedbackScreen()),
    );
  }

  void _logOut(BuildContext context) {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => LoginPage()));
    // Add additional log out logic here if needed
  }
}

// Buatlah widget FeedbackScreen untuk menampilkan halaman "Pesan dan Kesan"
class FeedbackScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pesan dan Kesan'),
        backgroundColor: Colors.black, // Ubah warna latar belakang AppBar
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    const Text(
                      'Pesan',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Goodddd lahhhh',
                      style: TextStyle(fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Kesan',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'The best lahhh',
                      style: TextStyle(fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: HomeScreen(),
  ));
}



