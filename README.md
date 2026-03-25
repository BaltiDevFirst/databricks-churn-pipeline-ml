# End-to-End Retail Churn Prediction Pipeline

## Visión General del Proyecto
Este proyecto resuelve un problema crítico de negocio en el sector retail: la fuga silenciosa de clientes (Churn). Mediante la construcción de un pipeline de datos escalable en la nube, el sistema ingesta transacciones crudas, procesa el historial del cliente creando una segmentación RFM (Recency, Frequency, Monetary) y entrena un modelo de Machine Learning distribuido para predecir qué clientes activos están en riesgo de abandonar la marca.

## Stack Tecnológico
* **Procesamiento Distribuido:** Apache Spark (PySpark)
* **Plataforma Data & AI:** Databricks (Serverless Compute)
* **Gobernanza y Almacenamiento:** Unity Catalog, Delta Lake (Medallion Architecture)
* **Machine Learning:** PySpark MLlib (Random Forest Classifier)
* **Infraestructura como Código (IaC):** Terraform, HCL
* **Cloud Provider:** Google Cloud Platform (GCP - Cloud Storage)

## Arquitectura del Pipeline
El flujo de datos sigue las mejores prácticas de la industria utilizando la **Arquitectura Medallón**:

1. **Infraestructura (Terraform):** Despliegue automatizado de un Data Lake (Cloud Storage Bucket en GCP) para la recepción de archivos CSV transaccionales crudos.
2. **Capa Bronze (Raw):** Ingesta de +500k registros transaccionales al entorno de Databricks utilizando Volumes de Unity Catalog.
3. **Capa Silver (Cleansed):** Limpieza distribuida con PySpark (manejo de nulos, casteo de timestamps, filtrado de devoluciones y cálculo de montos totales). Reducción del ruido en un 26%.
4. **Capa Gold (Business/Aggregated):** Agrupación a nivel cliente (+4,300 perfiles únicos) aplicando el modelo RFM y etiquetando el estado de Churn basado en reglas de negocio (>90 días sin compras).
5. **Machine Learning:** Transformación de variables continuas mediante `VectorAssembler` y entrenamiento de un modelo de Clasificación Binaria (Random Forest) para predecir la probabilidad de fuga futura.

## Impacto de Negocio
* Identificación automática de **1,449 clientes en estado de Churn**, permitiendo al equipo de Marketing dirigir campañas de retención (descuentos, email marketing) basadas en datos duros y no en intuición.
* Pipeline preparado para procesar millones de filas de forma eficiente, delegando la carga computacional al clúster Serverless de Databricks.

## Próximos Pasos (Evolución de la Arquitectura)
* Implementar orquestación por eventos (ej. GCP Cloud Functions) para disparar el Job de Databricks automáticamente cuando un nuevo archivo CSV aterrice en el Data Lake.
* Refinar el modelo predictivo ocultando la variable de recencia actual para evitar el *data leakage* y predecir el comportamiento del próximo mes.