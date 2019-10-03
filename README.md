# 2nd-keyboard
Todos os scripts do Taran - (não é apenas para o 2º teclado.)

Sou o editor primário do Linus Media Group. Postamos 1 ou mais videos por dia, e por isso tive que aprender a trabalhar rápido sem sacrificar qualidade.
Esses scripts de AutoHotKey agilizaram meu workflow significativamente. (Em sua maioria Premiere Pre e Explorer)

Fui pioneiro para o uso de teclados secundários somente para macros e depois, o conceito de amarrar keystroke dentro de keystroke, (ideaidealmente as teclas de super-função(F13-F24)) como uma forma de multiplicar o número de teclas únicas disponíveis.

------------

Adicionar um teclado secundário independente é uma tarefa notavelmente dificil devido ao fato do Windows não ter suporte nativo para distinguir de multiplos teclados. Existem diversas soluções que variam em dificuldade, funcionabilidade, estabilidade e preço. Abaixo está uma tabela que explica melhor para você. Minha solução de escolha pode não ser a melhor para seu caso:

https://docs.google.com/spreadsheets/d/18e6-OlUzc_1wbGvm9zqMOwtC4oysm6C7XMU1bOf8Nrc/edit?usp=sharing


#### Para resumir, se você quiser fazer seu próprio teclado de macro, esses são todos os métodos que conheço:
- Luamacros (Instável/bugado, não recomendado atualmente) https://youtu.be/Arn8ExQ2Gjg
- Interceptação https://youtu.be/y3e_ri-vOIo and https://youtu.be/Hn18vv--sFY
- iCue (K55) https://youtu.be/cQ2atofn3lE
- Razer Synapse (Cyonosa Chroma) https://youtu.be/GttedCcyxa4
- QMK (Conversor USB Hasu, meu método atual.) https://youtu.be/GZEoss4XIgc

#### Outros métodos que não testei
- Existe o MacroMyKBD - (Novo, não testado, não tenho ideia de como funciona. Seria ótimo se alguém puder testar e dar o feedback)  https://github.com/lal12/macroMyKBD
- Existe também o 2key que usa um Raspberry Pi. - (Não testado, também não tenho ideia de como funciona. Me conte se testar!) https://github.com/Gum-Joe/2Keys/blob/v0.3.5/docs/SETUP.md

Se isso tudo estiver parecendo somente um incómodo, use o Stream Deck no lugar: https://youtu.be/vhPLhfP1b_s

Nota: Você não precisa de um 2º teclado para usar o AutoHotKey. Amaioria não usa e quando você precisar de um 2º teclado, já deve estar familiarizado em como o AutoHotKey funciona. Você provavelmente pode usar suas téclas de função paraAHK macros e se seu teclado primário tiver teclas macro, também é possivel utilizar estas.

Resumindo, você não precisa adicionar um teclado secundário por parecer legal! Faça isso somente se for precisa, como no caso de acabar o espao no teclado primário.

## meus scripts AHK 

Se voce é novo com o AUTOHOTKEY, comece aqui:
https://autohotkey.com/docs/Tutorial.htm

Seu que tem muitos scripts nesse repositório. Olhe aqui o que inicia junto ao meu computador:
https://github.com/TaranVH/2nd-keyboard/blob/master/INFO_and_PROFILES/startup_folder_TARAN_Aug_2018.png

Alguns screipts estão inclusos em outros scripts. O script principal da qual a maioria depende é este - portanto, você pode começar aqui: https://github.com/TaranVH/2nd-keyboard/blob/master/ALL_MULTIPLE_KEYBOARD_ASSIGNMENTS.ahk

Alguns scripts são independentes, como esse aqui: https://github.com/TaranVH/2nd-keyboard/blob/master/Taran's_Windows_Mods/Both_Accelerated_Scrolling_1.3_AND_Cursor_click_visualizer.ahk

Para ver como estes scripts entram em ação durante o trabalho, assista nmeu vídeo "World's Most Advanced Editing Tutorial" https://www.youtube.com/watch?v=O6ERELse_QY

Por favor, saiba que não sou um programador(nesta vida.) Minha organização pode ser ruim e meu código desajeitado. Escrevi muita documentação, então se você sabe programar, deve ser até que facil para entender o que está acontecendo.

Ajuda com este repositório é apreciada, porém não fique triste se eu nunca oficialmente fundir seus scripts. Não posso confiar em nada que nunca testei totalmenteou algo com código que não reconheço ou entendo. Esses são meus scripts de trabalho diário, então não posso compromete-los para ninguém.

As vezes posto tutoriais no meu canal pessoal: https://www.youtube.com/user/TaranVH/videos .e as vezes faço "reverse tutorials" onde sou eu quem pergunta.

Twitter é provavelmente o método mais eficiente de me contatar: https://twitter.com/TaranVH

Você é livre para usar qualquer desses scripts para si mesmo. Modifique para suas necessidades, modifique aos seus desejos.

Meu script mais simples, mais usado e mais útil é esse: https://www.youtube.com/watch?v=OqyQABySV8k

-----

Para ver todos os eus códigos scaneados e téclas virtuais, olhe nesta tabela: https://docs.google.com/spreadsheets/d/1GSj0gKDxyWAecB3SIyEZ2ssPETZkkxn67gdIwL1zFUs/edit?usp=drive_web&ouid=107638578296445823789

-----

Em agosto de 2018, troco o diretório raiz deste:

**C:\Users\TaranWORK\Documents\GitHub\2nd-keyboard**

para este:

**C:\AHK\2nd-keyboard**

que é uma grande melhoria já que usuários não precisam mais trocar todas as instancias espalhadas de "TaranWORK" para seu próprio usuário. Agora uma grande quntidade de scripts estão pré-ativos des de que você não movca nada ou troque caminhos de arquivos.

Isso também significa que os scripts de inicialização do Corsair K95 e Stream Deck estão habilitados de imediato.

A unida desvantagem é que esses scripts AHK estão disponíveis para todos os usuários na máquina. Se você compartilha o computador, recomendo move-los para um novo usuário.

Certifique-se de encher sua pasta de inicio com atalho de arquivos para inicializar todos os scripts que quiser no momento que o computador inicializar. SAIBA que tem duas pastas de inicialização - uma para seu usuário e outra para TODOS usuários. aqui estão elas:

*C:\ProgramData\Microsoft\Windows\Start Menu\Programs\StartUp*

*C:\Users\TaranWORK\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup*

---

**Se já está pronto para começar, olhe esses repositórios interessantes que são semelhantes**

https://github.com/TaranVH/2nd-keyboard/pull/27 (Instalação facil do Interception)

https://github.com/evilC/AutoHotInterception

https://github.com/sebinside/AHK2PremiereCEP

Mais informações em como usar o Adobe CEP:

https://www.youtube.com/channel/UCmq_t_-4GLFu_nYaEDDModw/videos

https://github.com/Adobe-CEP/Samples/blob/master/PProPanel/jsx/PPRO/Premiere.jsx

This is a PT-BR translation made by Gabriel T. Kamigauti(@GTKamigauti)
