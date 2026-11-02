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
| monitores – clases | Una o varias | Una |N:1 |
| socios – clases | Muchas | Muchas | N:M |
| monitores – especialidades | Muchas |  Muchas | N:M |

---