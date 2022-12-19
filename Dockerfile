# Pull base image.
ARG PYTHON_VERSION 
FROM python:$PYTHON_VERSION-slim

ARG BACKEND
ENV VTK_BACKEND $BACKEND

# Install.
RUN \
  apt update -y && \
  apt install -y cmake build-essential git llvm llvm-dev flex ninja-build bison && \
  pip3 install meson mako && \
  mkdir /root/vtk

# Set environment variables.
ENV HOME /root

# Define working directory.
WORKDIR /root/vtk

COPY CMakeLists.txt .

RUN \
  cmake . && \
  make && \
  rm -rf /root/vtk && \
  pip3 uninstall meson mako && \
  apt purge cmake build-essential git llvm-dev flex ninja-build && \
  apt autoremove && \
  apt autoclean

# Define default command.
CMD ["bash"]
