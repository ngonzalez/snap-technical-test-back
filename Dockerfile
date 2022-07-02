FROM ruby:3.1.0

ENV APP_ROOT_PATH=/home/snap \
    GEM_HOME=/home/snap/vendor/bundle

RUN mkdir -vp ${APP_ROOT_PATH}
RUN useradd -m snap
RUN chown -R snap:snap ${APP_ROOT_PATH}

WORKDIR ${APP_ROOT_PATH}

RUN mkdir -vp ${GEM_HOME} \
    && chown -R snap:snap ${GEM_HOME}
RUN echo 'gem: --no-ri --no-rdoc' > ~/.gemrc

RUN gem install bundler && gem update --system

USER snap

COPY --chown=snap:snap . .

RUN bundle config set path ${GEM_HOME} && bundle check || bundle install 