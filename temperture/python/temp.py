
import gspread
import json
from oauth2client.service_account import ServiceAccountCredentials 
import serial
 
ser = serial.Serial('COM3',9600,timeout=None)   # '/dev/ttyUSB0'の部分は自分の環境に合わせて変更する
 
while True:
    line = ser.readline()
    print(line)
 
ser.close()      

# scope = ['https://spreadsheets.google.com/feeds','https://www.googleapis.com/auth/drive']

# credentials = ServiceAccountCredentials.from_json_keyfile_name('C:/Users/elect/Desktop/temperture/temperture-de596cec81a2.json', scope)
# gc = gspread.authorize(credentials)
# SPREADSHEET_KEY = '1r0gIzGHF7HQ5Ia3r0uMZNsSLcv5epzjjprAJxt_W57Q'
# workbook = gc.open_by_key(SPREADSHEET_KEY)

# worksheets = workbook.worksheets()
# print(worksheets)
# worksheet = workbook.worksheet('シート1')
# worksheet.update_cell(2, 1, '3')