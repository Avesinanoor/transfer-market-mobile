Tugas 7
 ### Jelaskan apa itu widget tree pada Flutter dan bagaimana hubungan parent-child (induk-anak) bekerja antar widget.

Widget tree adalah struktur hierarki berbentuk pohon yang menggambarkan bagaimana widget di Flutter disusun dan saling berhubungan. Setiap aplikasi Flutter pada dasarnya adalah sebuah widget tree yang dimulai dari widget root dan bercabang ke widget child lainnya.

Hubungan parent child:
* Parent widget dapat memiliki satu atau lebih child widget
* Child widget diletakkan di dalam parent widget
* Parent bertanggung jawab mengatur layout dan posisi child
* Perubahan pada parent dapat mempengaruhi child

`menu.dart`:
```dart
return Scaffold(  // Parent utama
  appBar: AppBar(
    title: const Text(  // Text adalah child dari AppBar
      'Football News',
      style: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
    ),
    backgroundColor: Theme.of(context).colorScheme.primary,
  ),
  body: Padding(  // Padding adalah child dari Scaffold
    padding: const EdgeInsets.all(16.0),
    child: Column(  // Column adalah child dari Padding
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(  // Row adalah child dari Column
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            InfoCard(title: 'NPM', content: npm),  // 3 InfoCard adalah children dari Row
            InfoCard(title: 'Name', content: nama),
            InfoCard(title: 'Class', content: kelas),
          ],
        ),
        const SizedBox(height: 16.0),  // SizedBox adalah child dari Column
        Center(  // Center adalah child dari Column
          child: Column(  // Column nested adalah child dari Center
            children: [
              const Padding(  // Padding adalah child dari Column nested
                padding: EdgeInsets.only(top: 16.0),
                child: Text(  // Text adalah child dari Padding
                  'Selamat datang di Transfer Market',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),
                ),
              ),
              GridView.count(  // GridView adalah child dari Column nested
                primary: true,
                padding: const EdgeInsets.all(20),
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                crossAxisCount: 3,
                shrinkWrap: true,
                children: items.map((ItemHomepage item) {
                  return ItemCard(item);  // ItemCard adalah children dari GridView
                }).toList(),
              ),
            ],
          ),
        ),
      ],
    ),
  ),
);
```

InfoCard:
```dart
return Card(  // Parent
  elevation: 2.0,
  child: Container(  // Container adalah child dari Card
    width: MediaQuery.of(context).size.width / 3.5,
    padding: const EdgeInsets.all(16.0),
    child: Column(  // Column adalah child dari Container
      children: [
        Text(  // Text pertama adalah child dari Column
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8.0),  // SizedBox adalah child dari Column
        Text(content),  // Text kedua adalah child dari Column
      ],
    ),
  ),
);
```

ItemCard:
```dart
return Material(  // Parent
  color: item.color,
  borderRadius: BorderRadius.circular(12),
  child: InkWell(  // InkWell adalah child dari Material
    onTap: () {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(content: Text("Kamu telah menekan tombol ${item.name}!"))
        );
    },
    child: Container(  // Container adalah child dari InkWell
      padding: const EdgeInsets.all(8),
      child: Center(  // Center adalah child dari Container
        child: Column(  // Column adalah child dari Center
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(  // Icon adalah child dari Column
              item.icon,
              color: Colors.white,
              size: 30.0,
            ),
            const Padding(padding: EdgeInsets.all(3)),  // Padding adalah child dari Column
            Text(  // Text adalah child dari Column
              item.name,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    ),
  ),
);
```

Setiap widget dapat mengakses informasi parent melalui BuildContext, dan parent dapat mengirimkan data ke child melalui constructor atau parameter.

 ### Sebutkan semua widget yang kamu gunakan dalam proyek ini dan jelaskan fungsinya.
 #### File: `main.dart`
- MaterialApp

Root aplikasi, mengatur tema dan routing

- ThemeData

Mendefinisikan tema aplikasi (warna, font, dll)

- ColorScheme

Mengatur skema warna aplikasi
#### File: menu.dart

- Scaffold

Struktur dasar halaman (AppBar + Body)

- AppBar

Bar di bagian atas halaman

- Text

Menampilkan teks

- TextStyle

Mengatur style teks (warna, tebal, ukuran)

- Padding

Memberikan jarak/ruang di sekitar widget
- Column

Menyusun widget secara vertikal
- Row

Menyusun widget secara horizontal

- SizedBox

Membuat jarak atau kotak dengan ukuran tertentu

- Center

Menempatkan widget di tengah

- GridView.count

Menampilkan widget dalam bentuk grid
- Card

Membuat kartu dengan bayangan (elevation)
- Container

Widget serbaguna untuk layout dan styling
- Material

Memberikan efek visual material design
- InkWell

Area yang bisa diklik dengan efek ripple
- Icon

Menampilkan ikon
- SnackBar

Menampilkan pesan singkat di bawah layar
- MediaQuery

Mengambil informasi ukuran layar
- Theme

Mengakses tema aplikasi

- ScaffoldMessenger

Mengelola tampilan SnackBar

#### Custom Widgets:
- MyApp

Widget root aplikasi
- MyHomePage

Halaman utama aplikasi
- InfoCard

Widget custom untuk kartu informasi (NPM, Name, Class)
- ItemCard

Widget custom untuk tombol interaktif berwarna

 ### Apa fungsi dari widget MaterialApp? Jelaskan mengapa widget ini sering digunakan sebagai widget root.

MaterialApp adalah widget yang menyediakan struktur dasar aplikasi dengan Material Design. Widget ini berfungsi sebagai pembungkus aplikasi yang menyediakan berbagai konfigurasi penting.

Fungsi utama MaterialApp:
* Mengatur tema aplikasi (warna, font, brightness)
* Menyediakan sistem navigasi dan routing
* Mengatur title aplikasi yang muncul di task manager
* Menyediakan localizations untuk internasionalisasi
* Mengatur widget home sebagai halaman awal
* Menyediakan Navigator untuk perpindahan halaman
* Menyediakan MediaQuery untuk responsive design

MaterialApp sering digunakan sebagai widget root karena:
* Menyediakan foundational services yang dibutuhkan hampir semua aplikasi Flutter
* Mengimplementasikan Material Design guidelines dari Google secara otomatis
* Menyediakan widget penting seperti Scaffold, AppBar, SnackBar yang konsisten
* Memudahkan setup tema global yang berlaku ke seluruh aplikasi
* Mengelola navigasi antar halaman dengan mudah

Contoh di `main.dart`:
```dart
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',  // Judul aplikasi
      theme: ThemeData(  // Tema global
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue)
          .copyWith(secondary: Colors.blueAccent[400]),
      ),
      home: MyHomePage(),  // Halaman pertama yang ditampilkan
    );
  }
}
```

Tanpa MaterialApp, kita tidak bisa menggunakan widget Material Design seperti Scaffold, AppBar, atau Theme.of(context) yang digunakan di MyHomePage.

 ### Jelaskan perbedaan antara StatelessWidget dan StatefulWidget. Kapan kamu memilih salah satunya?

- StatelessWidget adalah widget yang tidak memiliki state yang bisa berubah. Sekali dibangun, tampilan widget ini tidak akan berubah kecuali rebuild parent widget.

- StatefulWidget adalah widget yang memiliki state yang bisa berubah . Widget ini bisa merespons perubahan data dan memperbarui tampilannya.

Perbedaan utama:

**StatelessWidget:**
* Tidak memiliki state internal yang bisa berubah
* Hanya rebuild ketika parent rebuild
* Lebih ringan dan efisien
* Immutable (tidak bisa diubah)
* Hanya memiliki method build()

**StatefulWidget:**
* Memiliki state internal yang bisa berubah
* Bisa rebuild sendiri dengan setState()
* Sedikit lebih berat karena perlu manage state
* Mutable (bisa diubah)
* Memiliki createState() yang mengembalikan State object

Contoh:
```dart
class MyHomePage extends StatelessWidget {
  MyHomePage({super.key});
  final String nama = "Daffa Abhinaya Avesinanoor";
  final String npm = "2406405720";
  final String kelas = "C";
  
  // Data ini tetap dan tidak berubah
  final List<ItemHomepage> items = [
    ItemHomepage("All Players", Icons.list_alt, Colors.blue),
    ItemHomepage("My Players", Icons.group, Colors.green),
    ItemHomepage("Register Player", Icons.person_add, Colors.red),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(...);  // UI tidak berubah
  }
}
```

```dart
class InfoCard extends StatelessWidget {
  final String title;
  final String content;
  
  const InfoCard({super.key, required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Card(...);  // Hanya menampilkan data, tidak ada perubahan
  }
}
```

Kapan memilih StatelessWidget:
* Untuk tampilan yang static (tidak berubah)
* Untuk widget yang hanya menampilkan data
* Untuk widget yang hanya merespons input dari parent
* Contoh: Text, Icon, InfoCard, ItemCard

Kapan memilih StatefulWidget:
* Untuk form dengan input user (TextField yang berubah)
* Untuk widget dengan animasi
* Untuk widget yang perlu update data secara dinamis (counter, list yang bertambah/berkurang)
* Untuk widget yang merespons user interaction dan mengubah tampilannya
* Contoh: halaman dengan checkbox, counter, form input, timer

Dalam tugas ini, semua widget menggunakan StatelessWidget karena hanya menampilkan data static. Tidak ada form input atau data yang berubah secara dinamis. SnackBar yang muncul saat tombol diklik tidak memerlukan StatefulWidget karena dikelola oleh ScaffoldMessenger, bukan state internal widget.

 ### Apa itu BuildContext dan mengapa penting di Flutter? Bagaimana penggunaannya di metode build?

BuildContext adalah object yang berisi informasi tentang lokasi widget dalam widget tree. Setiap widget memiliki BuildContext sendiri yang merepresentasikan posisinya dalam hierarki widget.

BuildContext penting karena:
* Menyediakan akses ke widget parent di atas tree
* Memungkinkan widget mengakses inherited widgets (seperti Theme, MediaQuery)
* Diperlukan untuk navigasi antar halaman
* Digunakan untuk menampilkan dialog, SnackBar, dan bottom sheet
* Memungkinkan widget mendapatkan ukuran layar dan informasi device

Penggunaan BuildContext di method build:

**1. Mengakses Theme:**
```dart
appBar: AppBar(
  backgroundColor: Theme.of(context).colorScheme.primary,
  // context digunakan untuk mengambil warna primary dari tema
),
```

**2. Mengakses MediaQuery untuk ukuran layar:**
```dart
Container(
  width: MediaQuery.of(context).size.width / 3.5,
  // context digunakan untuk mendapatkan lebar layar device
  padding: const EdgeInsets.all(16.0),
  child: Column(...),
)
```

**3. Menampilkan SnackBar:**
```dart
InkWell(
  onTap: () {
    ScaffoldMessenger.of(context)  // Mengakses ScaffoldMessenger terdekat
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(content: Text("Kamu telah menekan tombol ${item.name}!"))
      );
  },
  child: Container(...),
)
```

Cara kerja BuildContext:
* Setiap widget otomatis menerima BuildContext dalam method build()
* BuildContext mencari widget parent dengan method `.of(context)`
* Method `.of(context)` akan mencari ke atas widget tree sampai menemukan widget yang dicari
* Jika tidak ditemukan, akan terjadi error

Contoh:
```dart
@override
Widget build(BuildContext context) {  // context adalah parameter method build
  return Scaffold(
    appBar: AppBar(
      backgroundColor: Theme.of(context).colorScheme.primary,
      // Theme.of(context) mencari ThemeData terdekat di widget tree
    ),
    body: Padding(
      child: Column(
        children: [
          Row(
            children: [
              InfoCard(title: 'NPM', content: npm),
              // InfoCard juga akan menerima context sendiri
            ],
          ),
        ],
      ),
    ),
  );
}
```

Setiap kali widget memanggil method yang memerlukan context (seperti Theme.of, MediaQuery.of, ScaffoldMessenger.of), Flutter akan mencari widget yang sesuai di atas tree dan mengambil datanya. Tanpa BuildContext, widget tidak bisa berkomunikasi dengan widget lain di tree.

 ### Jelaskan konsep "hot reload" di Flutter dan bagaimana bedanya dengan "hot restart".

Hot Reload dan Hot Restart adalah fitur Flutter yang mempercepat development dengan memungkinkan developer melihat perubahan kode tanpa harus restart aplikasi sepenuhnya.

**Hot Reload:**
* Memuat ulang kode yang diubah tanpa menghilangkan state aplikasi
* Sangat cepat (biasanya kurang dari 1 detik)
* Mempertahankan data dan posisi di aplikasi
* Hanya memperbarui tampilan yang berubah
* Digunakan untuk perubahan UI dan logic sederhana
* Shortcut: tekan `r` di terminal atau tombol hot reload di IDE

**Hot Restart:**
* Restart aplikasi dari awal dan menghilangkan semua state
* Lebih lambat dari hot reload (beberapa detik)
* Menghapus semua data dan state yang tersimpan
* Membangun ulang seluruh widget tree dari awal
* Digunakan untuk perubahan yang mempengaruhi main() atau initState()
* Shortcut: tekan `R` (huruf kapital) di terminal atau tombol hot restart di IDE


Contoh:

**Kapan menggunakan Hot Reload:**
```dart
// Mengubah warna tombol
ItemHomepage("All Players", Icons.list_alt, Colors.blue),
// Diubah menjadi
ItemHomepage("All Players", Icons.list_alt, Colors.purple),
// Hot reload akan langsung menampilkan warna baru

// Mengubah text
title: const Text('Football News'),
// Diubah menjadi
title: const Text('Transfer Market'),
// Hot reload akan langsung menampilkan text baru

// Mengubah icon
ItemHomepage("My Players", Icons.group, Colors.green),
// Diubah menjadi
ItemHomepage("My Players", Icons.people, Colors.green),
// Hot reload akan langsung menampilkan icon baru
```

**Kapan harus menggunakan Hot Restart:**
```dart
// Mengubah data di constructor atau variable class level
final String nama = "Daffa Abhinaya Avesinanoor";
// Diubah menjadi
final String nama = "John Doe";
// Perlu hot restart agar perubahan terlihat

// Menambah atau menghapus item di list yang dibuat saat initialization
final List<ItemHomepage> items = [
  ItemHomepage("All Players", Icons.list_alt, Colors.blue),
  ItemHomepage("My Players", Icons.group, Colors.green),
];
// Hot restart diperlukan

// Mengubah fungsi main()
void main() {
  runApp(const MyApp());
}
// Perlu hot restart
```


Jika  mengubah warna background AppBar dari `Theme.of(context).colorScheme.primary` menjadi `Colors.red`, hot reload sudah cukup. Namun jika kita mengubah nilai `npm` atau `nama` di MyHomePage, kita perlu hot restart karena nilai tersebut di set saat object dibuat.


<details>
<summary>Tugas 8</summary>
  
### Jelaskan perbedaan antara Navigator.push() dan Navigator.pushReplacement() pada Flutter. Dalam kasus apa sebaiknya masing-masing digunakan pada aplikasi Football Shop kamu?
Perbedaan Inti

#### Navigator.push()
- Menambahkan (menumpuk) route baru di atas stack.
- Tombol back akan kembali ke halaman sebelumnya.
- Cocok untuk navigasi alur (detail/form).

#### Navigator.pushReplacement()
- Mengganti route saat ini dengan route baru (hapus halaman sekarang).
- Tombol back tidak kembali ke halaman yang diganti; kembali ke route di bawahnya (jika ada).
- Cocok untuk berpindah “top‑level” tanpa menumpuk riwayat yang tidak perlu.
Penggunaan di Aplikasi Ini

- Tombol/Item “Register Player” dari home = gunakan push()

Alasan: pengguna biasanya ingin bisa kembali ke Beranda lewat tombol back setelah mengisi/menutup form.
```dart
            if (item.name == 'Register Player') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AddProductPage()),
            );
```
- Drawer "Register Player" = gunakan pushReplacement

Item drawer umumnya diperlakukan sebagai tujuan top‑level; mengganti halaman saat ini mencegah stack menumpuk (berpindah section
```dart
          ListTile(
            leading: const Icon(Icons.add_circle),
            title: const Text('Register Player'),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushReplacementNamed('/add');
            },
          ),
```


### Bagaimana memanfaatkan hierarchy widget seperti Scaffold, AppBar, dan Drawer untuk membangun struktur halaman yang konsisten di seluruh aplikasi?
Scaffold adalah kerangka utama setiap halaman yang memberi slot konsisten untuk AppBar, Drawer, dan body. Dengan menempatkan AppBar dan Drawer yang seragam pada semua halaman, Anda menjaga tampilan, pola navigasi, dan perilaku aplikasi tetap konsisten. AppBar digunakan untuk judul dan aksi global (mis. search atau save) yang distandarkan melalui Theme, sedangkan Drawer menjadi pintu menuju destinasi top-level (seperti Halaman Utama dan Tambah Produk). Konten spesifik halaman hidup di body. Untuk menghindari overflow, bungkus body dengan SafeArea dan SingleChildScrollView saat konten bisa memanjang, dan atur widget scrollable turunan seperti GridView agar tidak menguasai tinggi tanpa batas. Pusatkan rute di MaterialApp (named routes) agar navigasi Drawer dan tombol-tombol halaman mudah dipelihara.

- Gunakan satu Drawer reusable di semua halaman: pasang di setiap Scaffold via drawer: const AppDrawer().
- Standarisasi AppBar: judul dan warna dari Theme; aksi hanya yang relevan per halaman.
- Wrapper AppScaffold (menerima title dan body) untuk menghindari duplikasi AppBar/Drawer.

### Dalam konteks desain antarmuka, apa kelebihan menggunakan layout widget seperti Padding, SingleChildScrollView, dan ListView saat menampilkan elemen-elemen form? Berikan contoh penggunaannya dari aplikasi kamu.

- Menggunakan layout widget seperti Padding, SingleChildScrollView, dan ListView membuat form lebih nyaman dipakai, adaptif, dan bebas error layout.

#### Padding
- Kelebihan: memberi ruang napas antar elemen, meningkatkan keterbacaan dan akurasi tap; menjaga ritme visual yang konsisten.
- Contoh: membungkus body beranda dengan Padding sehingga konten tidak menempel tepi layar 
```dart
                const Padding(padding: EdgeInsets.all(3)),
                Text(
                  item.name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white),
                ),
```
#### SingleChildScrollView

- Kelebihan: mencegah “bottom overflow” saat konten melebihi tinggi layar atau ketika keyboard muncul; cocok untuk form dengan jumlah field sedang.
- Contoh:
Halaman form membungkus seluruh Form dengan scroll agar aman dari overflow
```dart
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
            ...
        )
```

#### ListView
- Kelebihan: list yang panjang/berulang dengan performa baik (item builder, lazy rendering), separator mudah, dan integrasi dengan sliver; lebih cocok daripada Column untuk form yang sangat panjang atau dinamis.
Contoh:
```dart
          child: ListView(
            padding: const EdgeInsets.all(16.0),
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                ),
                ...
          )  
```
### Bagaimana menyesuaikan warna tema agar aplikasi Football Shop memiliki identitas visual yang konsisten dengan brand toko?
Agar identitas brand konsisten, pusatkan semua warna di Theme, lalu pastikan widget mengambil warna dari Theme. Buat satu sumber warna (ThemeData/ColorScheme), terapkan ke AppBar, tombol, input, dan komponen lain sehingga gaya menyatu di seluruh halaman.
```dart
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue)
        .copyWith(secondary: Colors.blueAccent[400]), 
```
</details>
