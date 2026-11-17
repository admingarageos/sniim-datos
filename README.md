# Precios del SNIIM — Mercados Agrícolas

Precios históricos publicados por el SNIIM (Sistema Nacional de Información e
Integración de Mercados, Secretaría de Economía, economia-sniim.gob.mx), en
archivos listos para Power BI. Se actualizan solos **cada jueves**.

Los datos se guardan tal como los publica el SNIIM, sin limpiar ni corregir.

## Qué hay

Un archivo por año en cada carpeta (`seccion/2025.parquet`).

| Carpeta | Qué es | Desde | Frecuencia | Columnas |
|---|---|---|---|---|
| `frutas_hortalizas` | Frutas y hortalizas, precio por kilogramo | 1998 | diaria | fecha, producto_id, producto, calidad, categoria, presentacion, origen, destino, precio_min, precio_max, precio_frec, obs |
| `flores` | Flores, precio por presentación comercial | 2000 | diaria | fecha, producto_id, producto, presentacion, origen, destino, precio_min, precio_max, precio_frec, obs |
| `granos` | Granos básicos | 1998 | semanal | fecha, producto_id, producto, origen, destino, precio_min, precio_max, precio_frec, obs |
| `azucar` | Azúcar | 2000 | diaria | fecha, producto_id, producto, destino, ingenio, precio, obs |
| `aceites` | Aceites comestibles | 2000 | semanal | fecha, producto, variedad, presentacion, destino, precio_min, precio_max, precio_frec, obs |
| `insumos` | Insumos agrícolas | 2000 | quincenal | fecha, producto, concentracion, presentacion, fuente, destino, municipio, precio_min, precio_max, precio_frec, obs |

`precio_frec` es el precio frecuente (el más común del día). `destino` es el
mercado donde se tomó el precio y `origen` de dónde viene el producto.
En `catalogos/` está la lista de productos de cada sección.

## Cómo abrirlo en Power BI (una sola vez)

1. Abre Power BI Desktop.
2. **Inicio → Obtener datos → Consulta en blanco**.
3. En la ventana que se abre: **Inicio → Editor avanzado**.
4. Borra lo que haya y pega todo el contenido de
   [`powerbi/consulta.pq`](powerbi/consulta.pq).
5. En las dos primeras líneas elige la sección y desde qué año quieres datos.
   Clic en **Listo**.
6. Si pregunta cómo conectarse, elige **Anónimo** y **Conectar**.
7. **Cerrar y aplicar**. Guarda el archivo.

Para otra sección, repite los pasos con otra consulta en blanco y cambia
`Seccion`.

## Cómo actualizar

Abre tu archivo de Power BI y da clic en **Actualizar**. Los datos nuevos se
publican los jueves por la mañana.

## Cosas que conviene saber

- Frutas y hortalizas es grande (unas 600 mil filas por año, 15 millones en
  total). Carga solo los años que necesites.
- En `insumos`, `precio_min` y `precio_max` vienen vacíos en muchas filas; usa
  `precio_frec`. En `aceites` vienen en 0 y el dato real está en `precio_frec`.
- El SNIIM trae errores de captura (precios atípicos, mínimo mayor que máximo)
  y en azúcar algunas filas repetidas. Se dejan como están.
- El SNIIM corrige datos después de publicarlos; por eso cada jueves se vuelven
  a bajar las últimas semanas completas.
