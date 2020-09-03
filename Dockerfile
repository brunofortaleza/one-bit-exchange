FROM ruby:2.6.5

# add nodejs and yarn dependecies for the frontend
RUN curl -sL https://deb.nodesource.com/setup_12.x | bash - && \
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

# Instala nossas dependencias
RUN apt-get update && apt-get install -qq -y --no-install-recommends \
nodejs yarn build-essential libpq-dev imagemagick git-all nano

# Instalar bundler
RUN gem install bundler

# Seta nosso path
ENV INSTALL_PATH /onebitexchange

# Cria nosso diretorio
RUN mkdir -p $INSTALL_PATH

# Seta o nosso path como o diretorio principal
WORKDIR $INSTALL_PATH

# Copia o nosso gemfile para dentro do container
COPY Gemfile ./

# Seta o path para as gems
ENV BUNDLE_PATH /gems

# Copia nosso codigo para dentro do container
COPY . .