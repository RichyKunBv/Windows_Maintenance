## 🧰 Windows Maintenance - RichyKunBv

**Repositorio:** `Windows_Maintenance`
**Autor:** [RichyKunBv](https://github.com/RichyKunBv)
**Archivos incluidos:**

* `Mantenimiento.bat` – script principal
* `Mantenimiento.exe` – ejecutable para mayor comodidad

---

### 🖥️ ¿Qué es esto?

Un script de mantenimiento para Windows que agrupa múltiples herramientas del sistema en un menú interactivo. Ideal para mantener tu PC limpia, rápida y estable sin instalar nada adicional.

---

### 🚀 Instrucciones de uso

1. Descarga el repositorio. (ojo algunas veces al momento de descargar va a poner este aviso, solo presiona los tres puntos y en conservar)

![Captura de pantalla 2025-06-20 191347](https://github.com/user-attachments/assets/8ab94073-82e5-4c8f-8468-c8b43dbb173a)

2. Ejecuta `Mantenimiento.exe` o `Mantenimiento.bat` como **Administrador**. (OJO en algunos casos va a saltar este mensaje, mi aplicacion es totalmente segura pero no tengo certificacion (es de paga) la muestra como sospechosa pero es totalmente segura)
![Captura de pantalla 2025-06-03 171134](https://github.com/user-attachments/assets/bb2ebf9f-cb0d-44e8-ab16-d6dfedcac843)   
3. Selecciona una opción del menú (1 a 5).
4. Espera a que finalicen los procesos. Algunos pueden tardar.

---

### 📋 Opciones del menú

#### 1. ✅ Revisión del sistema

* Ejecuta `sfc /scannow` y DISM para revisar y reparar archivos del sistema.

#### 2. 🔧 Limpieza básica

* Desfragmenta discos duros y revisa el sistema de archivos con `chkdsk`.

#### 3. 🧼 Limpieza completa

* Elimina archivos temporales, reinicia configuración de red, limpia DNS, firewall, arranque y más.
* Crea un punto de restauración automático por si algo sale mal.

#### 4. 🔍 Análisis completo

* Ejecuta todo lo anterior de forma automatizada: revisión, limpieza básica y profunda.

#### 5. 🚪 Salir

* Cierra el programa y abre el repositorio en GitHub.

![Captura de pantalla 2025-05-25 174803](https://github.com/user-attachments/assets/e16a1b28-60e2-40c4-88fa-bfc252760eb9)

---

### ⚠️ Notas

* Usa la opción 3 o 4 al menos una vez al mes para mantener tu sistema sano.
* No se recomienda usar `defrag` si solo tienes SSD (puedes editar el script para quitarlo).
* El `.exe` es un wrapper del `.bat`, pensado para facilitar su ejecución en usuarios sin conocimientos técnicos.

---

