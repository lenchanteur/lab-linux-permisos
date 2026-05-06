#!/bin/bash

echo "=== Estado general de carpetas ==="
ls -l laboratorio
echo

echo "=== Archivos internos ==="
ls -l laboratorio/publico
ls -l laboratorio/equipo
ls -l laboratorio/secreto
ls -l laboratorio/confidencial
echo

echo "=== Usuarios de prueba ==="
id ana
id bruno
id carla
echo

echo "=== Grupos de prueba ==="
groups ana
groups bruno
groups carla