FROM debian:stretch-slim
ENV HOME /root
ENV UTIL_PACKAGES="vim curl wget git less tar entr"
ENV PACKAGE_ADDR="https://storage.googleapis.com/golang/"
ENV PACKAGE_NAME="go1.8.3.linux-amd64.tar.gz"
ENV GOPATH /usr/workspace
ENV PATH=/usr/local/go/bin:$GOPATH/bin:$PATH

RUN apt-get -y update && apt-get install -y $UTIL_PACKAGES && \
    apt-get clean

RUN mkdir -p ~/.vim/autoload ~/.vim/bundle && \
    curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

RUN wget -q $PACKAGE_ADDR$PACKAGE_NAME && \
    tar -C /usr/local -xzf $PACKAGE_NAME

# Add files.
ADD root/.vimrc /root/.vimrc
ADD root/.bashrc /root/.bashrc

# Define working directory.
WORKDIR /usr/workspace

# Define default command.
CMD ["/bin/bash"]

