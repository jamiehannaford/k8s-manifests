apk --update add curl

# wait for grafana to be ready...
until $(curl -m 2 --silent --fail --show-error --output /dev/null http://localhost:3000/api/datasources); do
  printf '.'
  sleep 1
done

# Add any datasources
for file in *-datasource.json; do
  if [ -e "$file" ]; then
    echo "Importing ${file}..."
    curl --silent --fail --show-error \
      http://localhost:3000/api/datasources \
      --header "Content-Type: application/json" \
      --data-binary "@$file"
    echo
  fi
done

# Add any dashboards
for file in *-dashboard.json; do
  if [ -e "$file" ]; then
    echo "Importing ${file}..."
    curl --silent --fail --show-error \
      http://localhost:3000/api/dashboards/db \
      --header "Content-Type: application/json" \
      --data-binary "@$file"
    echo
  fi
done

echo "Setting preferences..."
curl --silent --fail --show-error \
  --request PUT \
  http://admin:admin@localhost:3000/api/org/preferences \
  --header "Content-Type: application/json" \
  --data '@preferences.json'
echo

# Don't die
while true; do
  sleep 3600
done
