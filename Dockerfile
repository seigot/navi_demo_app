# Ubuntu 22.04をベースイメージとして使用
FROM ubuntu:22.04

# 環境変数の設定
ENV DEBIAN_FRONTEND=noninteractive
ENV PYTHONUNBUFFERED=1

# 必要なパッケージのインストール
RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    python3-pyqt5 \
    python3-pyqt5.qtpositioning \
    python3-pyqt5.qtmultimedia \
    espeak \
    espeak-ng-data \
    libespeak-ng1 \
    libespeak-ng-dev \
    portaudio19-dev \
    python3-pyaudio \
    libsdl2-2.0-0 \
    libsdl2-mixer-2.0-0 \
    && rm -rf /var/lib/apt/lists/*

# 作業ディレクトリの設定
WORKDIR /app

# 必要なPythonパッケージのインストール
COPY requirements.txt .
RUN pip3 install -r requirements.txt

# アプリケーションのソースコードをコピー
COPY . .

# 環境変数の設定
ENV ORS_API_KEY="your_ors_api_key"
ENV FISHAUDIO_API_KEY="your_fishaudio_api_key"
ENV FISHAUDIO_MODEL_ID_EN="your_en_model_id"
ENV FISHAUDIO_MODEL_ID_JA="your_ja_model_id"

# アプリケーションの実行
CMD ["python3", "main.py"] 