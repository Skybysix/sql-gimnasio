# PARTE A — Pensar antes de escribir SQL

### Ejercicio A1

Mirando la tabla de arriba:

1. ¿Qué columnas no se pueden repetir nunca?

ID, DNI y email 

2. ¿Cuál es la clave primaria? ¿Cuáles son claves alternativas?

Clave primaria - id
Alternativa - dni y email 

3. ¿Qué columna apunta a otra tabla? ¿A cuál?

La de plan_id, apuntará a otra tabla que tenga ese id

4. El DNI ya identifica a cada socio. ¿Por qué crees que usamos un `id` numérico como clave primaria en vez del DNI? Da al menos una razón.

Imagino que porque el identificador no pretendemos modificarlo de ninguna forma, pero el dni a veces se escribe mal y es necesario hacer determinadas correcciones de vez en cuando. El id también se usa para identificador unico dentro de la base de datos, mientras que el dni sirve como identificador orientativo para la persona que trabaje con esa tabla.

### Ejercicio A2

| Pareja | Un A, ¿cuántos B? | Un B, ¿cuántos A? | Relación |
|---|---|---|---|
| planes – socios | muchos | Uno | 1:N |
| socios – tarjetas | Una | Una |1:1 |
| monitores – clases | Una o varias | Una | 1:N |
| socios – clases | Muchas | Muchas | N:M |
| monitores – especialidades | Muchas |  Muchas | N:M |

---

1.Un monitor, ¿cuantas clases puede imaprtir? 

MUCHAS
Una clase, ¿cuantos monitores puede tener?

UNO
2. ¿En qué tabla va la clave ajena? ¿Cómo la llamarías?
En la tabla de clases. Tabla_clases 

3. Dibuja (en una tabla Markdown) cómo quedaría si la pusieras en el lado equivocado y explica en una frase por qué falla.
Solo se puede guardar un id en la clave ajena. Si se coloca en el lado equivocado, habría que volver a crear una columna con el monitor y su id repitiendolo para indicar que otras clases adicionales da.
4. 
Sí, necesita que haya un valor dentro sí o sí
5. 
Primero hay que crear la tabla de monitores

