#!/bin/bash


tomcat_versions=("9" "10" "11")
file="check_version.txt"




version_exists() {
  local version=$1
  grep -qx "${version},v" "$file"
}


for version in "${tomcat_versions[@]}"; do
  if version_exists "$version"; then
    echo "Version $version already exists in $file."
  else
    echo "${version},v" >> "$file" || { echo "Failed to write to $file"; exit 1; }
    echo "Version $version added to $file."
  fi
done

echo "Using Artifactory password: ${ARTIFACTORY_PASSWORD}"
echo "Using Git repository password: ${GIT_REPO_PASSWORD}"
