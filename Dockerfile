# Estágio de Build: Constrói a sua aplicação
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /app

# Copia o arquivo .csproj e restaura as dependências
COPY "SalesWebMvc.csproj" .
RUN dotnet restore

# Copia o resto dos arquivos e faz o build
COPY . .
RUN dotnet publish "SalesWebMvc.csproj" -c Release -o /app/publish

# Estágio de Runtime: Roda a aplicação
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS final
WORKDIR /app
COPY --from=build /app/publish .

# O ENTRYPOINT está correto, pois o nome da .dll é o mesmo do .csproj
ENTRYPOINT ["dotnet", "SalesWebMvc.dll"]