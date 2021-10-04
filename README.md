## Let's go :D

## Para começar importe a base de dados api_database.sql

## Para instalar a API backend bosta rodar o comando:

```
cd laravel-api
composer install
```

## Apos isso, renomeie o arquivo .env.example para .env e configure os dados do banco


```
DB_CONNECTION=mysql
DB_HOST=127.0.0.1
DB_PORT=3306
DB_DATABASE=laravel
DB_USERNAME=root
DB_PASSWORD=
```

## Rode o comando

```
php artisan key:generate
```

## Para iniciar o BACKEND

```
php artisan serve
```

## Para configurar as dependencias do FrontEnd comece pelo comando:

```
cd vue
npm install
```

## O endereço da API BackEnd está localizada no arquivo /vue/src/services/services.js 

```
const axiosInstance = axios.create({
  baseURL: "http://localhost:8000/api/",
});

```




