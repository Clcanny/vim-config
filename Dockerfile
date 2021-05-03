FROM debian:bullseye
RUN apt-get update && apt-get install -y     \
  build-essential cmake make gcc g++         \
  pkg-config m4 automake libtool-bin gettext \
  curl wget git zip unzip                    \
  libffi-dev libssl-dev zlib1g-dev  fuse \
  && rm -rf /var/lib/apt/lists/*

RUN git clone https://github.com/neovim/neovim.git /neovim
WORKDIR /neovim
RUN make CMAKE_BUILD_TYPE=RelWithDebInfo CMAKE_INSTALL_PREFIX=/usr -j$(nproc)
RUN make install DESTDIR=/AppDir

RUN git clone --branch 3.9 https://github.com/python/cpython.git /cpython
WORKDIR /cpython
RUN ./configure --enable-optimizations --prefix=/usr
RUN make -j$(nproc)
RUN make install DESTDIR=/AppDir
RUN cp /lib/x86_64-linux-gnu/libm.so.6 /AppDir/usr/lib/x86_64-linux-gnu/libm.so.6
RUN /AppDir/usr/bin/python3 -m pip install pynvim

COPY AppRun /AppDir/AppRun
RUN mkdir -p /AppDir/.config/nvim /AppDir/vim-config/plug
COPY init.vim /AppDir/.config/nvim/init.vim
COPY config /AppDir/vim-config/config
RUN curl -fLo /AppDir/vim-config/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
ENV APPDIR=/AppDir
RUN /AppDir/usr/bin/nvim -u /AppDir/.config/nvim/init.vim +PlugInstall +qall

WORKDIR /
RUN wget https://github.com/linuxdeploy/linuxdeploy/releases/download/continuous/linuxdeploy-x86_64.AppImage
RUN chmod u+x linuxdeploy-x86_64.AppImage
RUN ./linuxdeploy-x86_64.AppImage --appimage-extract
RUN ./squashfs-root/AppRun --appdir AppDir
RUN ./squashfs-root/AppRun --appdir AppDir --output appimage
