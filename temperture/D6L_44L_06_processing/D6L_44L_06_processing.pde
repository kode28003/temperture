 
import processing.serial.*;
 
float[] tdata = new float[17]; // 温度を入れる配列(PTAT込みで来ることも考えて17要素分確保)
float tptat; // PTAT
String portName; // シリアルポート名
int serialport = 0; // 接続するシリアルポート番号を指定する
                    // Macの場合、/dev/tty.*のポートを選択してください。
String buf; // 受信バッファ
color[] tcolor = {#400040,#000080,#006060,#008000,#C0C000,#E0A000,#E00000,#F08080}; // 色テーブル
 float sum=0;
 float average=0;
 
Serial myPort;  // Create object from Serial class
 
void setup() {
  size(640,640);
  PFont font = createFont("Meiryo", 50);
textFont(font);
  println(Serial.list());
  portName = Serial.list()[serialport];
  myPort = new Serial(this, portName, 9600);
  myPort.clear();
 
}
void draw() {
  myPort.write(0x01); // データのリクエストをする
  delay(100); // 100ms待つ(すぐにシリアルポートの受信チェックをしないため)
  while (myPort.available() > 0) { // シリアルポートにデータが来ていたら
    delay(300); // 300ms待つ(データ全体が送信されるのを待つため)
    buf = myPort.readString(); // 受信
    myPort.clear();  // シリアルポート受信バッファのクリア
    tdata = float(split(buf, ','));  // データをカンマで分割し、floatで配列に格納
    for (int i = 0; i < 16; i++) { // 各エリアごとに色を設定し、四角を描画する
      if (tdata[i] < 0) {
        fill(tcolor[0]);
      } else if (tdata[i]+1.5 < 5) {
        fill(tcolor[1]);
      } else if (tdata[i]+1.5 < 10) {
        fill(tcolor[2]);
      } else if (tdata[i]+1.5 < 15) {
        fill(tcolor[3]);
      } else if (tdata[i]+1.5 < 20) {
        fill(tcolor[4]);
      } else if (tdata[i]+1.5 < 25) {
        fill(tcolor[5]);
      } else if (tdata[i]+1.5 < 35) {
        fill(tcolor[6]);
      } else  {
        fill(tcolor[7]);
      }
      rect((i % 4)*160, (i / 4)*160, (i % 4)*160+160, (i / 4)*160+160);
      if (tdata[i]<5) {fill(255);} else {fill(0);}
      textAlign(CENTER, CENTER);
      textSize(20);
      text(str(tdata[i]+1.5),(i % 4)*160+80, (i / 4)*160+80);
      sum=sum+(tdata[i]+1.5);
    }
    if(sum>=568){
    background(255);
    average=(sum/16);
    textAlign(CENTER, CENTER);
    textSize(30);
    text("あなたの体温は" ,width/4,height/4);
    text(str(average),width/2,height/2);
    text("℃" ,(width+250)/2,height/2);
    println("あなたの体温は、"+nf(average,2,1)+"です");
    }
    sum=0;
  }
}