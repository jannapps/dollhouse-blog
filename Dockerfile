# syntax=docker/dockerfile:1
# check=error=true

# This Dockerfile is designed for production, not development. Use with Kamal or build'n'run by hand:
# docker build -t dollhouse_blog .
# docker run -d -p 80:80 -e RAILS_MASTER_KEY=<value from config/master.key> --name dollhouse_blog dollhouse_blog

# For a containerized dev environment, see Dev Containers: https://guides.rubyonrails.org/getting_started_with_devcontainer.html

FROM nixos/nix

#RUN nix-channel --update


COPY Gemfile Gemfile.lock shell.nix /app

WORKDIR /app

RUN nix-shell --run "true"  # Preload nix-shell dependencies

RUN nix-shell --run " \
    gem install bundler -v 2.5.6 && \
    bundle config set deployment 'true' && \
    bundle config set without 'development test' && \
    #bundle config set with 'development test' && \
    bundle install && \
"

COPY ./ /app

ENV RAILS_ENV=production

ENV SECRET_KEY_BASE_DUMMY=dummy_value_for_nix_build

#ENV RAILS_MASTER_KEY=${RAILS_MASTER_KEY}

RUN nix-shell --run " \
    bundle exec rake assets:precompile && \
    bundle exec rake db:migrate \
    "


EXPOSE 80
CMD ["nix-shell", "--run", "bundle exec bin/rails server -p 80"]