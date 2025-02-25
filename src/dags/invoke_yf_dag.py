from airflow import DAG
from airflow.operators.python_operator import PythonOperator
from datetime import datetime
import boto3

# Configuración del DAG
default_args = {
    'owner': 'airflow',
    'start_date': datetime(2023, 10, 1),
    'retries': 1,
}

dag = DAG(
    'invoke_lambda_function',
    default_args=default_args,
    description='DAG para invocar una función en AWS Lambda',
    schedule_interval='@daily',  # Ejecución diaria
)

# Función para invocar Lambda
def invoke_lambda_function():
    lambda_client = boto3.client('lambda', region_name='us-east-1') 
    response = lambda_client.invoke(
        FunctionName='my_lamda_from_image',
        InvocationType='RequestResponse',
        Payload='{}',
    )
    print(response['Payload'].read().decode('utf-8'))

# Tarea en el DAG
invoke_lambda_task = PythonOperator(
    task_id='invoke_lambda',
    python_callable=invoke_lambda_function,
    dag=dag,
)

# Definir el flujo del DAG
invoke_lambda_task