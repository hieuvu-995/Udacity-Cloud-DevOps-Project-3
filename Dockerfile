
FROM python:3.11-alpine

WORKDIR /app

COPY /analytics/ /app

RUN pip install -r /app/requirements.txt

ENV NAME python-env

CMD ["python", "app/app.py"]
CMD python app.py
