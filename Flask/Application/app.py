from flask import Flask, render_template, request
from sqlalchemy import text
from database import engineer, connect, serialize
import json

app = Flask(__name__)


@app.route('/hello')
@app.route("/hello/<name>")
def hello(name=None):
    name = name or 'Zoroastre'
    return render_template('hello.html', user=name, route=app.url_for('hello', name='john'))
    # return f"<p>Hello, {name}</p>"


@app.route('/products')
def models():
    fields = ['first_name', 'last_name', 'biography']
    with connect(engineer()) as connector:
        result = connector.execute(text(f"SELECT {','.join(fields)} FROM author"))
        response = [serialize(data, fields) for data in result.all()]
        #response = [dict(row) for row in result.all()]
        return json.dumps(response)
