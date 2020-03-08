#! /bin/bash

bundle exec rails assets:precompile

mount | grep -q /assets
if [[ $? = 0 ]]; then
  echo "Copying assets..."
  rsync -ak --delete public/ /assets
fi

bundle exec rails db:migrate
bundle exec puma -C config/puma.rb