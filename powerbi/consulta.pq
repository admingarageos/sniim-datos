// Precios del SNIIM (Mercados Agricolas) para Power BI.
// Pegar en: Inicio > Obtener datos > Consulta en blanco > Editor avanzado.
// Cambiar solo las dos primeras lineas (Seccion y AnioInicial).
let
    // frutas_hortalizas, flores, granos, azucar, aceites o insumos
    Seccion = "frutas_hortalizas",
    // Primer anio a cargar. Hay datos desde 1998 (frutas y granos) o 2000 (el resto).
    // Frutas y hortalizas pesa mucho: cada anio son unas 600 mil filas.
    AnioInicial = 2020,

    Base = "https://raw.githubusercontent.com/admingarageos/sniim-datos/main/",
    AnioFinal = Date.Year(DateTime.LocalNow()),
    Anios = List.Numbers(AnioInicial, AnioFinal - AnioInicial + 1),

    // Un archivo por anio; si un anio no existe (404) se salta.
    Leer = (anio as number) =>
        let
            Respuesta = Web.Contents(
                Base,
                [
                    RelativePath = Seccion & "/" & Text.From(anio) & ".parquet",
                    ManualStatusHandling = {404}
                ]
            ),
            Estado = Value.Metadata(Respuesta)[Response.Status],
            Tabla = if Estado = 404 then null else Parquet.Document(Binary.Buffer(Respuesta))
        in
            Tabla,

    Tablas = List.RemoveNulls(List.Transform(Anios, Leer)),
    Todo = Table.Combine(Tablas)
in
    Todo
