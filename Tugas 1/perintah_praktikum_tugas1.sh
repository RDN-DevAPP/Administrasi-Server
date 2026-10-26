#!/bin/bash
# ==============================================================================
# SKRIP PERINTAH PRAKTIKUM TUGAS 1 - ADMINISTRASI SERVER (STSI4302)
# Mahasiswa : M. RIDUAN (NIM: 053660074) | S1 Sistem Informasi UT Banjarmasin
# Topik     : Manajemen User, Group, Sudo (Wheel), Audit Login, & DNS Resolver
# ==============================================================================

# Langkah 1: Verifikasi Root dan Antarmuka Jaringan
whoami
ip addr

# Langkah 2: Pembuatan User Mahasiswa (053660074) dan User Test
useradd --badname -c "M. Riduan" 053660074
# passwd 053660074
useradd -c "User Test" usertest
# passwd usertest

# Langkah 3: Verifikasi Entri Pengguna pada /etc/passwd
cat /etc/passwd | tail -n 5

# Langkah 4: Pengelolaan Group dan Pemberian Hak Akses Wheel (Sudo)
usermod -aG wheel 053660074
groups 053660074

# Langkah 5 & 6: Pengujian Hak Sudo & Manajemen Password
# su - 053660074
# sudo whoami
# passwd

# Langkah 7: Pemantauan Riwayat dan Aktivitas Login
last who
last | head -n 10
who

# Langkah 8: Konfigurasi DNS Resolver pada /etc/resolv.conf
cat <<EOF | sudo tee /etc/resolv.conf
nameserver 208.67.222.222
nameserver 208.67.220.220
EOF
cat /etc/resolv.conf

# Langkah 9: Pengujian Query Resolusi Nama Domain dengan dig
dig www.ut.ac.id
dig google.com

# Langkah 10: Pengelolaan Password & Penghapusan User Test
# sudo passwd usertest
sudo userdel -r usertest
cat /etc/passwd | tail -n 5
