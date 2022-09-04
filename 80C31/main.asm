/**************************LUCAS ROCHA****************************/
/*
   Portas Alalogicas A = 1,2,3,4,5,6,7.
   Portas Alalogicas/Digitais 14, 15, 16, 17, 18, 19, 20.
   Portas Digitais D = 2,3,4,5PWM,6PWM,7,8,9PWM,10PWM,11PWM,12.
   Data 12/09/2021
   VERSÃO 2 CI74HC595

   SKETCH ELABORADA PARA INTEGRANDO O CI74HC595 PARA ACIONAMENTO DOS LEDS DO PAINEL E RELAR.
   C:\Users\LuKInhas\AppData\Local\Temp\
*/
#define btn_1 2 //PIN_D2
#define btn_2 3 //PIN_D3
#define btn_3 4 //PIN_D4
#define btn_4 5 //PIN_D5
#define btn_5 6 //PIN_D6
#define pin_p 7 //BTN COMUM
#define pin_e 8 //EDIT MODE
#define pin_l 9 //LOOP MODE
#define dataPin 10 // 14 74HC595
#define clockPin 11 // 11 74HC595
#define latchPin 12 // 12 74HC595
#define tmpLongo 2000
#define tmpCurto 300

long tmpInicio;
byte ci74HC595[] = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0};
/*****************************************************************/
void setup() {
//put your setup code here, to run once:
  pinMode(btn_1, INPUT_PULLUP); //PIN_D2
//pinMode(btn_1, INPUT);        //PIN_D2
  pinMode(btn_2, INPUT_PULLUP); //PIN_D3
  pinMode(btn_3, INPUT_PULLUP); //PIN_D4
  pinMode(btn_4, INPUT_PULLUP); //PIN_D5
  pinMode(btn_5, INPUT_PULLUP); //PIN_D6
  pinMode(pin_p, OUTPUT);       //PIN_D7
  pinMode(pin_e, OUTPUT);       //PIN_A0
  pinMode(pin_l, OUTPUT);       //PIN_A1
  pinMode(latchPin, OUTPUT);
  pinMode(clockPin, OUTPUT);
  pinMode(dataPin, OUTPUT);

 testesLed();

//==============================COMUNICAÇÃO SERIAL==============================//
 Serial.begin(9600);
//==============================COMUNICAÇÃO SERIAL==============================//
}
//==================================CONVERSOR DECIMAL PARA BINÁRIO ACIONAMENTO LED A LED RELAY================================//
/* POSIÇÃO vai de 1-8 */
//void toggle(int posicao) {
//   //ci74HC595[posicao - 1] == 1 ? ci74HC595[posicao - 1] = 0 : ci74HC595[posicao - 1] = 1;
//   updateShift();
//}
void toggle(int posicao, int pin_ci) {
  //SELECIONA UM LED POR VEZ NO LOOP MOD
   for (int ci = 11; ci <= 16; ci++){
       ci74HC595[ci - 1] == 1 ? ci74HC595[ci - 1] = 0 : ci74HC595[pin_ci - 1] = 1;
    }
    //SELECIONDA OS LED RALAY EM MOD EDIT
     ci74HC595[posicao - 1] == 1 ? ci74HC595[posicao - 1] = 0 : ci74HC595[posicao - 1] = 1;
     updateShift();
}
void updateShift() {
  for (int j = 1; j <= 2; j++) {
    digitalWrite(latchPin, LOW); // baixa o portao para montar o BYTE
    for (int i = 0; i <= 7; i++) {
      digitalWrite(clockPin, LOW); // Avisa o Clock que vai ser escrito um BIT
      int posicao = i;
      j == 2 ? posicao = i + 8 : posicao = i;
      digitalWrite(dataPin, ci74HC595[posicao]); // Escreve o bit (BINARIO)
      digitalWrite(clockPin, HIGH); // Avisa o Clock que foi escrito um BIT
    }
    digitalWrite(latchPin, HIGH); // Avisa o Portão que terminamos de montar o BYTE, e ele já manda para o Shift
  }
}
//==================================CONVERSOR DECIMAL PARA BINÁRIO ACIONAMENTO LED A LED================================//

void bits_ci(int n) {
      digitalWrite(latchPin, LOW);
      digitalWrite(clockPin, LOW);
      shiftOut(dataPin, clockPin, LSBFIRST, 0B11111000); //0b11111000 = 0xF8
      digitalWrite(clockPin, HIGH);
      digitalWrite(latchPin, HIGH);
}

//==================================PAGA LED EM MOD EDIT DE 1 - 16==================================//
void zera_bit() {
  for (int i = 0; i <= 15; i++){
     ci74HC595[i - 1] = LOW ;
     updateShift();
  }
}
//==================================PAGA LED EM MOD EDIT DE 1 - 16==================================//
//===================================INICIALIZAÇÃO E TESTES LEDS================================//
void testesLed() {
  for (int i = 0; i < 2; i++) {
     //LEDS DOS RELAYs     
     for (int r = 3; r < 8; r++) {
       toggle(r, ' '); 
       //delay(50); 
     //LEDS DOS LEDS     
     for (int l = 11; l <= 16; l++) {
       toggle(l, ' '); 
      delay(50);
      }
    }
  } 
    digitalWrite(pin_e, HIGH);
    digitalWrite(pin_l, HIGH);    //INCIA EM LOOP MODE
    delay(400);
    digitalWrite(pin_e, LOW);
    toggle(' ', 11); 
}
//===================================INICIALIZAÇÃO E TESTES LEDS================================//
//===================================LOOP MOD================================//
void modLoop() {
  digitalWrite(pin_e, LOW);                     //APAGA O LED EDIT MOD
  digitalWrite(pin_l, HIGH);                    //ACIONA O LED LOOP MOD
}
//===================================LOOP MOD================================//
//===================================EDITAR MOD================================//
void edite() {
  digitalWrite(pin_e, HIGH);                    //ACIONA O LED EDIT MOD
  digitalWrite(pin_l, LOW);                     //APAGA O LED LOOP MOD
  zera_bit();
}
//===================================EDITAR MOD================================//
//===================================MENU SALVAR================================//
void salvar() {
  digitalWrite(pin_e, LOW);                     //APAGA O LED EDIT MOD
  digitalWrite(pin_l, LOW);                     //APAGA O LED LOOP MOD
}

void piscaSpeed() {                             //PISCA LED PARA CONFIRMAÇÃO DE SALVAMENTO EM MEMÓRIA
  int cont = 0; 
     while(cont >= 0){
      bits_ci(' ');
      delay(100);
      delay(100);
     //cont++;
     }
}
void loop() {
//put your main code here, to run repeatedly:
//**************TRIPLA FUNÇÃO**************BTN1//
// BOTÃO EDIT MOD
  tmpInicio = digitalRead(btn_1); //le o estado do botão - HIGH OU LOW
  if (digitalRead(btn_1) == LOW) {
    tmpInicio = millis();
    while ((millis() - tmpInicio < tmpLongo) && (digitalRead(btn_1) == LOW));
    if ((millis() - tmpInicio < tmpCurto)){         //CLICK E ACIOMA O LED1 SE O EDITI ESTIVER LOW
      if(digitalRead(pin_l) == HIGH){
        //digitalWrite(led1, !digitalRead(led1));
         toggle(' ', 11);
      }
      else if (digitalRead(pin_e) == HIGH){         //CLICK E ACIOMA O LED1 SE O EDITI ESTIVER HIGH
         toggle(3, ' ');
      }
    //PRESS 2s E ACIOMA O EDIT MOD E APAGA OS LED D1 - D5
    } else if ((millis() - tmpInicio >= tmpLongo)  && (digitalRead(pin_l) == HIGH)){   
      //digitalWrite(led1, !digitalRead(led1));
        edite(); 
      while (digitalRead(btn_1) == LOW);
    } else {                                          
      //PRESS 2s E ACIOMA O LOOP MOD SEM SALVAR
      //digitalWrite(led1, !digitalRead(led1));
      modLoop();
      while (digitalRead(btn_1) == LOW);
    }
  }
//**************TRIPLA FUNÇÃO**************BT2//
// BOTÃO SAVE MOD
  tmpInicio = digitalRead(btn_2); //le o estado do botão - HIGH OU LOW
  if (digitalRead(btn_2) == LOW) {
    tmpInicio = millis();
    while ((millis() - tmpInicio < tmpLongo) && (digitalRead(btn_2) == LOW));
    if (millis() - tmpInicio < tmpCurto) {
      if(digitalRead(pin_l) == HIGH){
        //digitalWrite(led1, !digitalRead(led1));
        toggle(' ', 12); 
      }else if (digitalRead(pin_e) == HIGH){         //CLICK E ACIOMA O LED1 SE O EDITI ESTIVER HIGH
        toggle(4, ' '); 
      }  
     //PRESS 2s E ACIOMA MOD SALVAR
    } else if ((millis() - tmpInicio >= tmpLongo) && (digitalRead(pin_e) == HIGH)){   
      //digitalWrite(led1, !digitalRead(led1));
       salvar();
       piscaSpeed();
      while (digitalRead(btn_2) == LOW);
    }
  }
//**************DUPLA FUNÇÃO**************//
  tmpInicio = digitalRead(btn_3); //le o estado do botão - HIGH OU LOW
  if (digitalRead(btn_3) == LOW) {
    tmpInicio = millis();
    while ((millis() - tmpInicio < tmpLongo) && (digitalRead(btn_3) == LOW));
    if (millis() - tmpInicio < tmpCurto) {
      if(digitalRead(pin_l) == HIGH){
        //digitalWrite(led1, !digitalRead(led1));
        toggle(' ', 13); 
      }else if (digitalRead(pin_e) == HIGH){         //CLICK E ACIOMA O LED1 SE O EDITI ESTIVER HIGH
        toggle(5, ' '); 
      }
    }
  }
  tmpInicio = digitalRead(btn_4); //le o estado do botão - HIGH OU LOW
  if (digitalRead(btn_4) == LOW) {
    tmpInicio = millis();
    while ((millis() - tmpInicio < tmpLongo) && (digitalRead(btn_4) == LOW));
    if (millis() - tmpInicio < tmpCurto) {
      if(digitalRead(pin_l) == HIGH){
        //digitalWrite(led1, !digitalRead(led1));
        toggle(' ', 14);
      }else if (digitalRead(pin_e) == HIGH){         //CLICK E ACIOMA O LED1 SE O EDITI ESTIVER HIGH
        toggle(6, ' '); 
      }
    }
  }
//**************DUPLA FUNÇÃO**************//
  tmpInicio = digitalRead(btn_5); //le o estado do botão - HIGH OU LOW
  if (digitalRead(btn_5) == LOW) {
    tmpInicio = millis();
    while ((millis() - tmpInicio < tmpLongo) && (digitalRead(btn_5) == LOW));
    if (millis() - tmpInicio < tmpCurto) {
      if(digitalRead(pin_l) == HIGH){
        //digitalWrite(led1, !digitalRead(led1));
        toggle(' ', 15);
      }else if (digitalRead(pin_e) == HIGH){         //CLICK E ACIOMA O LED1 SE O EDITI ESTIVER HIGH
        toggle(7, ' ');
      }
    } else if ((millis() - tmpInicio >= tmpLongo) && (digitalRead(pin_e) == HIGH)){
        //clearBanq();
        edite();
      }
  }
//**************TRIPLA FUNÇÃO**************//
}//fim loop

//C:\Users\LuKInhas\AppData\Local\Temp\arduino_build_570449\Bot_o_dupla_fun__o.ino.hex