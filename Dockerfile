FROM python:3.10-bookworm

ENV PYTHONUNBUFFERED=1 \
    PYTHONDONTWRITEBYTECODE=1

RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    gcc \
    gfortran \
    libfftw3-dev \
    libgsl-dev \
    glpk-utils \
    libglpk-dev \
    curl \
    git \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt

COPY foton_null_test.py .
COPY null_test.py .
COPY PQG_FULL_CATALOG_SCAN_PLOT.py .
COPY PQG_photon_channel.py .

RUN mkdir -p GWTC5_RUN
COPY GWTC5_RUN/events.csv ./GWTC5_RUN/events.csv

RUN mkdir -p PQG_null_test_results plots_catalog PQG_Photon_channel TTE_data

CMD ["/bin/bash"]
