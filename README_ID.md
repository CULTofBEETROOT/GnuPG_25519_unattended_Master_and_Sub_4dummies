# Generator Kunci Utama dan Sub Kunci GPG Tanpa Pengawasan
# & Pemformat Dongle USB-LUKS (penyimpanan kunci gpg).

Gambaran Umum
Repositori ini menyediakan serangkaian skrip untuk menghasilkan kunci utama dan sub kunci GPG menggunakan kunci USB dengan enkripsi LUKS. Skrip dirancang untuk pengguna non-root tetapi memerlukan akses root untuk operasi tertentu. Pengaturan ini disesuaikan untuk Debian Trixie dan ditujukan untuk pengguna yang mungkin bekerja pada perangkat keras lama tanpa akses internet selama proses berlangsung.

Catatan Penting
* Urutan Eksekusi: Skrip harus dijalankan dalam urutan yang ditentukan: PERTAMA, KEDUA, dan KETIGA. Jangan lewati langkah apa pun, bahkan jika suatu langkah gagal.

* Lingkungan: Pastikan Anda memiliki file yang diperlukan:

FIRST.sh

SECOND.sh

THIRD.sh

(opsional: batchproduction_ofTHIRD.sh)

...di direktori Unduhan Anda sebelum memulai.

# UNTUK PRODUKSI BATCH (lebih baik!)

* Jika Anda memiliki beberapa alamat email yang ingin Anda buat kunci GPG-nya, jalankan perintah berikut sebagai pengguna root atau dengan sudo:

```bash
sudo bash /home/$USER/Downloads/FIRST.sh;
sudo bash /home/$USER/Downloads/SECOND.sh;
```

* Buat dua file:

satu dengan kolom pemilik,

yang kedua dengan kolom alamat email,

dan masukkan argumen ke dalamnya dengan pola berikut:

```bash
/home/$USER/Downloads/batchproduction_ofTHIRD.sh <path/to/and/ownerfile.txt> <path/to/and/addressfile.txt>;
```

Skrip terakhir ini memungkinkan Anda untuk memasukkan daftar email dan pemiliknya masing-masing, menghasilkan skrip bash individual untuk setiap alamat email.

* Saat Anda menjalankan skrip individual yang dihasilkan, skrip tersebut akan membuat kunci GPG yang disimpan pada kunci USB terenkripsi LUKS Anda. Penting: OpenGPG merekomendasikan agar Anda segera menggunakan dan kemudian menghapus kunci pribadi yang tidak terenkripsi sendiri untuk menghindari penyimpanan informasi sensitif.

# ATAU PILIH PRODUKSI KUNCI TUNGGAL (intuitif).

Langkah-langkah yang Harus Diikuti

Langkah 1: Jalankan Skrip Pertama

1. Buka terminal.

2. Jalankan perintah berikut sebagai pengguna root atau dengan sudo:

```bash
 bash /home/$USER/Downloads/FIRST.sh
```

Langkah 2: Buat Kunci USB dengan LUKS
1. Mulai langkah ini dalam mode root:

```bash
 bash /home/$USER/Downloads/SECOND.sh
```

Langkah 3: Simpan Kunci Utama dan Subkunci GPG pada Perangkat USB

1. Mulai langkah ini dalam mode root. Anda mungkin perlu mengubah izin skrip agar dapat dieksekusi.

Gunakan perintah berikut:

```bash
 chmod +x /home/$USER/Downloads/THIRD.sh
```

2. Kemudian, jalankan skrip:

```bash
 /home/$USER/Downloads/THIRD.sh
```

Langkah Terakhir: Lepaskan Perangkat USB dengan Aman

Setelah berhasil menyelesaikan semua langkah, pastikan Anda melepaskan perangkat USB LUKS Anda dengan aman untuk mencegah potensi masalah saat menyambungkannya kembali:

```bash
sudo umount "/mnt/usb_gpg"
sudo cryptsetup luksClose myusb_key
```

atau lain kali Anda mencolokkan perangkat Anda, Anda berpotensi mengalami kesulitan.

Kesimpulan

Dengan mengikuti langkah-langkah ini, Anda dapat dengan aman membuat dan menyimpan Kunci Utama dan subkunci GPG Anda pada kunci USB terenkripsi LUKS. Selalu ingat untuk menangani kunci pribadi Anda dengan hati-hati dan ikuti praktik terbaik untuk keamanan. Jika Anda memiliki pertanyaan atau masalah, silakan merujuk ke dokumentasi atau mintalah bantuan dari komunitas.
