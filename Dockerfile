# Use the official PHP image with Apache (PHP 8.2)
FROM php:8.2-apache

# Install necessary system dependencies and PHP extensions
RUN apt-get update && apt-get install -y \
    libpq-dev \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    unzip \
    zip \
    git \
    libzip-dev && \
    docker-php-ext-install pdo pdo_pgsql zip

# Enable Apache rewrite module
RUN a2enmod rewrite

# Set the working directory in the container
WORKDIR /var/www/html

# Copy the Laravel app files into the container
COPY . .

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Install PHP dependencies
RUN composer install --no-dev --optimize-autoloader

# Expose the web server port
EXPOSE 80

# Start the Apache server
CMD ["apache2-foreground"]