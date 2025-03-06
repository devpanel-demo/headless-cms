#!/bin/bash
# ---------------------------------------------------------------------
# Copyright (C) 2021 DevPanel
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as
# published by the Free Software Foundation version 3 of the
# License.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Affero General Public License for more details.
#
# For GNU Affero General Public License see <https://www.gnu.org/licenses/>.
# ----------------------------------------------------------------------

################################### FRONTEND SERVICE ################################################

cd $APP_ROOT/frontend
rm -rf dist
mkdir -p dist
cat << EOF > "$APP_ROOT/frontend/src/environments/environment.prod.ts"
export const environment = {
  production: true,
  jsonapi: '/api',
  baseUrl: '',
};
EOF
npm install
npm run build-prod-ngsw
cp -i $APP_ROOT/.devpanel/.htaccess dist/.

################################### BACKEND SERVICE ################################################
cd $APP_ROOT/backend

STATIC_FILES_PATH="$APP_ROOT/backend/web/sites/default/files"
SETTINGS_FILES_PATH="$APP_ROOT/backend/web/sites/default/settings.php"
#== Setup settings.php file
cp $APP_ROOT/.devpanel/drupal-settings.php $SETTINGS_FILES_PATH
[[ ! -d $STATIC_FILES_PATH ]] && sudo mkdir --mode 775 $STATIC_FILES_PATH || sudo chmod 775 -R $STATIC_FILES_PATH
sudo chown -R www:www-data $STATIC_FILES_PATH
sudo chown -R www:www $SETTINGS_FILES_PATH

#== Install dependency by using composer
composer install
## Fix bug missing module
git checkout  web/profiles/contrib/contenta_jsonapi/config/sync/core.extension.yml
#== Init project
composer run-script install:with-mysql

sudo cp $APP_ROOT/.devpanel/drupal-settings.php $SETTINGS_FILES_PATH

echo 'Generate hash salt ...'
DRUPAL_HASH_SALT=$(openssl rand -hex 32);
sudo sed -i -e "s/^\$settings\['hash_salt'\].*/\$settings\['hash_salt'\] = '$DRUPAL_HASH_SALT';/g" $SETTINGS_FILES_PATH
