# ========================
# STAGE 1: Build
# ========================
FROM mcr.microsoft.com/dotnet/sdk:9.0 AS build
WORKDIR /src

# Copy csproj and restore as distinct layers
COPY *.csproj ./
RUN dotnet restore

# Copy everything else and build
COPY . ./
RUN dotnet publish -c Release -o /app/publish

# ========================
# STAGE 2: Runtime
# ========================
FROM mcr.microsoft.com/dotnet/aspnet:9.0 AS final
WORKDIR /app

COPY --from=build /app/publish .

# Expose port (เช่น 80 หรือ 8080 แล้วแต่แอปคุณ)
EXPOSE 5000

# Start the application
ENTRYPOINT ["dotnet", "AZ2003.dll"]
