FROM mcp/postgres:latest

# Add custom configurations if needed
ENV POSTGRES_READONLY_USER=query_user
EXPOSE 8080

HEALTHCHECK --interval=30s --timeout=3s \
  CMD curl -f http://localhost:8080/health || exit 1