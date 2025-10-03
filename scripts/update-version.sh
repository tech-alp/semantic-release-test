#!/bin/bash
set -e
NEW_VERSION=$1
echo "Updating version to $NEW_VERSION in CMakeLists.txt"

# Proje adınız "mylib" ise aşağıdaki satırı ona göre güncelleyin.
# Linux/macOS için sed komutu
sed -i "s/project(mylib VERSION [0-9.]*)/project(mylib VERSION $NEW_VERSION)/" CMakeLists.txt