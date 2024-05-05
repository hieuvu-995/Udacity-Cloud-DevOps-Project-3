
FROM python:3.11-alpine

WORKDIR /app

COPY /analytics/ /app

RUN pip install -r /app/requirements.txt

EXPOSE 5000

ENV NAME python-env

CMD ["python", "app/app.py"]
CMD python app.py
