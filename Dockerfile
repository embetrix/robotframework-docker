FROM ubuntu:20.04

ENV USER robotframework
ENV DEBIAN_FRONTEND=noninteractive

# Install required Packages
RUN apt-get update && apt-get -y upgrade
RUN apt-get install -y python3 python3-pip python3-setuptools swig \
                       sudo openssh-client \
                       bash-completion curl \
                       git nano tmux libgpgme-dev

# Add robotframework & extensions
RUN pip3 install robotframework \
                 robotframework-fritzhomelibrary \
                 robotframework-scplibrary \
                 robotframework-seriallibrary \
                 robotframework-sshlibrary \
                 usbsdmux pyyaml pyserial

RUN pip3 install git+https://github.com/embetrix/bmap-tools@no-exclusiv-mode


# Create a non-root user USER
RUN id ${USER} 2>/dev/null || useradd --create-home ${USER}
RUN echo "${USER} ALL=(ALL) NOPASSWD: ALL" | tee -a /etc/sudoers

# make /bin/sh symlink to bash instead of dash
RUN echo "dash dash/sh boolean false" | debconf-set-selections
RUN dpkg-reconfigure dash

USER ${USER}
RUN echo "${USER}:${USER}" | sudo chpasswd
RUN sudo usermod -aG dialout ${USER}
RUN sudo usermod -aG plugdev ${USER}
RUN sudo usermod -aG disk    ${USER}
RUN sudo chown -R ${USER}:${USER} /home/${USER}

WORKDIR /home/${USER}
CMD ["/bin/bash"]
# EOF
