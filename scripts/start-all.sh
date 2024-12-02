#!/bin/bash

# Fonction pour vérifier si un répertoire existe
check_and_run() {
  local service=$1
  local service_path=$2

  if [ -d "$service_path" ]; then
    echo "Lancement du service $service..."
    cd "$service_path" || exit
    docker-compose up -d
    cd - || exit
  else
    echo "Le dossier $service_path pour $service est manquant, service ignoré."
  fi
}

# Lancer le docker-compose de user-service
check_and_run "User" "../user-service"

# Lancer le docker-compose de book-service
check_and_run "Book" "../book-service"

# Lancer le docker-compose de borrowing-service
check_and_run "Borrowing" "../borrowing-service"

# Retourner dans le dossier principal
cd ../central-docker-compose || exit

echo "Tous les services ont été traités!"
