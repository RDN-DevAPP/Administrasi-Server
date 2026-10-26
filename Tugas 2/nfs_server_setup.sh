#!/bin/bash
# ==============================================================================
# VIDEO 1: SKRIP INSTALASI & KONFIGURASI NFS-SERVER (CENTOS LINUX)
# Mahasiswa : M. RIDUAN (NIM: 053660074) | S1 Sistem Informasi UT Banjarmasin
# ==============================================================================

# 1. Verifikasi Root & IP Address
whoami
ip addr

# 2. Instalasi Paket NFS-Utils dan RPCBind
yum install -y nfs-utils rpcbind

# 3. Pembuatan Direktori Berbagi & Hak Akses
mkdir -p /data/nfs_share
chmod -R 777 /data/nfs_share
chown -R nfsnobody:nfsnobody /data/nfs_share
echo "Uji Coba Berbagi Berkas NFS Server - M. RIDUAN 053660074" > /data/nfs_share/uji_server.txt

# 4. Konfigurasi Berkas Ekspor /etc/exports
echo "/data/nfs_share *(rw,sync,no_root_squash,no_subtree_check)" > /etc/exports
cat /etc/exports

# 5. Pengaktifan Layanan Sistem & Firewall
systemctl enable --now rpcbind
systemctl enable --now nfs-server
systemctl status nfs-server --no-pager

firewall-cmd --permanent --add-service=nfs
firewall-cmd --permanent --add-service=rpc-bind
firewall-cmd --permanent --add-service=mountd
firewall-cmd --reload

exportfs -arv
exportfs -v
