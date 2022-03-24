FROM ubuntu:20.04

ARG DEBIAN_FRONTEND=noninteractive 
ENV TZ=Asia/Seoul

LABEL "purpose"="practice"
LABEL email="jaichang@angel-robotics.com"
LABEL name="jaichang"
LABEL version="1.0"
LABEL description="Ros2-Foxy"

RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install -y net-tools sudo git

RUN apt-get install locales 
RUN locale-gen en_US en_US.UTF-8
RUN update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8
RUN export LANG=en_US.UTF-8

RUN apt-get install -y curl gnupg2 lsb-release
RUN curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key  -o /usr/share/keyrings/ros-archive-keyring.gpg

RUN echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(. /etc/os-release && echo $UBUNTU_CODENAME) main" | tee /etc/apt/sources.list.d/ros2.list > /dev/null
RUN apt-get update

RUN apt-get install -y \
  build-essential \
  cmake \
  git \
  libbullet-dev \
  python3-colcon-common-extensions \
  python3-flake8 \
  python3-pip \
  python3-pytest-cov \
  python3-rosdep \
  python3-setuptools \
  python3-vcstool \
  wget

RUN python3 -m pip install -U \
  argcomplete \
  flake8-blind-except \
  flake8-builtins \
  flake8-class-newline \
  flake8-comprehensions \
  flake8-deprecated \
  flake8-docstrings \
  flake8-import-order \
  flake8-quotes \
  pytest-repeat \
  pytest-rerunfailures \
  pytest

RUN apt-get install --no-install-recommends -y \
  libasio-dev \
  libtinyxml2-dev

RUN apt-get install --no-install-recommends -y \
  libcunit1-dev

RUN apt-get install -y ros-foxy-ros-base
RUN . /opt/ros/foxy/setup.sh
# RUN mkdir -p ws/src && cd ws/src && git clone https://github.com/ros2/examples.git -b foxy
RUN apt-get install -y ros-foxy-example-interfaces
RUN pip3 install pymongo
RUN mkdir -p colcon_ws/src