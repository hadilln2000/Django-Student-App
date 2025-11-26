# Use a lightweight, official Python image
FROM python:3.12-slim

# Set environment variables so Python doesn't buffer output (good for logs)
ENV PYTHONUNBUFFERED 1

# Set the working directory for the application inside the container
WORKDIR /app

# Copy requirements and install packages first (leverages Docker cache)
COPY requirements.txt /app/
RUN pip install --upgrade pip && pip install -r requirements.txt

# Copy the entire Django project code
COPY . /app/

# Expose the port
EXPOSE 8000

# Collect static files (CSS, JS) into the STATIC_ROOT directory defined in settings.py
# This command must be run inside the Docker build process
RUN python manage.py collectstatic --noinput

# The final command: run the gunicorn production server
# CRITICAL: If your project folder is named something other than 'djangoproject', 
# replace 'djangoproject.wsgi:application' below with 'yourprojectname.wsgi:application'
CMD ["gunicorn", "djangoproject.wsgi:application", "--bind", "0.0.0.0:8000"]