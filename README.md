# Jitsi
# REQUIMENT: UBUNTU 20.04
Trỏ domain vào server ubuntu:
- example: meet.cmcati.vn -> 42.96.32.137

Chạy file jitsi.sh
    cd /root/ && git clone https://github.com/hung-hust-97/jitsi-meet.git
    chmod +x jitsi.sh
    ./jitsi.sh

Jitsi tự động cài đặt Nginx, sau đó truy cập nginx: /etc/nginx/sites-available/domain.conf sửa mục root mặc định thành /root/jitsi-meet (nơi lưu trữ source code)
Truy cập domain là vào được web

DOCUMENT: https://jitsi.github.io/handbook/docs/devops-guide/devops-guide-quickstart
