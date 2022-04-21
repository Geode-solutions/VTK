# Pull base image.
FROM quay.io/pypa/manylinux2014_x86_64

ARG PYTHON_PATH
ENV PYTHON_PREFIX $PYTHON_PATH

ARG BACKEND
ENV VTK_BACKEND $BACKEND

# Install.
RUN \
  yum install -y epel-release && \
  yum update -y && \
  yum install -y cmake libX11-devel libXcursor-devel mesa-libGL-devel mesa-libGLU-devel git-core git-lfs gcc-c++ llvm-devel ninja-build python3-pip && \
  pip3 install meson mako

# Set environment variables.
ENV HOME /root

# Define working directory.
WORKDIR /root

COPY CMakeLists.txt .

RUN cmake . && make

# Define default command.
CMD ["bash"]
