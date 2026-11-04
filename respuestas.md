# PARTE A — Pensar antes de escribir SQL

---

### Ejercicio A1

Mirando la tabla de arriba:

1\. ¿Qué columnas no se pueden repetir nunca?

ID, DNI y email.

2\. ¿Cuál es la clave primaria? ¿Cuáles son claves alternativas?

Clave primaria - id.

Alternativa - dni y email.

3\. ¿Qué columna apunta a otra tabla? ¿A cuál?

La de plan_id, apuntará a otra tabla que tenga ese id.

4\. El DNI ya identifica a cada socio. ¿Por qué crees que usamos un `id` numérico como clave primaria en vez del DNI? Da al menos una razón.

Imagino que porque el identificador no pretendemos modificarlo de ninguna forma, pero el dni a veces se escribe mal y es necesario hacer determinadas correcciones de vez en cuando. El id también se usa para identificador unico dentro de la base de datos, mientras que el dni sirve como identificador orientativo para la persona que trabaje con esa tabla.

---

### Ejercicio A2

| Pareja | Un A, ¿cuántos B? | Un B, ¿cuántos A? | Relación |
|---|---|---|---|
| planes – socios | muchos | Uno | 1:N |
| socios – tarjetas | Una | Una |1:1 |
| monitores – clases | Una o varias | Una | 1:N |
| socios – clases | Muchas | Muchas | N:M |
| monitores – especialidades | Muchas |  Muchas | N:M |

---

### Ejercicio A3

1\. Un monitor, ¿cuantas clases puede impartir?

MUCHAS

Una clase, ¿cuantos monitores puede tener?

UNO

2\. ¿En qué tabla va la clave ajena? ¿Cómo la llamarías?

En la tabla de clases. Tabla_clases

3\. Dibuja (en una tabla Markdown) cómo quedaría si la pusieras en el lado equivocado y explica en una frase por qué falla.

Solo se puede guardar un id en la clave ajena. Si se coloca en el lado equivocado, habría que volver a crear una columna con el monitor y su id repitiendolo para indicar que otras clases adicionales da.

4\. ¿Debe ser NOT NULL? ¿Por qué?

Sí, necesita que haya un valor dentro sí o sí, sino da error.

5\. ¿Qué tabla hay que crear primero?

Primero hay que crear la tabla de monitores.

---

### Ejercicio A4

1\. ¿Qué pasaría si quitásemos UNIQUE de socio_id? Explícalo con un ejemplo de datos.

Se volvería una relación 1:N. Un socio podría tener varias tarjetas a la vez.

2\. Hay dos columnas UNIQUE en tarjetas. ¿Qué evita cada una?

En la primera se evita que hayan varios códigos identificativos en las tarjetas y en la segunda se evita que el socio tenga varias.

3\. Inventa otra relación 1:1 de la vida real (fuera del gimnasio) y di en qué tabla pondrías la clave ajena.

La tarjeta consum. Sólo una única tarjeta puede pertenecer a un usuario con su dni.

---

### Ejercicio A5

1\. Un monitor, ¿cuántas especialidades puede tener?

MUCHAS

Una especialidad, ¿cuántos monitores puede tener?

MUCHOS

2\. ¿Qué tablas necesitas? Ponles nombre.

Tabla 1- Monitores

Tabla2- Especialidades

Tabla 3 - Especialidades_monitores

3\. Escribe las columnas de cada tabla y marca cuál es PK, cuál UNIQUE y cuál es FK.

### Tabla `monitores`

| Columna | Restricción |
|---|---|
| `id` | PK |
| `dni` | UNIQUE |
| `nombre` | NOT NULL |
| `email` | UNIQUE |

### Tabla `especialidades`

| Columna | Restricción |
|---|---|
| `id` | PK |
| `nombre` | UNIQUE, NOT NULL |

### Tabla `especialidades_monitores`

| Columna | Restricción |
|---|---|
| `id` | PK |
| `monitor_id` | FK → `monitores(id)` |
| `especialidad_id` | FK → `especialidades(id)` |
| `monitor_id` + `especialidad_id` | UNIQUE (combinación) |

4\. ¿Qué evita el UNIQUE de la tabla intermedia?

Evita que se repita la especialidad y el monitore a la vez un monitor pueda tener varias especialidades.

5\. ¿Qué tienen en común reservas y tu tabla intermedia? ¿En qué se diferencian?

Ambas son relaciones N:M y tienen tablas intermedias necesarias para que el programa conecte ambas claves ajenas.

---

### Ejercicio A6

1\.

# PARTE B — Construirlo en PostgreSQL


### Ejercicio B3
1\.INSERT INTO socios (dni, nombre, email, fecha_alta, plan_id)
VALUES ('99999999Z', 'Nora Prueba', 'nora@gym.com', '2026-10-27', 99);

    a\.Qué creo que pasará:

    Va a fallar porque no existe el id 99.

    b\.Código de error y explicación:

    DETAIL:  Key (plan_id)=(99) is not present in table "planes".

    ERROR: insertar o actualizar en la tabla "socios" viola la restricción de clave ajena "socios_plan_id_fkey"
    DETAIL: La clave (plan_id) = (99) no está presente en la tabla planes,

    (No se ha podido insertar a Nora porque porque el plan id no está presente en la tabla planes, solo hay cuatro. No ha habido un actualización en la tabla socios).

2\.INSERT INTO socios (dni, nombre, email, fecha_alta, plan_id)
VALUES ('99999999Z', 'Nora Prueba', 'ana@gym.com', '2026-10-27', 1);

    a\.Qué creo que pasará:

    Va a fallar porque no se puede repetir un correo electrónico al ingresar un socio nuevo.

    b\.Código de error y explicación:

    ERROR: Valor de clave duplicado que infringe la restricción de unicidad socios_email_key.
    DETAIL: La clave (email) = (ana@gym.com) ya existe.
    (El correo de ana@gym.com ya existe y no se puede duplicar esa clave).

3\.INSERT INTO tarjetas (codigo, activa, socio_id)
VALUES ('TJ-0099', TRUE, 1);

    a\.Qué creo que pasará:

    Solo un socio puede tener una tarjeta.

    b\.Código de error y explicación:

    ERROR: Valor de clave duplicado que infringe la restricción de unicidad tarjetas_socio_id_key.
    DETAIL: La clave (socio_id) = (1) ya existe.
    (No se puede duplicar la clave porque solo un socio puede tener una tarjeta).


4\.

    a\.Qué creo que pasará:

    Ya hay una informacion en una tabla de reservas con la reserva hecha.

    b\.Código de error y explicación:

    ERROR: Valor de clave duplicado que infringe la restricción de unicidad reservas_socio_id_clase_id_key.
    DETAIL: La combinación de claves (socio_id, clase_id) = (1, 1) ya existe.
    (La combinación de claves del socio ya existe en la base de datos).

5\.

    a\.Qué creo que pasará:

    La clase no existe. No hay ningúna fecha programada.


    b\.Código de error y explicación:

    ERROR: La inserción o actualización en la tabla reservas infringe la restricción de clave ajena reservas_clase_id_fkey.
    DETAIL: La clave (clase_id) = (50) no está presente en la tabla clases.
    (El id de la clase no existe en la base de datos).


6\.

    a\.Qué creo que pasará:

    No se puede borrar porque es una clave primaria.


    b\.Código de error y explicación:

    ERROR: La actualización o eliminación en la tabla planes infringe la restricción de clave ajena socios_plan_id_fkey de la tabla socios.
    DETAIL: La clave (id) = (1) sigue estando referenciada desde la tabla socios.
    (No se puede eliminar el plan porque hay socios asignados en él).

7\.

    a\.Qué creo que pasará:

    No dejará porque hay socios asignados.

    b\.Código de error y explicación:

    DELETE 1
    (Se ha eliminado porque no hay socios asignados).

8\.

    a\.Qué creo que pasará:


    b\.Código de error y explicación:


