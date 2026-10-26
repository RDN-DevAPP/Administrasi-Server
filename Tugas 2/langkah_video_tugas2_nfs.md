# Dokumentasi Langkah Video Praktikum Tugas 2 — Administrasi Server (STSI4302)
## Instalasi & Ujicoba Network File System (NFS Server & Client)

- **Nama Mahasiswa:** M. RIDUAN
- **NIM:** 053660074
- **Program Studi:** S1 Sistem Informasi — UPBJJ UT Banjarmasin
- **Link Playlist YouTube:** https://www.youtube.com/playlist?list=PLUbR71hSui90

---

## Video 1: Proses Instalasi dan Konfigurasi NFS-SERVER
- **Link Video:** https://youtu.be/M2cJbBs0Rhs

### Tahapan Praktikum di Video 1:
1. **Verifikasi Sesi Root dan Alamat IP Server:**
   ```bash
   su -
   whoami
   ip addr
   ```
2. **Instalasi Paket Utama `nfs-utils` dan `rpcbind`:**
   ```bash
   yum install -y nfs-utils rpcbind
   ```
3. **Pembuatan Direktori Penyimpanan Bersama & Pengaturan Hak Akses:**
   ```bash
   mkdir -p /data/nfs_share
   chmod -R 777 /data/nfs_share
   chown -R nfsnobody:nfsnobody /data/nfs_share
   echo "Uji Coba Berbagi Berkas NFS Server - M. RIDUAN 053660074" > /data/nfs_share/uji_server.txt
   ```
4. **Konfigurasi Aturan Ekspor pada `/etc/exports`:**
   ```bash
   echo "/data/nfs_share *(rw,sync,no_root_squash,no_subtree_check)" > /etc/exports
   cat /etc/exports
   ```
5. **Pengaktifan Layanan Sistem, Firewall, & Tabel Ekspor Kernel:**
   ```bash
   systemctl enable --now rpcbind
   systemctl enable --now nfs-server
   systemctl status nfs-server
   firewall-cmd --permanent --add-service=nfs
   firewall-cmd --permanent --add-service=rpc-bind
   firewall-cmd --permanent --add-service=mountd
   firewall-cmd --reload
   exportfs -arv
   exportfs -v
   ```

---

## Video 2: Proses Ujicoba Klien NFS
- **Link Video:** https://youtu.be/h6VS4TNEzYw

### Tahapan Praktikum di Video 2:
1. **Instalasi Utilitas Klien NFS & Pemindaian Direktori Ekspor Server:**
   ```bash
   yum install -y nfs-utils
   showmount -e 192.168.1.100
   ```
2. **Pembuatan Titik Kait (Mount Point) & Mounting Partisi NFS:**
   ```bash
   mkdir -p /mnt/nfs_client
   mount -t nfs 192.168.1.100:/data/nfs_share /mnt/nfs_client
   ```
3. **Verifikasi Status Penautan Sistem Berkas:**
   ```bash
   df -h -T /mnt/nfs_client
   mount | grep nfs
   ```
4. **Uji Baca (*Read Test*) & Uji Tulis (*Write Test*) Dua Arah:**
   ```bash
   ls -la /mnt/nfs_client
   cat /mnt/nfs_client/uji_server.txt
   echo "Pengujian penulisan data dari Klien NFS Berhasil - NIM 053660074" > /mnt/nfs_client/hasil_klien.txt
   ls -la /mnt/nfs_client
   ```
5. **Konfigurasi Persistensi Auto-Mount saat Booting pada `/etc/fstab`:**
   ```bash
   echo "192.168.1.100:/data/nfs_share /mnt/nfs_client nfs defaults,_netdev 0 0" >> /etc/fstab
   tail -n 1 /etc/fstab
   ```
