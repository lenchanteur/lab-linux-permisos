# Laboratorio: Usuarios, grupos, sudo y permisos en Linux

## Objetivo

En este laboratorio practicarás:

- creación de usuarios con `adduser`
- uso de `sudo`
- creación y uso de grupos
- permisos `rwx`
- comandos `chmod`, `chgrp`, `usermod`, `id`, `groups`
- pruebas de acceso como otro usuario

---

# Cómo empezar

1. Haz clic en **Code**
2. Ve a **Codespaces**
3. Selecciona **Create codespace**
4. Abre la terminal

Ejecuta:

```bash
ls
```

Debes ver archivos como:

```bash
setup.sh
verificar.sh
README.md
```

Si no aparece la carpeta `laboratorio`, ejecuta:

```bash
bash setup.sh
```

---

# Parte 1: Exploración inicial

## Misión 1: Ver usuarios y grupos existentes

Ejecuta:

```bash
id ana
id bruno
id carla
groups ana
groups bruno
groups carla
```

Responde:

1. ¿A qué grupo pertenece `ana`?
2. ¿A qué grupo pertenece `carla`?
3. ¿Cuál de los usuarios pertenece al grupo `sudo`?

---

# Parte 2: Crear usuarios con adduser

## Misión 2: Crear un usuario nuevo

Crea un usuario llamado `invitado`:

```bash
sudo adduser invitado
```

Cuando pida datos opcionales, puedes presionar Enter.

Verifica:

```bash
id invitado
groups invitado
```

Responde:

1. ¿Qué UID tiene `invitado`?
2. ¿A qué grupo pertenece inicialmente?
3. ¿Por qué fue necesario usar `sudo`?

---

## Misión 3: Intentar crear usuario sin sudo

Ejecuta:

```bash
adduser prueba_sin_sudo
```

Responde:

1. ¿Qué error aparece?
2. ¿Por qué no se permite crear usuarios sin privilegios administrativos?

Luego créalo correctamente:

```bash
sudo adduser prueba_sin_sudo
```

---

# Parte 3: Uso de sudo

## Misión 4: Verificar privilegios administrativos

Ejecuta:

```bash
sudo whoami
```

Responde:

1. ¿Qué resultado aparece?
2. ¿Qué significa que el resultado sea `root`?

---

## Misión 5: Ejecutar comandos como otro usuario

Ejecuta:

```bash
sudo -u ana whoami
sudo -u carla whoami
```

Responde:

1. ¿Qué usuario ejecutó cada comando?
2. ¿Para qué sirve `sudo -u`?

---

## Misión 6: Usuario sin privilegios sudo

Ejecuta:

```bash
sudo -u invitado sudo ls
```

Responde:

1. ¿Funcionó?
2. ¿Por qué `invitado` no puede usar `sudo`?

---

# Parte 4: Grupos

## Misión 7: Crear usuario para un equipo

Crea un usuario llamado `analista`:

```bash
sudo adduser analista
```

Agrégalo al grupo `equipo_rojo`:

```bash
sudo usermod -aG equipo_rojo analista
```

Verifica:

```bash
groups analista
```

Responde:

1. ¿A qué grupos pertenece `analista`?
2. ¿Qué hace `usermod -aG`?

---

# Parte 5: Permisos de archivos y carpetas

## Misión 8: Explorar permisos

Ejecuta:

```bash
ls -l laboratorio
```

Responde:

1. ¿Qué carpetas existen?
2. ¿Qué permisos tiene cada carpeta?
3. ¿Cuál parece más insegura?

---

## Misión 9: Proteger el archivo secreto

Revisa:

```bash
ls -l laboratorio/secreto
```

El archivo `clave.txt` está demasiado expuesto.

Corrige los permisos para que solo el dueño pueda leer y escribir:

```bash
chmod 600 laboratorio/secreto/clave.txt
```

Verifica:

```bash
ls -l laboratorio/secreto
```

Responde:

1. ¿Qué significa `600`?
2. ¿Quién puede leer el archivo?
3. ¿Quién no puede leerlo?

---

## Misión 10: Configurar carpeta de equipo

La carpeta `laboratorio/equipo` debe ser accesible para el grupo `equipo_rojo`.

Ejecuta:

```bash
sudo chgrp equipo_rojo laboratorio/equipo
chmod 770 laboratorio/equipo
ls -ld laboratorio/equipo
```

Responde:

1. ¿Qué significa `770`?
2. ¿Qué permisos tiene el dueño?
3. ¿Qué permisos tiene el grupo?
4. ¿Qué permisos tienen otros usuarios?

---

## Misión 11: Probar acceso por grupo

Prueba como `ana`:

```bash
sudo -u ana ls laboratorio/equipo
```

Prueba como `carla`:

```bash
sudo -u carla ls laboratorio/equipo
```

Responde:

1. ¿Quién pudo acceder?
2. ¿Quién no pudo acceder?
3. ¿Qué grupo explica esa diferencia?

---

# Parte 6: Corrige el desastre

## Misión 12: Permisos inseguros

Alguien dejó esta carpeta con permisos `777`:

```bash
ls -ld laboratorio/secreto
```

Responde:

1. ¿Qué significa `777`?
2. ¿Por qué puede ser peligroso?

Corrige la carpeta para que solo el dueño pueda acceder:

```bash
chmod 700 laboratorio/secreto
```

Verifica:

```bash
ls -ld laboratorio/secreto
```

---

# Parte 7: Mini reto final

Configura lo siguiente:

| Recurso | Regla |
|---|---|
| `laboratorio/publico` | todos pueden leer y entrar |
| `laboratorio/confidencial` | solo dueño y grupo autorizado |
| `laboratorio/equipo` | dueño y grupo `equipo_rojo` |
| `laboratorio/secreto/clave.txt` | solo dueño puede leer y escribir |

Ahora crea un usuario y grupo nuevos:

```bash
sudo adduser auditor
sudo groupadd auditoria
sudo usermod -aG auditoria auditor
```

Configura la carpeta confidencial:

```bash
sudo chgrp auditoria laboratorio/confidencial
chmod 770 laboratorio/confidencial
```

Configura el resto:

```bash
chmod 755 laboratorio/publico
sudo chgrp equipo_rojo laboratorio/equipo
chmod 770 laboratorio/equipo
chmod 600 laboratorio/secreto/clave.txt
```

Verifica:

```bash
bash verificar.sh
ls -ld laboratorio/publico
ls -ld laboratorio/confidencial
ls -ld laboratorio/equipo
ls -l laboratorio/secreto
groups auditor
```

---

# Entregable

Entrega un documento breve con:

1. Captura de `bash verificar.sh`
2. Captura de la creación de al menos un usuario con `sudo adduser`
3. Captura de una prueba con:

```bash
sudo -u ana ls laboratorio/equipo
```

4. Captura de una prueba con:

```bash
sudo -u carla ls laboratorio/equipo
```

5. Respuestas breves:
   - ¿Qué hace `adduser`?
   - ¿Qué hace `sudo`?
   - ¿Qué significa `rwx`?
   - ¿Qué hace `chmod`?
   - ¿Por qué `777` es inseguro?
   - ¿Qué diferencia hay entre usuario, grupo y otros?

6. Un error que cometiste y cómo lo corregiste.

---

# Nota importante

En Codespaces tienes privilegios administrativos dentro de un entorno controlado.  
Eso permite practicar administración de usuarios y permisos sin afectar una computadora real.

Antes de cerrar, elimina o detén el Codespace para no consumir cuota innecesaria.