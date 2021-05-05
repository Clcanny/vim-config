FROM debian:bullseye
LABEL maintainer="837940593@qq.com"

RUN apt-get update && apt-get install -y     \
  build-essential cmake make gcc g++         \
  pkg-config m4 automake libtool-bin gettext \
  curl wget git zip unzip                    \
  libffi-dev libssl-dev zlib1g-dev rsync     \
  python3 python3-pip                        \
  && rm -rf /var/lib/apt/lists/*

RUN pip3 install --user lief

RUN git clone https://github.com/neovim/neovim.git /neovim
WORKDIR /neovim
RUN make CMAKE_BUILD_TYPE=RelWithDebInfo CMAKE_INSTALL_PREFIX=/usr -j$(nproc)
RUN make install DESTDIR=/AppDir

RUN git clone --branch 3.9 https://github.com/python/cpython.git /cpython
WORKDIR /cpython
RUN ./configure --enable-optimizations --prefix=/usr
RUN make -j$(nproc)
RUN make install DESTDIR=/AppDir
RUN /AppDir/usr/bin/python3 -m pip install pynvim \
    isort==4.3.21 yapf==0.30.0                    \
    beautysh==6.0.1                               \
    cmake-format==0.6.10                          \
    sqlparse==0.3.1
RUN mkdir -p /AppDir/.vim/plug/vim-formatter/config
RUN /AppDir/usr/bin/yapf --style="google" --style-help > /AppDir/.vim/plug/vim-formatter/config/yapf.cfg

COPY AppDir /tmp/AppDir
RUN rsync -a /tmp/AppDir/ /AppDir/
RUN curl -fLo /AppDir/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
ENV APPDIR=/AppDir
RUN /AppDir/usr/bin/nvim -u /AppDir/.config/nvim/init.vim +PlugInstall +qall

COPY patch_interp.py /patch_interp.py
RUN mkdir -p /appimage
RUN cp /lib/x86_64-linux-gnu/ld-2.31.so /appimage/ld-2.31.so
RUN rsync -a /lib/x86_64-linux-gnu/ /AppDir/usr/lib/
RUN rsync -a /usr/lib/x86_64-linux-gnu/ /AppDir/usr/lib/
RUN /patch_interp.py /AppDir/usr/bin/nvim
RUN /patch_interp.py /AppDir/usr/bin/python3.9

WORKDIR /
RUN wget https://github.com/linuxdeploy/linuxdeploy/releases/download/continuous/linuxdeploy-x86_64.AppImage
RUN chmod u+x linuxdeploy-x86_64.AppImage
RUN ./linuxdeploy-x86_64.AppImage --appimage-extract
RUN ./squashfs-root/AppRun --appdir AppDir
RUN ./squashfs-root/AppRun --appdir AppDir --output appimage
