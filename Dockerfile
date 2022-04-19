# Dockerfile
FROM python:3.8

WORKDIR /app
RUN pip install -e git+https://github.com/DataBiosphere/toil.git@c4dd55c38d781d151ba5df82530b49cc21981356#egg=toil[cwl,wdl,server] && chmod g+r -R /app

CMD ["toil", "server", "--opt=--logLevel=CRITICAL", "--host", "0.0.0.0"]
