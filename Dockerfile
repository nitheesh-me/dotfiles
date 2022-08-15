FROM ubuntu:22.04

ARG GITHUB_TOKEN

RUN apt-get update && apt-get install -y \
  curl \
  git \
  vim \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*


# Create a non root user
RUN useradd -ms "$(which zsh)" dev
USER dev
WORKDIR /home/dev

RUN curl -fsSL "https://raw.githubusercontent.com/nitheesh-me/dotfiles/main/scripts/install_dotfiles.sh" | bash -


CMD [ "zsh" ]
