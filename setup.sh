#!/bin/bash

echo "Preparando laboratorio de usuarios, grupos y permisos..."

# Crear grupos base
sudo groupadd equipo_rojo 2>/dev/null || true
sudo groupadd equipo_azul 2>/dev/null || true

# Crear usuarios base sin interacción
sudo adduser --disabled-password --gecos "" ana 2>/dev/null || true
sudo adduser --disabled-password --gecos "" bruno 2>/dev/null || true
sudo adduser --disabled-password --gecos "" carla 2>/dev/null || true

# Asignar usuarios a grupos
sudo usermod -aG equipo_rojo ana
sudo usermod -aG equipo_rojo bruno
sudo usermod -aG equipo_azul carla

# Dar privilegios sudo a ana para demostración
sudo usermod -aG sudo ana

# Crear estructura del laboratorio
mkdir -p laboratorio/{publico,confidencial,equipo,secreto}

echo "Mensaje público de práctica" > laboratorio/publico/info.txt
echo "Plan interno del equipo rojo" > laboratorio/equipo/plan.txt
echo "Clave ficticia de práctica" > laboratorio/secreto/clave.txt
echo "Documento confidencial de práctica" > laboratorio/confidencial/reporte.txt

# Permisos iniciales
chmod -R 755 laboratorio
chmod 777 laboratorio/secreto
chmod 644 laboratorio/secreto/clave.txt

echo "Laboratorio listo."
echo "Ejecuta: bash verificar.sh"