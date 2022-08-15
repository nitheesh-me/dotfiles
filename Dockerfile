FROM ubuntu:22.04

RUN apt-get update && apt-get install -y \
  curl \
  git \
  vim \
  wget \
  zsh \
  && sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" \
  && chsh -s $(which zsh) \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

# Create a non root user
RUN useradd -ms $(which zsh) dev
USER dev
WORKDIR /home/dev

CMD [ "zsh" ]
