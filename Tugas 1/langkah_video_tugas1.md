# Dokumentasi 10 Langkah Video Praktikum Tugas 1 — Administrasi Server (STSI4302)

- **Nama Mahasiswa:** M. RIDUAN
- **NIM:** 053660074
- **Program Studi:** S1 Sistem Informasi — UPBJJ UT Banjarmasin
- **Link Playlist YouTube:** https://www.youtube.com/playlist?list=PLUbR71hSui90

---

## Langkah 1: Login Sesi Root dan Verifikasi Antarmuka Jaringan
- **Link Video:** https://youtu.be/M2cJbBs0Rhs
- **Perintah Terminal:**
  ```bash
  su -
  whoami
  ip addr
  ```
- **Penjelasan Isi Video:**
  Persiapan awal administrasi server dengan beralih ke sesi administrator sistem (`root`) menggunakan perintah `su -` dan validasi `whoami`. Pemeriksaan status antarmuka jaringan menggunakan `ip addr` memastikan antarmuka `enp0s3` berstatus `UP` dan memperoleh alamat IP `10.0.2.50/24` melalui DHCP pada Oracle VM VirtualBox.

---

## Langkah 2: Pembuatan User Mahasiswa dan User Test
- **Link Video:** https://youtu.be/dKYALsbavAA
- **Perintah Terminal:**
  ```bash
  useradd --badname -c "M. Riduan" 053660074
  passwd 053660074
  useradd -c "User Test" usertest
  passwd usertest
  ```
- **Penjelasan Isi Video:**
  Penambahan dua entitas pengguna baru ke dalam sistem CentOS menggunakan `useradd`: akun pertama untuk identitas mahasiswa dengan nama lengkap `"M. Riduan"` dan username NIM `053660074`, serta akun kedua `usertest` beserta konfigurasi kata sandinya melalui `passwd`.

---

## Langkah 3: Verifikasi Entri Pengguna pada File `/etc/passwd`
- **Link Video:** https://youtu.be/S3ii-ZnYEPo
- **Perintah Terminal:**
  ```bash
  cat /etc/passwd | tail -n 5
  ```
- **Penjelasan Isi Video:**
  Verifikasi registrasi akun pengguna baru dengan memeriksa berkas `/etc/passwd`. Luaran terminal memperlihatkan bahwa akun `053660074` dan `usertest` telah tercatat valid dengan 7 kolom standar Linux (`username:x:UID:GID:GECOS:/home/dir:/bin/bash`).

---

## Langkah 4: Pengelolaan Group dan Pemberian Hak Akses `wheel`
- **Link Video:** https://youtu.be/FGWbacF0Qz4
- **Perintah Terminal:**
  ```bash
  usermod -aG wheel 053660074
  groups 053660074
  ```
- **Penjelasan Isi Video:**
  Pengelolaan grup dan hak akses administratif dengan menambahkan akun NIM `053660074` ke dalam grup sekunder `wheel` (`usermod -aG wheel 053660074`) agar memiliki wewenang menjalankan perintah dengan hak akses setara `root` melalui utilitas `sudo`.

---

## Langkah 5: Logout Sesi Root dan Pengujian Hak Sudo User Mahasiswa
- **Link Video:** https://youtu.be/BVjccKsvWOk
- **Perintah Terminal:**
  ```bash
  exit
  su - 053660074
  whoami
  sudo whoami
  ```
- **Penjelasan Isi Video:**
  Menutup sesi `root`, login menggunakan akun NIM `053660074`, dan menguji eskalasi privilese `sudo whoami` yang mengembalikan output `root`.

---

## Langkah 6: Manajemen Perubahan Password User dan Autentikasi Login Ulang
- **Link Video:** https://youtu.be/kOEuKXeAEH4
- **Perintah Terminal:**
  ```bash
  passwd
  exit
  su - 053660074
  ```
- **Penjelasan Isi Video:**
  Pembaruan kata sandi secara mandiri oleh pengguna `053660074` menggunakan utilitas `passwd` dan pengujian autentikasi login ulang dengan sandi baru.

---

## Langkah 7: Pemantauan Riwayat dan Aktivitas Login Menggunakan `last` dan `who`
- **Link Video:** https://youtu.be/fyDyYCQYSws
- **Perintah Terminal:**
  ```bash
  last who
  last
  who
  ```
- **Penjelasan Isi Video:**
  Audit dan pemantauan aktivitas sesi pengguna sistem menggunakan `last` (membaca `/var/log/wtmp` untuk riwayat login dan reboot) serta `who` (menampilkan sesi pengguna yang sedang aktif secara *real-time*).

---

## Langkah 8: Konfigurasi DNS Resolver pada File `/etc/resolv.conf`
- **Link Video:** https://youtu.be/6-kf7eRTnII
- **Perintah Terminal:**
  ```bash
  sudo nano /etc/resolv.conf
  # Menambahkan:
  # nameserver 208.67.222.222
  # nameserver 208.67.220.220
  cat /etc/resolv.conf
  ```
- **Penjelasan Isi Video:**
  Konfigurasi DNS resolver pada sistem CentOS dengan menyunting `/etc/resolv.conf` menggunakan hak `sudo` dan menambahkan server OpenDNS (`208.67.222.222` dan `208.67.220.220`).

---

## Langkah 9: Pengujian Query Resolusi Nama Domain Menggunakan Utilitas `dig`
- **Link Video:** https://youtu.be/LuOv0HWYzJY
- **Perintah Terminal:**
  ```bash
  dig www.ut.ac.id
  dig google.com
  ```
- **Penjelasan Isi Video:**
  Pengujian kinerja DNS resolver menggunakan utilitas `dig` terhadap domain `www.ut.ac.id` dan `google.com` yang mengembalikan status `NOERROR` beserta pemetaan `A Record` IP publik secara presisi.

---

## Langkah 10: Pengelolaan Password dan Penghapusan User Test dari Sistem
- **Link Video:** https://youtu.be/KuFv0qFdMqU
- **Perintah Terminal:**
  ```bash
  sudo passwd usertest
  sudo userdel -r usertest
  cat /etc/passwd | tail -n 5
  ```
- **Penjelasan Isi Video:**
  Pengelolaan kata sandi `usertest` dan penghapusan akun secara permanen beserta direktori kerjanya menggunakan `sudo userdel -r usertest`, dilanjutkan verifikasi akhir pada `/etc/passwd`.
