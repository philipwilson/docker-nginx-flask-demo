import logging

from flask import Flask
app = Flask(__name__)

logging.basicConfig(filename='foo.log', level=logging.DEBUG)


@app.before_request
def before_request():
    from flask import request
    with open("hack.txt", 'a') as f:
        f.write(repr(request.url + "\n"))
    logging.info(request.url)

@app.route("/")
@app.route("/hello/")
def hello():
    return "Hello World!"

if __name__ == "__main__":
    app.run(host='0.0.0.0', port=8080)
