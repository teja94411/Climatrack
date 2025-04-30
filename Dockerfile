# FROM node:alpine

# # Set the working directory inside the container
# WORKDIR /app

# # Copy package.json and package-lock.json (for dependencies)
# COPY package*.json ./

# # Install dependencies
# RUN npm install

# # Copy the rest of the application files
# COPY . .

# # Run the build command using npm (creates the production build)
# RUN npm run build

# # Install 'serve' to serve the build folder
# RUN npm install -g serve

# # Expose port 3000 for the application
# EXPOSE 3000

# # Serve the built application from the 'build' folder
# CMD ["serve", "-s", "build", "-l", "3000"]


# Step 1: Build the React app
FROM node:18 AS build

WORKDIR /app

COPY package*.json ./
RUN npm install

COPY . .
RUN npm run build

# Step 2: Serve the built app using `serve`
FROM node:18-slim

WORKDIR /app

# Install 'serve' to serve the static files
RUN npm install -g serve

# Copy only the build folder from the previous stage
COPY --from=build /app/build ./build

# Expose the port
EXPOSE 3000

# Start the app
CMD ["serve", "-s", "build", "-l", "3000"]
