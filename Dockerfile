FROM python:3.8

WORKDIR .

RUN apt-get -y update  && apt-get install -y \
    python3-dev \
    apt-utils \
    python-dev \
    build-essential \   
&& rm -rf /var/lib/apt/lists/* 

RUN pip install --no-cache-dir -U pip
RUN pip install --no-cache-dir -U cython
RUN pip install --no-cache-dir -U numpy
RUN pip install --no-cache-dir -U pystan


# COPY requirements.txt .
COPY requirements_small.txt .

RUN pip install --no-cache-dir -U -r  requirements_small.txt

COPY src/ .

RUN chmod a+x start_script.sh

EXPOSE 8000

# CMD [ "uvicorn", "main:app", "--reload", "--workers", "1", "--host", "0.0.0.0", "--port", "8000"]

CMD ["./start_script.sh"]