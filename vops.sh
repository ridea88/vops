#!/usr/bin/env bash

# Warna untuk output terminal
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Fungsi Menampilkan Banner (Vibe Pixel/Terminal)
show_banner() {
    clear
    echo -e "${BLUE}=========================================${NC}"
    echo -e "${GREEN}    _   ______  ____  _____            ${NC}"
    echo -e "${GREEN}   | | / / __ \/ __ \/ ___/            ${NC}"
    echo -e "${GREEN}   | |/ / /_/ / /_/ /\__ \             ${NC}"
    echo -e "${GREEN}   |___/\____/ .___/____/  v0.1.0      ${NC}"
    echo -e "${GREEN}            /_/                        ${NC}"
    echo -e "${BLUE}  VPS Optimization & Security Assistant  ${NC}"
    echo -e "${BLUE}=========================================${NC}"
}

# 1. Fungsi Cek Kesehatan Server (Health Check)
check_health() {
    echo -e "\n${YELLOW}[*] Memeriksa Kesehatan Server...${NC}"
    
    # Cek CPU Load
    cpu_load=$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1}')
    echo -e " - CPU Usage: ${GREEN}${cpu_load}%${NC}"
    
    # Cek RAM
    ram_free=$(free -h | awk '/^Mem:/ {print $4 "/" $2}')
    echo -e " - RAM Available/Total: ${GREEN}${ram_free}${NC}"
    
    # Cek Disk Space
    disk_free=$(df -h / | awk '/\// {print $4 " available (" $5 " used)"}')
    echo -e " - Disk Space (/): ${GREEN}${disk_free}${NC}"
}

# 2. Fungsi Audit Keamanan Cepat (Security Audit)
audit_security() {
    echo -e "\n${YELLOW}[*] Menjalankan Audit Keamanan Singkat...${NC}"
    
    # Cek UFW Firewall Status
    if command -v ufw >/dev/null 2>&1; then
        ufw_status=$(sudo ufw status | grep "Status" | awk '{print $2}')
        if [ "$ufw_status" = "active" ]; then
            echo -e " - Firewall (UFW): ${GREEN}ACTIVE${NC}"
        else
            echo -e " - Firewall (UFW): ${RED}INACTIVE (Peringatan!)${NC}"
        fi
    else
        echo -e " - Firewall (UFW): ${RED}Belum Terinstall${NC}"
    fi

    # Cek Port Terbuka
    echo -e " - Port yang sedang mendengarkan (Listening):"
    ss -tuln | grep LISTEN | awk '{print "   -> " $5}' | head -n 5
}

# 3. Fungsi Pembersih Cache & Log Lama (Optimizer)
optimize_server() {
    echo -e "\n${YELLOW}[*] Membersihkan Sampah Sistem...${NC}"
    echo -e " - Membersihkan cache apt paket manager..."
    sudo apt-get clean -y
    
    echo -e " - Menghapus journald log yang berumur lebih dari 3 hari..."
    sudo journalctl --vacuum-time=3d
    
    echo -e "${GREEN}[+] Optimasi Selesai! Ruang disk telah dikosongkan.${NC}"
}

# Fungsi untuk menahan halaman sebelum kembali ke menu utama
press_any_key() {
    echo -e "\n${BLUE}-----------------------------------------${NC}"
    read -p "Tekan [Enter] untuk kembali ke menu utama..."
}

# --- MAIN LOOP APPLICATION ---
while true; do
    show_banner
    echo -e "\nSilakan pilih opsi menu di bawah ini:"
    echo -e " [1] Check Server Health (CPU, RAM, Disk)"
    echo -e " [2] Run Security Audit (Firewall & Ports)"
    echo -e " [3] Optimize Server (Clean Cache & Logs)"
    echo -e " [4] Run All Features"
    echo -e " [5] Exit Application"
    echo -e "${BLUE}-----------------------------------------${NC}"
    read -p "Masukkan pilihan Anda (1-5): " pilihan

    case "$pilihan" in
        1)
            check_health
            press_any_key
            ;;
        2)
            audit_security
            press_any_key
            ;;
        3)
            optimize_server
            press_any_key
            ;;
        4)
            check_health
            audit_security
            optimize_server
            press_any_key
            ;;
        5)
            echo -e "\n${GREEN}[+] Keluar dari VOPS. Sampai jumpa, Bung!${NC}\n"
            exit 0
            ;;
        *)
            echo -e "\n${RED}[!] Pilihan tidak valid! Masukkan angka antara 1 sampai 5.${NC}"
            sleep 2
            ;;
    esac
done
