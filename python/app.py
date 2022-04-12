
from flask import Flask, render_template, request, redirect, url_for


app = Flask(__name__)


@app.route('/')
def index():
    name = request.args.get('name', 'World')
    return f'<h1>Hello {name}!</h1>'


if __name__ == "__main__":
    app.run(debug=True)
