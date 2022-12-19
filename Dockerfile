# Pull base image.
ARG PYTHON_VERSION 
FROM python:$PYTHON_VERSION-slim

ARG BACKEND
ENV VTK_BACKEND $BACKEND

# Install.
RUN \
  apt update -y && \
  apt install -y cmake build-essential git llvm llvm-dev flex ninja-build bison && \
  pip3 install -y meson mako && \
  mkdir /root/vtk

# Set environment variables.
ENV HOME /root

# Define working directory.
WORKDIR /root/vtk

COPY CMakeLists.txt .

RUN \
  cmake . && \
  make -j 2 && \
  cd /root && rm -rf vtk && \
  pip3 uninstall -y meson mako && \
  apt purge -y cmake build-essential git llvm-dev flex ninja-build && \
  apt -y autoremove && \
  apt -y autoclean

ENV PYTHONPATH="/usr/local:$PYTHONPATH"

# Define default command.
CMD ["bash"]
