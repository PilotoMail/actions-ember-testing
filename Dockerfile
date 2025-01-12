FROM node:14

LABEL version="1.0.0"
LABEL repository="https://github.com/alexlafroscia/actions-ember-testing"
LABEL homepage="https://github.com/alexlafroscia/actions-ember-testing"
LABEL maintainer="Alex LaFroscia <alex@lafroscia.com>"

LABEL com.github.actions.name="GitHub Action for Ember Testing"
LABEL com.github.actions.description="Provides an environment for running Ember tests"
LABEL com.github.actions.icon="package"
LABEL com.github.actions.color="orange"

# Borrowed from ianwalter/puppeteer
RUN  apt-get update \
  # See https://crbug.com/795759
  && apt-get install -yq libgconf-2-4 \
  # Install latest chrome dev package, which installs the necessary libs to
  # make the bundled version of Chromium that Puppeteer installs work.
  && apt-get install -y wget --no-install-recommends \
  && wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
  && sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list' \
  && apt-get update \
  && apt-get install -y google-chrome-unstable --no-install-recommends \
  && rm -rf /var/lib/apt/lists/*

COPY "entrypoint.sh" "/entrypoint.sh"
ENTRYPOINT ["/entrypoint.sh"]
CMD ["test"]