from flask import Flask
import pymysql

app = Flask(__name__)

@app.route('/')
def hello():
    return "Hello, World!"

@app.route('/db')
def db_test():
    connection = pymysql.connect(host='db',
                                 user='user',
                                 password='password',
                                 database='testdb')
    cursor = connection.cursor()
    cursor.execute("SELECT VERSION()")
    version = cursor.fetchone()
    return f"MySQL version: {version[0]}"

if __name__ == '__main__':
    app.run(host='0.0.0.0')

