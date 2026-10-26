#!/bin/bash
# ==============================================================================
# VIDEO 2: SKRIP UJICOBA KLIEN NFS (CENTOS LINUX)
# Mahasiswa : M. RIDUAN (NIM: 053660074) | S1 Sistem Informasi UT Banjarmasin
# ==============================================================================

SERVER_IP="192.168.1.100"

# 1. Instalasi Utilitas Klien & Discovery Direktori Server
yum install -y nfs-utils
showmount -e ${SERVER_IP}

# 2. Pembuatan Mount Point & Mounting Sistem Berkas
mkdir -p /mnt/nfs_client
mount -t nfs ${SERVER_IP}:/data/nfs_share /mnt/nfs_client

# 3. Verifikasi Status Mounting
df -h -T /mnt/nfs_client
mount | grep nfs

# 4. Uji Coba Baca Berkas dari Server (Read Test)
ls -la /mnt/nfs_client
cat /mnt/nfs_client/uji_server.txt

# 5. Uji Coba Tulis Berkas dari Klien (Write Test)
echo "Pengujian penulisan data dari Klien NFS Berhasil - NIM 053660074" > /mnt/nfs_client/hasil_klien.txt
ls -la /mnt/nfs_client

# 6. Konfigurasi Auto-Mount saat Booting (/etc/fstab)
echo "${SERVER_IP}:/data/nfs_share /mnt/nfs_client nfs defaults,_netdev 0 0" >> /etc/fstab
tail -n 1 /etc/fstab
