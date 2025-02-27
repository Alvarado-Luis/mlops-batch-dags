FROM public.ecr.aws/lambda/python:3.9

# Copia los archivos de tu proyecto a la imagen
COPY requirements.txt .
RUN pip install -r requirements.txt

# Copia el código fuente
COPY app.py ${LAMBDA_TASK_ROOT}

# Comando para ejecutar la función Lambda
CMD ["app.lambda_handler"]