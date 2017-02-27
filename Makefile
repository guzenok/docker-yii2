manual:
	docker build -t guzenok/yii2:nginx-latest ./nginx
	docker build -t guzenok/yii2:php-latest ./php-fpm

clean:
	docker rmi guzenok/yii2:php-latest
	docker rmi guzenok/yii2:nginx-latest
