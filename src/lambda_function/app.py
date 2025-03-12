import boto3
import time
import os

INSTANCE_ID = os.getenv("INSTANCE_ID")
DAGS_TO_TRIGGER = ["dag1", "dag2"]

ssm = boto3.client("ssm")
ec2 = boto3.client("ec2")

def get_public_ip(instance_id):
    """ Obtiene la IP pública de la instancia EC2 """
    response = ec2.describe_instances(InstanceIds=[instance_id])
    return response["Reservations"][0]["Instances"][0].get("PublicIpAddress")

def execute_command_on_ec2(instance_id, command):
    """ Ejecuta un comando en EC2 usando SSM """
    response = ssm.send_command(
        InstanceIds=[instance_id],
        DocumentName="AWS-RunShellScript",
        Parameters={"commands": [command]},
    )
    command_id = response["Command"]["CommandId"]
    print(f"✅ Comando enviado con ID: {command_id}")

    # Esperar hasta que el comando termine
    for _ in range(10):
        time.sleep(5)
        output = ssm.get_command_invocation(CommandId=command_id, InstanceId=instance_id)
        if output["Status"] in ["Success", "Failed"]:
            print(f"⏳ Salida del comando: {output['StandardOutputContent']}")
            return output["Status"]
    return "Timeout"

def lambda_handler(event, context):
    # Iniciar la instancia si está detenida
    ec2.start_instances(InstanceIds=[INSTANCE_ID])
    print(f"Instancia {INSTANCE_ID} iniciada.")

    # Esperar a que tenga IP pública
    public_ip = None
    for _ in range(10):
        public_ip = get_public_ip(INSTANCE_ID)
        if public_ip:
            break
        time.sleep(10)

    if not public_ip:
        return {"status": "error", "message": "No se obtuvo la IP pública"}

    # Ejecutar comandos en EC2
    execute_command_on_ec2(INSTANCE_ID, "airflow scheduler & airflow webserver &")
    print("✅ Airflow activado en EC2.")

    return {"status": "success", "message": "Airflow iniciado"}