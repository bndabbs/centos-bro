FROM centos:7
MAINTAINER "Jeff Geiger" <@jeffgeiger>

USER root
RUN yum makecache fast && \
  yum install autoconf python-devel automake wget vim libtool openssl openssl-devel net-tools sudo epel-release -y && \
  rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-7 && \
  curl -s https://packagecloud.io/install/repositories/rocknsm/2/script.rpm.sh | sudo bash && \
  yum makecache fast && \
  yum install bro wireshark tcpdump vim git GeoIP-update GeoIP GeoIP-update-devel -y && \
  curl -L https://raw.githubusercontent.com/rocknsm/rock/master/playbooks/files/profile.d-bro.sh -o /etc/profile.d/bro.sh && \
  useradd -r -m -d /home/student -s /bin/bash -c "Student Account" student && \
  echo 'student	ALL=(ALL)	NOPASSWD: ALL' >> /etc/sudoers && \
  sed -i '/^ProductIds/ d' /etc/GeoIP.conf && \
  echo 'ProductIds GeoLite-Legacy-IPv6-City GeoLite-Legacy-IPv6-Country 506 517 533' >> /etc/GeoIP.conf && \
  geoipupdate && \
  ln -s /usr/share/GeoIP/GeoLiteCity.dat /usr/share/GeoIP/GeoIPCity.dat && \
  ln -s /usr/share/GeoIP/GeoLiteCountry.dat /usr/share/GeoIP/GeoIPCountry.dat && \
  ln -s /usr/share/GeoIP/GeoLiteASNum.dat /usr/share/GeoIP/GeoIPASNum.dat && \
  ln -s /usr/share/GeoIP/GeoLiteCityv6.dat /usr/share/GeoIP/GeoIPCityv6.dat && \
  echo 'export PATH=$PATH:/opt/bro/bin' >> /home/student/.bashrc

USER student
ENV HOME /home/student
ENV USER student
WORKDIR /home/student

ENTRYPOINT /bin/bash
