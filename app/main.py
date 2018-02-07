from flask_pymongo import PyMongo
from flask import Flask, render_template, request
from werkzeug import secure_filename

app = Flask(__name__)
mongo = PyMongo(app)

@app.route('/')
def home_page():
    online_users = mongo.db.users.find({'online': True})
    return render_template('index.html',
        online_users=online_users)

DB_NAME = "kidsandhope"
DB_HOST = "ds125618.mlab.com"
DB_PORT = 25618
DB_USER = "root"
DB_PASS = "root"

connection = MongoClient(DB_HOST, DB_PORT)
db = connection[DB_NAME]
db.authenticate(DB_USER, DB_PASS)

if __name__ == '__main__':
    app.run(debug=True,host="0.0.0.0")