FROM ubuntu:latest

ENV DEBIAN_FRONTEND=noninteractive \
    TZ=Etc/UTC
RUN apt-get update && apt-get install -y \
    cmake \
    make \
    g++ \
    gcc \
    git \
    tree \
    vim \
    wget

# Install GTest from source and use its own CMake script since the one from CMake/Ubuntu is not directly compatible
RUN wget "https://github.com/google/googletest/archive/refs/tags/release-1.11.0.tar.gz" -O /tmp/gtest.tar.gz && \
  cd /tmp && \
  tar -xf /tmp/gtest.tar.gz && \
  cd googletest-release-* && \
  cmake -D CMAKE_BUILD_TYPE=Release -D CMAKE_INSTALL_PREFIX=/usr -S . -B build && \
  cmake --build build --parallel 16 && \
  cmake --build build --target install --parallel 16
RUN rm /usr/share/cmake-*/Modules/FindGTest.cmake

WORKDIR /tmp
