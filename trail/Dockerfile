FROM ubuntu:22.04

RUN apt -y update
RUN apt -y install \
    bash \
    git \
    vim \
    python3-dev \
    python3-pip \
    curl \
    htop \
    unzip \
    nmap \
    systemctl \
    sudo


WORKDIR /bough

# configure openvpn
RUN apt -y install openvpn

# install requirements
COPY requirements.txt .
RUN pip3 install -r requirements.txt

RUN apt -y install tinyproxy
COPY tinyproxy.conf /etc/tinyproxy/tinyproxy.conf

# configure openvpn
COPY openvpn ./openvpn

## (~) might come in handy maybe?
## copy in update-resolv-conf
## needed by at least proton
#RUN apt -y install openresolv
#RUN mkdir -p /etc/openvpn/
#COPY update-resolv-conf.sh /etc/openvpn/update-resolv-conf
#RUN chmod 777 /etc/openvpn/update-resolv-conf

# grab source
RUN touch __init__.py
COPY trail.py .

ENTRYPOINT ["gunicorn", "-b 0.0.0.0:33710", "-w 1", "trail:create_app()", "--threads 1"]
