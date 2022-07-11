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
  yum install -y cmake libX11-devel libXcursor-devel mesa-libGL-devel mesa-libGLU-devel libdrm git-core git-lfs gcc-c++ llvm13-devel flex ninja-build python3-pip && \
  pip3 install meson mako && \
  mkdir /root/vtk

# Set environment variables.
ENV HOME /root

# Define working directory.
WORKDIR /root/vtk

COPY CMakeLists.txt .

RUN cmake . && make && rm -rf /root/vtk

ENV PATH="$PYTHON_PATH/bin:${PATH}"
ENV PYTHONPATH="/usr/local:$PYTHONPATH"

# Define default command.
CMD ["bash"]
