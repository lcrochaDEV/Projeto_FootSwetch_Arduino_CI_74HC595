# Projeto FootRouter Arduino CI 74HC595
### Projeto FootRouter Arduino CI 74HC595 "Projeto com Arduino Nano + CI 74HC595". 

Projeto em andamento...

[![](https://markdown-videos.deta.dev/youtube/edZq05Mqogc)](https://youtu.be/edZq05Mqogc)

Projeto de um footswitch com base em um projeto encontrado no site [instructables](https://www.instructables.com/arduino-programable-5-pedal-switcher/).

#### Hístoria do Projeto

O projeto inicial consiste em apenas uma placa Arduino Nano, 5 módulos Relays de 5V, 10 leds de variadas cores, e uma placa PCB caseira criada no software Proteus ISIS.

##### Esquemático
![](https://github.com/lcrochaDEV/Projeto_FootSwetch_Arduino_CI_74HC595/blob/main/Esquema.PNG)

#### Layout PCB
![](https://github.com/lcrochaDEV/Projeto_FootSwetch_Arduino_CI_74HC595/blob/main/pcb.PNG)

Após um tempo de programação em Lingueagem C e novas idealizadas novas funcionalidades ao projeto, foram adicionados dois CIs Shift Register (74HC595) para economia de pinos do Arduino, um CI para acionamento dos leds dos painel e outro para o acionamento dos canais e leds de visualização de acionamento.

Segue links de artigos sobre o CI 74HC595 Shift Register:
1. [rastating.github.io](https://rastating.github.io/using-a-74hc595-shift-register-with-an-arduino-uno/)
2. [pijaeducation.com](https://pijaeducation.com/arduino/seven-segment/shift-register-ic-74hc595/)
3. [docs.arduino.cc](https://docs.arduino.cc/tutorials/communication/guide-to-shift-out)

O projeto ainda falta acrescentar o modulo de cartão de memória e toda programação em C, para salvar os presets em banco de dados (Card SD).

Estou estudando uma forma de trocar os modulos relays por transistos PNP e NPN, e como se trata de um equipamnto de som, estou com dificuldade de retirar ruidos de acionamento das chaves.
