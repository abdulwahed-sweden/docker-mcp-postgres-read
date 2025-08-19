from sqlalchemy import create_engine, text

def get_engine():
    # Connect as readonly user on host port 5431
    url = "postgresql+psycopg2://readonly:readonly123@localhost:5431/company"
    return create_engine(url, echo=False, future=True)

def run_sql(query: str):
    engine = get_engine()
    with engine.connect() as conn:
        result = conn.execute(text(query))
        rows = result.mappings().all()
        return [dict(r) for r in rows]
