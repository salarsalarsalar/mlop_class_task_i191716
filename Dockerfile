# Use an official Python runtime as the base image
FROM python:3.9-slim AS base

# Set the working directory in the container
WORKDIR /app

# Copy the dependencies file to the working directory
COPY requirements.txt .

# Install any needed packages specified in requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Intermediate build stage for copying source code
FROM base AS builder

# Create a directory to hold the application code
RUN mkdir /app/src

# Copy the current directory contents into the container at /app/src
COPY . /app/src

# Final stage
FROM base AS final

# Set the working directory to the directory created in the previous stage
WORKDIR /app

# Copy the application directory from the builder stage
COPY --from=builder /app/src /app

# Optionally, you can expose ports or specify any other runtime configurations here


# Make port 5000 available to the world outside this container
EXPOSE 5000

# Define environment variable
ENV FLASK_APP=app.py

# Command to run the application
CMD ["python", "app.py"]
CMD ["flask", "run", "--host=0.0.0.0"]