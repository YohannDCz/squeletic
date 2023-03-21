import sqlalchemy

def engineer():
    # return sqlalchemy.create_engine("sqlite+pysqlite:///:memory:", echo=True)
    return sqlalchemy.create_engine("mysql+mysqlconnector://root:root@localhost:8889/squeletic_v1", echo=True)

def connect(engine):
    return engine.connect()

def serialize(row, fields):
    return {field:  getattr(row, field) for field in fields}
