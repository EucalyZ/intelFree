FROM centos:7.9.2009
RUN yum install -y epel-release
RUN yum install -y wine qemu-kvm wqy-zenhei-fonts xz dbus-x11 curl firefox gnome-system-monitor mate-system-monitor git xfce4 xfce4-terminal tigervnc-server wget
RUN wget https://github.com/novnc/noVNC/archive/refs/tags/v1.4.0.tar.gz
RUN tar -xvf v1.4.0.tar.gz
RUN mkdir $HOME/.vnc
RUN echo 'z317640' | vncpasswd -f > $HOME/.vnc/passwd
RUN echo '/bin/env MOZ_FAKE_NO_SANDBOX=1 dbus-launch xfce4-session' > $HOME/.vnc/startup_z.sh
RUN chmod 600 $HOME/.vnc/passwd
RUN chmod 755 $HOME/.vnc/startup_z.sh
RUN echo 'whoami' >> /startup_z.sh
RUN echo 'cd' >> /startup_z.sh
RUN echo "su -l -c 'vncserver :2000 -geometry 1360x768'" >> /startup_z.sh
RUN echo 'cd /noVNC-1.4.0' >> /startup_z.sh
RUN echo './utils/novnc_proxy --vnc localhost:7900 --listen 8900' >> /startup_z.sh
RUN chmod 755 /startup_z.sh
EXPOSE 8900
CMD /startup_z.sh
