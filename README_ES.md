# Generador desatendido de claves maestras y subclaves GnuPG 25519
# y formateador de dongle USB-LUKS (almacenamiento de claves GPG).

Descripción general
Este repositorio proporciona un conjunto de scripts para generar claves maestras y subclaves GPG mediante una llave USB con cifrado LUKS. Los scripts están diseñados para usuarios sin privilegios de administrador, pero requieren acceso de administrador para ciertas operaciones. Esta configuración está optimizada para Debian Trixie y está pensada para usuarios que puedan trabajar con hardware antiguo sin acceso a internet durante el proceso.

Notas importantes

* Orden de ejecución: Los scripts deben ejecutarse en el orden especificado: PRIMERO, SEGUNDO y TERCERO. No omita ningún paso, incluso si alguno falla.

* Entorno: Asegúrese de tener los archivos necesarios:

PRIMERO.sh

SEGUNDO.sh

TERCERO.sh

(opcionalmente: batchproduction_ofTHIRD.sh)

...en su directorio de Descargas antes de comenzar.

# PARA PRODUCCIÓN POR LOTES (¡mejor!)

* Si tiene varias direcciones de correo electrónico para las que desea generar claves GPG, ejecute los siguientes comandos como usuario root o con sudo:

```bash
sudo bash /home/$USER/Downloads/FIRST.sh;
sudo bash /home/$USER/Downloads/SECOND.sh;
```

* Cree dos archivos:

uno con una columna de propietarios,

y otro con una columna de direcciones de correo electrónico

y aliméntelos sustituyendo los campos de argumentos según el siguiente patrón:

```bash
/home/$USER/Downloads/batchproduction_ofTHIRD.sh <path/to/and/ownerfile.txt> <path/to/and/addressfile.txt>;
```

Este último script le permite introducir listas de correos electrónicos y sus respectivos propietarios, generando scripts bash individuales para cada dirección de correo electrónico.

* Al ejecutar los scripts individuales generados, se crearán claves GPG almacenadas en su memoria USB cifrada con LUKS. Importante: OpenGPG recomienda usar inmediatamente y luego eliminar cualquier clave privada sin cifrar para evitar almacenar información confidencial.

# O ELIGE LA PRODUCCIÓN DE UNA SOLA CLAVE (más intuitivo).

Pasos a seguir

Paso 1: Ejecutar el primer script

1. Abra una terminal.
2. Ejecute el siguiente comando como usuario root o con sudo:

```bash
 bash /home/$USER/Downloads/FIRST.sh
```

Paso 2: Crear la llave USB con LUKS

1. Inicie este paso en modo root:

```bash
 bash /home/$USER/Downloads/SECOND.sh
```

Paso 3: Guardar la clave maestra y las subclaves GPG en el dispositivo USB

1. Inicie este paso en modo root. Es posible que deba cambiar los permisos del script para que sea ejecutable.

Use el siguiente comando:

```bash
 chmod +x /home/$USER/Downloads/THIRD.sh
```

2. Luego, ejecute el script:

```bash
 /home/$USER/Downloads/THIRD.sh
```

Paso final: Desmontar el dispositivo USB de forma segura

Tras completar todos los pasos correctamente, asegúrese de desmontar su dispositivo USB LUKS de forma segura para evitar posibles problemas al volver a conectarlo:

```bash
 /home/$USER/Downloads/THIRD.sh
```

o la próxima vez que conecte su dispositivo, podría experimentar dificultades.

Conclusión

Siguiendo estos pasos, puede generar y almacenar de forma segura su clave maestra y subclaves GPG en una llave USB cifrada con LUKS. Recuerde siempre manejar sus claves privadas con cuidado y seguir las mejores prácticas de seguridad. Si tiene alguna pregunta o problema, consulte la documentación o busque ayuda en la comunidad.
