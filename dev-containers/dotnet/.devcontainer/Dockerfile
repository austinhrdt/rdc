FROM ubuntu:18.04

# Avoid warnings by switching to noninteractive
ENV DEBIAN_FRONTEND=noninteractive

EXPOSE 8099

# username and password
ARG USER="Austin"
ARG USER_UID=1000
ARG USER_GID=$USER_UID

# set up env variables for user
ENV USER $USER
ENV USER_GID=$USER_GID
ENV USER_UID=$USER_UID

# install base packages, add user, etc...
RUN apt-get update && \
  apt-get -y install --no-install-recommends apt-utils 2>&1 \
  && apt-get install -y sudo  \
  #
  # install the tools i wish to use
  apt-transport-https \
  ca-certificates \
  software-properties-common \
  curl \
  git-core \
  git-flow \
  gpg \
  gnupg gnupg-agent \
  lsb-release \
  locales \
  zsh \
  wget \
  nano \
  yum \
  dos2unix \
  iproute2 \
  procps \
  #
  # set up locale
  && locale-gen en_US.UTF-8 \
  #
  # install docker
  && curl -fsSL https://download.docker.com/linux/$(lsb_release -is | tr '[:upper:]' '[:lower:]')/gpg | apt-key add - 2>/dev/null \
  && add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/$(lsb_release -is | tr '[:upper:]' '[:lower:]') $(lsb_release -cs) stable" \
  && apt-get update \
  && apt-get install -y sudo docker-ce-cli \
  #
  # install kubectl
  && curl -sSL -o /usr/bin/kubectl https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl \
  && chmod +x /usr/bin/kubectl \
  #
  # set up openshift cli, oc and odo (broken)
  #&& wget https://github.com/openshift/origin/releases/download/v1.5.1/openshift-origin-client-tools-v1.5.1-7b451fc-linux-64bit.tar.gz \
  #&& tar xvf openshift-origin-client-tools-v1.5.1-7b451fc-linux-64bit.tar.gz \
  #&& sudo mv openshift-origin-client-tools-v1.5.1-7b451fc-linux-64bit/oc /usr/bin/ \
  #&& sudo rm -rf openshift-origin-client-tools-v1.5.1-7b451fc-linux-64bit openshift-origin-client-tools-v1.5.1-7b451fc-linux-64bit.tar.gz \
  #&& curl -L https://github.com/openshift/odo/raw/master/scripts/installer.sh | bash \
  #&& sudo mv /usr/local/bin/odo /usr/bin/ \
  #
  # set up python
  && sudo apt install python3 -y \
  && sudo apt install python3-pip -y \
  && sudo apt install groff -y \
  && /bin/zsh -c "pip3 uninstall -y -r <(pip3 freeze) && pip3 install aws-sam-cli awscli" \
  #
  # Install dotnet
  && wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.asc.gpg \
  && sudo mv microsoft.asc.gpg /etc/apt/trusted.gpg.d/ \
  && wget -q https://packages.microsoft.com/config/ubuntu/18.04/prod.list \
  && sudo mv prod.list /etc/apt/sources.list.d/microsoft-prod.list \
  && sudo chown root:root /etc/apt/trusted.gpg.d/microsoft.asc.gpg \
  && sudo chown root:root /etc/apt/sources.list.d/microsoft-prod.list \
  && sudo apt-get install -y apt-transport-https \
  && sudo apt-get update \
  && sudo apt-get install -y dotnet-sdk-2.1=2.1.300-1 \
  #
  # set up user and password
  && groupadd --gid $USER_GID $USER \
  && useradd -s /bin/bash --uid $USER_UID --gid $USER_GID -m $USER \
  #
  # Passwordless sudo
  && echo $USER ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USER\
  && chmod 0440 /etc/sudoers.d/$USER \
  #
  # create docker group and add user to it
  && sudo groupadd docker \
  && sudo usermod -aG docker $USER \
  #
  # clean up
  && apt-get autoremove \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

# set timezone
ENV TZ=America/New_York
RUN echo $TZ > /etc/timezone && \
  apt-get update && apt-get install -y tzdata && \
  rm /etc/localtime && \
  ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && \
  dpkg-reconfigure -f noninteractive tzdata && \
  apt-get clean

# user stuff
USER $USER
WORKDIR /home/$USER

# make envs and working directories
RUN mkdir ~/.envs \
  && mkdir ~/working

# install nvm
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.34.0/install.sh | bash


# install oh-my-zsh and powerlevel9k, aws stuff, virtualenvwrapper, thefuck
RUN wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh || true \
  && git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k \
  && /bin/zsh -c "pip3 install virtualenvwrapper thefuck"

# EDIT HERE, load our zshrc (from windows)
COPY --chown=Austin:Austin .devcontainer/.zshrc .zshrc* /home/$USER/

# upload .zshrc file, install autosuggestions
RUN /bin/zsh -c "git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions \
  && mv .zshrc .zshrc.txt \
  && dos2unix .zshrc.txt && cp .zshrc.txt .zshrc && rm -r ~/.zshrc.txt"

# set default shell to zsh
ENV SHELL /bin/zsh

# Switch back to dialog for any ad-hoc use of apt-get
ENV DEBIAN_FRONTEND=dialog

# start zsh
CMD [ "zsh" ]