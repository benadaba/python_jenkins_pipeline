# Use the official Python image from the Docker Hub
# FROM python:3.9-slim
FROM python:3.8.19-alpine

# Set the working directory in the container
WORKDIR /app

# Copy the requirements file into the container
COPY requirements.txt requirements.txt

# Install the required dependencies
RUN pip install --upgrade pip -y
RUN pip install -r requirements.txt

# Copy the rest of the application code
COPY . .

# Expose the port that the Flask app runs on
EXPOSE 5000

# Specify the command to run the application
CMD ["python", "app/main.py"]
