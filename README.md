docker_minecraft
==

dockerでいろいろ試したときのやつ

## 環境

(Host OS)

```console
$ lsb_release -d
Description:	Ubuntu 20.04.4 LTS

$ uname -r
5.13.0-39-generic
```

## Dockerのインストール

### install `docker`

参考: https://docs.docker.com/engine/install/ubuntu/

```sh
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt update
sudo apt install docker-ce
sudo docker run --rm hello-world
```

### install `docker compose`

参考: https://docs.docker.com/compose/cli-command/#install-on-linux

```sh
DOCKER_CONFIG=${DOCKER_CONFIG:-$HOME/.docker}
mkdir -p $DOCKER_CONFIG/cli-plugins
curl -SL https://github.com/docker/compose/releases/download/v2.4.1/docker-compose-linux-x86_64 -o $DOCKER_CONFIG/cli-plugins/docker-compose
chmod +x $DOCKER_CONFIG/cli-plugins/docker-compose
docker compose version
```

- https://docs.docker.jp/compose/compose-file/compose-file-v3.html

## サービス

### init

初期化用イメージ(1回しか実行されないのにイメージが残り続けるのがキモすぎる。なんとかして)

- やってること
  - named volumeのパーミッションを一般ユーザーに変更する
  - eula.txtを作成
  - server.propertiesの編集
  - 今回はやってないけどバックアップ先からワールドデータを取ってきたりとか

### minecraft-server

マイクラサーバー本体

### send-command

minecraft-serverにRCON経由でコマンドを送る

### deno

deno実行用のイメージ(テンプレートとして残しているだけ)


## setup

一般ユーザーで実行。

- 環境変数の設定
- イメージのビルド
- initの実行

```sh
git clone https://github.com/a-happin/docker_minecraft.git
cd docker_minecraft
./init.sh
```

## send-command example

```sh
docker compose run --rm send-command help
docker compose run --rm send-command say hi
```


## メンテナンス

### 止める
```sh
docker update <running-container> --restart no
docker compose run --rm send-command stop
```

↓こっちでもできるようになった

```sh
docker update <running-container> --restart no
docker attach <running-container>
stop
```

### 再開
```sh
docker compose up -d minecraft-server
```

## upgrade world

Update minecraft-server/Dockerfile

```sh
docker compose build minecraft-server --no-cache
docker compose run --rm minecraft-server upgrade
```

確認が終わったら一旦`stop`して、再開する(compose run状態だと不都合がある(network,restart))
