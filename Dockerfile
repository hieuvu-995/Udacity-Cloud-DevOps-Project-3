
FROM python:3.11-slim

WORKDIR /app

COPY /analytics/ /app

RUN pip install --no-cache-dir -r /app/requirements.txt

EXPOSE 5153

CMD ["python", "app/app.py"]
CMD python app.py
