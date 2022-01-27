import gspread
import json
from oauth2client.service_account import ServiceAccountCredentials 
import socket

scope = ['https://spreadsheets.google.com/feeds','https://www.googleapis.com/auth/drive']

credentials = ServiceAccountCredentials.from_json_keyfile_name('C:/Users/elect/Desktop/temperture/temperture-de596cec81a2.json', scope)
gc = gspread.authorize(credentials)
SPREADSHEET_KEY = '1r0gIzGHF7HQ5Ia3r0uMZNsSLcv5epzjjprAJxt_W57Q'
workbook = gc.open_by_key(SPREADSHEET_KEY)
worksheets = workbook.worksheets()
print(worksheets)
worksheet = workbook.worksheet('シート1')


def next_available_row(sheet1):
    str_list = list(filter(None, sheet1.col_values(2))) #col_valuesで列指定
    return str(len(str_list)+1)


# next_row = next_available_row(worksheet)
# worksheet.update_cell(next_row, 2, 'add') #体温の受信


HOST = ''                 # Symbolic name meaning all available interfaces
PORT = 50007              # Arbitrary non-privileged port
with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as s:
    s.bind((HOST, PORT))
    s.listen(1)
    conn, addr = s.accept()
    with conn:
        print('Connected by', addr)
        while True:
            data = conn.recv(4)
            if not data: break
            next_row = next_available_row(worksheet)
            a=str(data)
            worksheet.update_cell(next_row, 2, a.replace('b', '')) #体温の受信
            print(a.replace('b', ''))