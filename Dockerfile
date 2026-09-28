FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src

# Kopyahin muna ang project file gamit ang tamang folder path
COPY ["kos-server/kos-server.csproj", "kos-server/"]
RUN dotnet restore "kos-server/kos-server.csproj"

# Kopyahin ang lahat ng files at i-publish
COPY . .
WORKDIR "/src/kos-server"
RUN dotnet publish -c Release -o /app/publish

FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app
COPY --from=build /app/publish .
EXPOSE 30300
ENTRYPOINT ["dotnet", "kos-server.dll"]
