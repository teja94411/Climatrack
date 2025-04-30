FROM node:alpine

# Set the working directory inside the container
WORKDIR /app

# Copy package.json and package-lock.json (for dependencies)
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application files
COPY . .

# Run the build command using npm (creates the production build)
RUN npm run build

# Install 'serve' to serve the build folder
RUN npm install -g serve

# Expose port 3000 for the application
EXPOSE 3000

# Serve the built application from the 'build' folder
CMD ["serve", "-s", "build", "-l", "3000"]
