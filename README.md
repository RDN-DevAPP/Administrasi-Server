# Administrasi-Server

**Dokumentasi Langkah-Langkah Video Praktikum & Skrip Perintah Linux CentOS**  
**Mata Kuliah:** Administrasi Server (`STSI4302` / `MSIM4308`)  
**Nama Mahasiswa:** M. RIDUAN  
**NIM:** 053660074  
**Program Studi:** S1 Sistem Informasi — Fakultas Sains dan Teknologi (FST)  
**UPBJJ-UT:** Banjarmasin — Universitas Terbuka  

---

## 📂 Daftar Isi Repositori

1. **[Tugas 1 (Aktivitas Belajar 4): Manajemen User, Group, Hak Akses Sudo (`wheel`), Audit Login, & DNS Resolver](./Tugas%201/langkah_video_tugas1.md)**
   - [Skrip Bash Perintah Praktikum Tugas 1 (`perintah_praktikum_tugas1.sh`)](./Tugas%201/perintah_praktikum_tugas1.sh)
2. **[Tugas 2 (Aktivitas Belajar 8): Instalasi & Ujicoba Network File System (NFS Server & Client)](./Tugas%202/langkah_video_tugas2_nfs.md)**
   - [Skrip Bash Konfigurasi NFS Server (`nfs_server_setup.sh`)](./Tugas%202/nfs_server_setup.sh)
   - [Skrip Bash Ujicoba NFS Client (`nfs_client_test.sh`)](./Tugas%202/nfs_client_test.sh)

---

## 🎬 Ringkasan Tahapan Video Praktikum

### Bagian I — Tugas 1 (Aktivitas Belajar 4): 10 Langkah Video Administrasi Sistem & DNS
- **Playlist YouTube:** [Playlist Praktikum Administrasi Server](https://www.youtube.com/playlist?list=PLUbR71hSui90)

| Langkah | Topik Video Praktikum | Perintah Utama Linux CentOS | Tautan Video |
| :---: | :--- | :--- | :---: |
| **Langkah 1** | Login Sesi Root dan Verifikasi Antarmuka Jaringan | `su -`, `whoami`, `ip addr` | [Tonton Video](https://youtu.be/M2cJbBs0Rhs) |
| **Langkah 2** | Pembuatan User Mahasiswa (`053660074`) dan `usertest` | `useradd -c "M. Riduan" 053660074`, `passwd` | [Tonton Video](https://youtu.be/dKYALsbavAA) |
| **Langkah 3** | Verifikasi Entri Pengguna pada File `/etc/passwd` | `cat /etc/passwd \| tail -n 5` | [Tonton Video](https://youtu.be/S3ii-ZnYEPo) |
| **Langkah 4** | Pengelolaan Group dan Pemberian Hak Akses `wheel` | `usermod -aG wheel 053660074`, `groups` | [Tonton Video](https://youtu.be/FGWbacF0Qz4) |
| **Langkah 5** | Logout Sesi Root dan Pengujian Hak `sudo` Mahasiswa | `exit`, `su - 053660074`, `sudo whoami` | [Tonton Video](https://youtu.be/BVjccKsvWOk) |
| **Langkah 6** | Manajemen Perubahan Password User & Autentikasi Ulang | `passwd`, `su - 053660074` | [Tonton Video](https://youtu.be/kOEuKXeAEH4) |
| **Langkah 7** | Pemantauan Riwayat dan Aktivitas Login (`last` & `who`) | `last who`, `last`, `who` | [Tonton Video](https://youtu.be/fyDyYCQYSws) |
| **Langkah 8** | Konfigurasi DNS Resolver pada File `/etc/resolv.conf` | `sudo nano /etc/resolv.conf`, `cat /etc/resolv.conf` | [Tonton Video](https://youtu.be/6-kf7eRTnII) |
| **Langkah 9** | Pengujian Query Resolusi Nama Domain dengan `dig` | `dig www.ut.ac.id`, `dig google.com` | [Tonton Video](https://youtu.be/LuOv0HWYzJY) |
| **Langkah 10** | Pengelolaan Password & Penghapusan `usertest` | `sudo passwd usertest`, `sudo userdel -r usertest` | [Tonton Video](https://youtu.be/KuFv0qFdMqU) |

---

### Bagian II — Tugas 2 (Aktivitas Belajar 8): 2 Video Instalasi & Ujicoba NFS (Network File System)

#### 1. Video 1: Proses Instalasi dan Konfigurasi NFS-SERVER
- **Tautan Video:** [https://youtu.be/M2cJbBs0Rhs](https://youtu.be/M2cJbBs0Rhs)
- **Tahapan Praktikum di Video:**
  1. Verifikasi hak akses superuser (`su -`, `whoami`) dan pemeriksaan alamat IP server (`ip addr`).
  2. Instalasi paket layanan NFS dan RPCBind: `yum install -y nfs-utils rpcbind`.
  3. Pembuatan direktori berbagi `/data/nfs_share` serta pengaturan izin akses `chmod -R 777 /data/nfs_share` dan `chown -R nfsnobody:nfsnobody /data/nfs_share`.
  4. Konfigurasi aturan ekspor pada `/etc/exports`:
     ```text
     /data/nfs_share *(rw,sync,no_root_squash,no_subtree_check)
     ```
  5. Pengaktifan service (`systemctl enable --now rpcbind nfs-server`), pembukaan layanan pada firewall (`firewall-cmd --permanent --add-service={nfs,rpc-bind,mountd}` & `firewall-cmd --reload`), serta penerapan tabel ekspor (`exportfs -arv` dan `exportfs -v`).

#### 2. Video 2: Proses Ujicoba Klien NFS
- **Tautan Video:** [https://youtu.be/h6VS4TNEzYw](https://youtu.be/h6VS4TNEzYw)
- **Tahapan Praktikum di Video:**
  1. Instalasi utilitas klien (`yum install -y nfs-utils`) dan pemindaian direktori ekspor server (`showmount -e <IP_SERVER>`).
  2. Pembuatan direktori titik kait (`mkdir -p /mnt/nfs_client`) dan penautan sistem berkas jaringan (`mount -t nfs <IP_SERVER>:/data/nfs_share /mnt/nfs_client`).
  3. Verifikasi tabel partisi aktif (`df -h -T /mnt/nfs_client` dan `mount | grep nfs`).
  4. Uji baca berkas dari server (*Read Test*) dan uji tulis berkas baru dari klien (*Write Test*) untuk memvalidasi sinkronisasi dua arah secara *real-time*.
  5. Konfigurasi persistensi *auto-mount* saat *booting* pada berkas `/etc/fstab` dengan opsi `_netdev`.
