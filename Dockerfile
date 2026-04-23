# Replace the entire end of your Dockerfile (from EXPOSE onward) with:

EXPOSE 10000

# Clear Laravel caches
RUN php artisan route:clear
RUN php artisan config:clear
RUN php artisan cache:clear

# Set permissions
RUN chown -R www-data:www-data /var/www/html \
    && chmod -R 775 /var/www/html/storage \
    && chmod -R 775 /var/www/html/bootstrap/cache

# Use PHP's built-in server on Render's PORT
CMD php artisan serve --host=0.0.0.0 --port=${PORT:-10000}
