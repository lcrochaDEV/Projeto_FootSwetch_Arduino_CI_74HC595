# Projeto FootRouter Arduino CI 74HC595
### Projeto FootRouter Arduino CI 74HC595 "Projeto com Arduino Nano + CI 74HC595". 

Projeto em andamento...

[![](https://markdown-videos.deta.dev/youtube/edZq05Mqogc)](https://youtu.be/edZq05Mqogc)

Projeto de um footswitch com base em um projeto encontrado no site [instructables](https://www.instructables.com/arduino-programable-5-pedal-switcher/).

O projeto inicial consiste em apenas uma placa de Arduino nano, 5 módulos Relays de 5V, 10 leds de variadas cores, e uma placa PCB caseira criada no software Proteus ISIS.

Após um tempo de programação e novas idealizadas funcionalidades do projeto, foram adicionados dois CIs Shift Register (74HC595) para economia dos pinos
do Arduino, um para acionamento dos leds dos painel e outro para o acionamento dos canais e leds de visualização de acionamento.

O projeto ainda falta acrescentar o modulo de cartão de memória e toda programação em C, para salvar os presets em banco de dados. e estou estudando uma forma de trocar
os modulos relays por transistos PNP e NPN, e como se trata de um equipamnto de som, estou com dificuldade de retirar ruidos de acionamento das chaves.
