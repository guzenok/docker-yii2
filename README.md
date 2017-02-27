# Docker images for Yii2 app

There are two docker-image:
 - guzenok/yii2:php-latest with php-fpm, installs yiisoft/yii2-app-basic (if need), installs dependencies from composer.json (if need), and runs php-frm;
 - guzenok/yii2:nginx-latest with nginx, hosts your yii2-app;

## Usage example

`docker-compose.yml`
```
version: '2'
services:

    db:
        image: mysql/mysql-server:5.7
        volumes:
            - ./mysql:/docker-entrypoint-initdb.d/
        environment:
            MYSQL_ROOT_PASSWORD: xyz
            MYSQL_DATABASE: ${DB_NAME}
            MYSQL_USER: ${DB_USER}
            MYSQL_PASSWORD: ${DB_PASS}
        networks:
            - code-network

    app:
        image: guzenok/yii2:php-latest
        environment:
                DB_HOST: db
                DB_NAME: ${DB_NAME}
                DB_USER: ${DB_USER}
                DB_PASS: ${DB_PASS}
                GITHUB_OAUTH_TOKEN: ${GITHUB_OAUTH_TOKEN}
        volumes:
            - ./yii2/:/var/www/html/
        depends_on:
            - db
        networks:
            - code-network

    nginx:
        image: guzenok/yii2:nginx-latest
        ports:
            - "8080:80"
        depends_on:
            - app
        volumes_from:
            - app
        networks:
            - code-network

networks:
    code-network:
        driver: bridge

```
where ./yii2/ is directory for yii2-app.
