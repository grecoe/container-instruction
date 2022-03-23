FROM mcr.microsoft.com/dotnet/aspnet:3.1 AS base
WORKDIR /app
EXPOSE 80
EXPOSE 443

FROM mcr.microsoft.com/dotnet/sdk:3.1 AS build
WORKDIR /src
COPY ["FirstApi.csproj", "."]
RUN dotnet restore "./FirstApi.csproj"
COPY . .
WORKDIR "/src/."
RUN dotnet build "FirstApi.csproj" -c Debug -o /app/build

FROM build AS publish
RUN dotnet publish "FirstApi.csproj" -c Debug -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "FirstApi.dll"]