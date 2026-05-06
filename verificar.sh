#!/bin/bash

echo "=== Estado de permisos ==="
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
