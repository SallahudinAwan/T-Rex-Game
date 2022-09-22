[org 0x0100]         
 jmp  start 

;//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////	 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;Project T-Rex Game;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                               ;Made by Sullahudin Awan	 

;Outputs
credit: db'Credit Goes to'
salman: db 'Sir Salman Mubarik'
message0: db 'Enter the Player Name : $'
PressEnter: db      'Press Space and then Press Enter to Start the Game' 
clearPressEnter: db '                                                  '
trex: db 'T-REX Game'	  
Game: db 'PlAY Game Now'
Player1: db 'Player : '
Player2: db 'Player 2 : '
detail: db 'Details';7
pressS: db '1-Press Space for Jump';22
Shift: db '2-Press Shift to Restart the Game';33
mored: db'3-Score represent Curr Score and';32
mored2: db '  HScore Represents Higest Score';32
sallu: db 'Sallahudin & Adbullah'
endingstr: db 'Game Over'
clearendingstr: db '         '
Sco: db 'SCORE : '
HSco: db 'HSCORE:'
message:      db   '-'      ; string to be printed 
message1: db 0x01
message2: db '~'
message3: db 0xDB
spc: dw ' '
space: db ' '


;Dinasaur Coordinates
rowvalue: db 13
colvalue: db 4

;Dinasaur Body Parts
legs:  db 13h
body : db "|"



;Other Variables
PScore: dw 0
Hscore: dw 0
endgame: db 1
OISR: dw 0,0 
oldkb: dd   0 
seconds:    dw  0 
timerflag:    dw   0
set:          dw 0
x: db 0
olddi: dw 0 


;coordinates of Hurdles
y1: db 60;0x3C
y2: db 61;0x3D
y3: db 62;0x3E
y4: db 63;0x3F
;3 pillars
y6: db 68;0x26 
y5: db 70;0x28 
y7: db 72;0x2A 
;1st Pillar
y8:  db 25;0x19
y9:  db 74
y10: db  76

;Buffer for Input from user
buffer: db 80 ; Byte # 0: Max length of buffer
        db 0 ; Byte # 1: number of characters on return
times 80 db 0 ; 80 Bytes for actual buffer space


;//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;Project T-Rex Game (Main Working Start);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


;This Sub-Routine Gets Input from User
;the Player Name and then display in the main window 
EnterPlayername:

mov dx, message0 ; message to print
mov ah, 9 ; service 9 – write string
int 0x21 ; dos services

mov dx, buffer ; input buffer (ds:dx pointing to input buffer)
mov ah, 0x0A ; DOS' service A – buffered input
int 0x21 ; dos services call
ret

;This Sub-Routine Prints the Line of on the Screen 
;Where the hurdles Move and Where Dinasaur Stand
Printline:
              push bp      
              mov  bp, sp        
              push es           
              push ax  
              push bx			  
              push cx
              push dx			  
              push si          
              push di 
              mov dl,1
			   mov dh,16
			  mov  ah, 0x13           ; service 13 - print string 
              mov  al, 1              ; subservice 01 – update cursor        
              mov  bh, 0              ; output on page 0         
              mov  bl, 11             ; normal attributes         
              mov  cx, 1             ; length of string       
              push cs    
              pop  es                 ; segment of string   
			  l1:
			  mov  bp, message       ; offset of string
              int  0x10               ; call BIOS video service 
              add dl,1
			  cmp dl,79
			  jne l1
			  mov  al, 0x20     
			  out  0x20, al           ; end of interrupt 
			  pop  di           
			  pop  si  
              pop  dx			  
			  pop  cx
              pop  bx			  
			  pop  ax        
			  pop  es       
 			  pop  bp      
              ret
;This Sub-Routine Just Print the Name of Game which is T-Rex Game  
Printnameofthegame:
              push bp      
              mov  bp, sp        
              push es           
              push ax  
              push bx			  
              push cx
              push dx			  
              push si          
              push di 
              mov dl,35;columns
			  mov dh,2;rows
			  mov  ah, 0x13           ; service 13 - print string 
              mov  al, 1              ; subservice 01 – update cursor        
              mov  bh, 0              ; output on page 0         
              mov  bl, 2             ; normal attributes         
              mov  cx, 10             ; length of string       
              push cs    
              pop  es                 ; segment of string   
              mov  bp, trex       ; offset of string         
              int  0x10               ; call BIOS video service 
			  
			  pop  di           
			  pop  si  
              pop  dx			  
			  pop  cx
              pop  bx			  
			  pop  ax        
			  pop  es       
 			  pop  bp     
ret
;This Sub-Routine Prints the Game Start with Blinking 
startgame:    push bp      
              mov  bp, sp        
              push es           
              push ax  
              push bx			  
              push cx
              push dx			  
              push si          
              push di 
              
			  mov dl,33;columns
			  mov dh,4;rows
			  mov  ah, 0x13           ; service 13 - print string 
              mov  al, 1              ; subservice 01 – update cursor        
              mov  bh, 0              ; output on page 0         
              mov  bl, 0xF1             ; normal attributes         
              mov  cx, 13             ; length of string       
              push cs    
              pop  es                 ; segment of string   
              mov  bp, Game       ; offset of string         
              int  0x10               ; call BIOS video service 
			  
			  pop  di           
			  pop  si  
              pop  dx			  
			  pop  cx
              pop  bx			  
			  pop  ax        
			  pop  es       
 			  pop  bp 
ret
; This Sub-Routine Print that Credit Goes to Sir Salman Mubarik Because he Teaches us Very Well
CreditDetails:
              push bp      
              mov  bp, sp        
              push es           
              push ax  
              push bx			  
              push cx
              push dx			  
              push si          
              push di 
              
			  mov dl,2;columns
			  mov dh,2;rows
			  mov  ah, 0x13           ; service 13 - print string 
              mov  al, 1              ; subservice 01 – update cursor        
              mov  bh, 0              ; output on page 0         
              mov  bl, 0x12             ; normal attributes         
              mov  cx, 14             ; length of string       
              push cs    
              pop  es                 ; segment of string   
              mov  bp, credit       ; offset of string         
              int  0x10               ; call BIOS video service
               
			  mov  bl, 0xF4             ; normal attributes         
              mov  cx, 18             ; length of string 
			  mov dl,2;columns
			  mov dh,3;rows 
			  mov  bp, salman       ; offset of string         
              int  0x10               ; call BIOS video service
			  
			  pop  di           
			  pop  si  
              pop  dx			  
			  pop  cx
              pop  bx			  
			  pop  ax        
			  pop  es       
 			  pop  bp 
ret
; This Sub-Routine Prints that Game is Over
gameisend:
               push bp      
              mov  bp, sp        
              push es           
              push ax  
              push bx			  
              push cx
              push dx			  
              push si          
              push di 
              
			  mov dl,33;columns
			  mov dh,12;rows
			  mov  ah, 0x13           ; service 13 - print string 
              mov  al, 1              ; subservice 01 – update cursor        
              mov  bh, 0              ; output on page 0         
              mov  bl, 0xF1             ; normal attributes         
              mov  cx, 9            ; length of string       
              push cs    
              pop  es                 ; segment of string   
              mov  bp, endingstr       ; offset of string         
              int  0x10               ; call BIOS video service 
			  
			  pop  di           
			  pop  si  
              pop  dx			  
			  pop  cx
              pop  bx			  
			  pop  ax        
			  pop  es       
 			  pop  bp 
ret
;This Subroutine Just Output that String that
;Press Space and then Enter to Start the Game
gameistart:
              push bp      
              mov  bp, sp        
              push es           
              push ax  
              push bx			  
              push cx
              push dx			  
              push si          
              push di 
              
              mov dl,13;columns
			  mov dh,12;rows
			  mov  ah, 0x13           ; service 13 - print string 
              mov  al, 1              ; subservice 01 – update cursor        
              mov  bh, 0              ; output on page 0         
              mov  bl, 27             ; normal attributes         
              mov  cx, 50            ; length of string       
              push cs    
              pop  es                 ; segment of string   
              mov  bp, PressEnter       ; offset of string         
              int  0x10               ; call BIOS video service 
			  
			  pop  di           
			  pop  si  
              pop  dx			  
			  pop  cx
              pop  bx			  
			  pop  ax        
			  pop  es       
 			  pop  bp 
ret
;This Sub-Routine Removes that String
;;Press Space and then Enter to Start the Game
cleargameisstart:
               push bp      
              mov  bp, sp        
              push es           
              push ax  
              push bx			  
              push cx
              push dx			  
              push si          
              push di 
			  
              mov dl,13;columns
			  mov dh,12;rows
			  mov  ah, 0x13           ; service 13 - print string 
              mov  al, 1              ; subservice 01 – update cursor        
              mov  bh, 0              ; output on page 0         
              mov  bl, 7             ; normal attributes         
              mov  cx, 50            ; length of string       
              push cs    
              pop  es                 ; segment of string   
              mov  bp, clearPressEnter      ; offset of string         
              int  0x10               ; call BIOS video service
              
              pop  di           
			  pop  si  
              pop  dx			  
			  pop  cx
              pop  bx			  
			  pop  ax        
			  pop  es       
 			  pop  bp 			  
ret
;This Sub-Routine Removes that String
;Game Over
cleargameisend:
			  push bp      
              mov  bp, sp        
              push es           
              push ax  
              push bx			  
              push cx
              push dx			  
              push si          
              push di   
              
			  mov dl,33;columns
			  mov dh,12;rows
			  mov  ah, 0x13           ; service 13 - print string 
              mov  al, 1              ; subservice 01 – update cursor        
              mov  bh, 0              ; output on page 0         
              mov  bl, 7             ; normal attributes         
              mov  cx, 9            ; length of string       
              push cs    
              pop  es                 ; segment of string   
              mov  bp, clearendingstr       ; offset of string         
              int  0x10               ; call BIOS video service 
			  
			  pop  di           
			  pop  si  
              pop  dx			  
			  pop  cx
              pop  bx			  
			  pop  ax        
			  pop  es       
 			  pop  bp 	
ret
; This Sub-Routine Print all the Details of Game that how we will play this Game
details:
              push bp      
              mov  bp, sp        
              push es           
              push ax  
              push bx			  
              push cx
              push dx			  
              push si          
              push di  
              
			  mov dl,2;columns
			  mov dh,17;rows
			  mov  ah, 0x13           ; service 13 - print string 
              mov  al, 1              ; subservice 01 – update cursor        
              mov  bh, 0              ; output on page 0         
              mov  bl, 0x12             ; normal attributes         
              mov  cx, 7            ; length of string       
              push cs    
              pop  es                 ; segment of string   
              mov  bp, detail       ; offset of string         
              int  0x10               ; call BIOS video service 
			  
			  mov dl,2;columns
			  mov dh,18;rows
			  mov  bl, 7             ; normal attributes 
              mov  cx, 22            ; length of string      
              mov  bp, pressS       ; offset of string         
              int  0x10               ; call BIOS video service 
			  
			   mov dl,2;columns
			  mov dh,19;rows
			  mov  bl, 7             ; normal attributes 
              mov  cx, 33            ; length of string      
              mov  bp, Shift       ; offset of string         
              int  0x10               ; call BIOS video service 
			  
			   mov dl,2;columns
			  mov dh,20;rows
			  mov  bl, 7             ; normal attributes 
              mov  cx, 32            ; length of string      
              mov  bp, mored       ; offset of string         
              int  0x10               ; call BIOS video service 
			  
			   mov dl,2;columns
			  mov dh,21;rows
			  mov  bl, 7             ; normal attributes 
              mov  cx, 32            ; length of string      
              mov  bp, mored2       ; offset of string         
              int  0x10               ; call BIOS video service 
			  
			  pop  di           
			  pop  si  
              pop  dx			  
			  pop  cx
              pop  bx			  
			  pop  ax        
			  pop  es       
 			  pop  bp 
ret
; This Sub-Routine Print that String name as Score and String name as HScore
Score:
              push bp      
              mov  bp, sp        
              push es           
              push ax  
              push bx			  
              push cx
              push dx			  
              push si          
              push di    
              
			  mov dl,63;columns
			  mov dh,3;rows
			  mov  ah, 0x13           ; service 13 - print string 
              mov  al, 1              ; subservice 01 – update cursor        
              mov  bh, 0              ; output on page 0         
              mov  bl, 0x12             ; normal attributes         
              mov  cx, 8             ; length of string       
              push cs    
              pop  es                 ; segment of string   
              mov  bp, Sco       ; offset of string         
              int  0x10               ; call BIOS video service 
			  
			  mov dh,4;rows
			  mov  bp, HSco       ; offset of string         
              int  0x10               ; call BIOS video service
			  
			  pop  di           
			  pop  si  
              pop  dx			  
			  pop  cx
              pop  bx			  
			  pop  ax        
			  pop  es       
 			  pop  bp 
ret
; This Sub-Routine Print that String name as Player
Playersname:
              push bp      
              mov  bp, sp        
              push es           
              push ax  
              push bx			  
              push cx
              push dx			  
              push si          
              push di 
              
              mov dl,50;columns
			  mov dh,19;rows
			  mov  ah, 0x13           ; service 13 - print string 
              mov  al, 1              ; subservice 01 – update cursor        
              mov  bh, 0              ; output on page 0  
              mov  bl,22             ; normal attributes 			  
              mov  cx, 9             ; length of string       
              push cs    
              pop  es                 ; segment of string   
              mov  bp, Player1       ; offset of string         
              int  0x10               ; call BIOS video service 
			  
			 
			  
			  mov  bl,2             ; normal attributes 
			  mov dl,45;columns
			  mov dh,20;rows
			   mov cl,byte[buffer+1]
			  mov  ch,0             ; length of string     
			   mov  bp, buffer+2       ; offset of string         
              int  0x10               ; call BIOS video service 
			  
			  pop  di           
			  pop  si  
              pop  dx			  
			  pop  cx
              pop  bx			  
			  pop  ax        
			  pop  es       
 			  pop  bp 
ret
 
; This Sub-Routine Print that Outer Border of the Window
Border:
              push bp      
              mov  bp, sp        
              push es           
              push ax          
              push cx          
              push si          
              push di 
              mov dl,0
			   mov dh,0
			  mov  ah, 0x13           ; service 13 - print string 
              mov  al, 1              ; subservice 01 – update cursor        
              mov  bh, 0              ; output on page 0         
              mov  bl, 32 ;green;72; red;52; grey;22; blue ;             ; normal attributes         
              mov  cx, 1             ; length of string       
              push cs    
              pop  es                 ; segment of string   
			  
			  B1:
			  mov  bp, space       ; offset of string
              call delay            
			 int  0x10               ; call BIOS video service 
              add dl,1
			  cmp dl,79
			  jne B1
			  
			  B2:
			  mov  bp, space       ; offset of string
			  call delay  
              int  0x10               ; call BIOS video service 
              add dh,1
			  cmp dh,23
			  jne B2
			  
			  B3:
			  mov  bp, space       ; offset of string
			  call delay  
              int  0x10               ; call BIOS video service 
              sub dl,1
			  cmp dl,0
			  jne B3
			  
			  B4:
			  mov  bp, space       ; offset of string
			  call delay  
              int  0x10               ; call BIOS video service 
              sub dh,1
			  cmp dh,0
			  jne B4
			  
			  mov  al, 0x20     
			  out  0x20, al           ; end of interrupt 
			  pop  di           
			  pop  si        
			  pop  cx         
			  pop  ax        
			  pop  es       
 			  pop  bp      
              ret
; This Sub-Routine Print that Inner Border(Outside of the Player Name) of the Window		
InnerBorder:
              push bp      
              mov  bp, sp        
              push es           
              push ax          
              push cx          
              push si          
              push di 
              mov dl,40
			   mov dh,18
			  mov  ah, 0x13           ; service 13 - print string 
              mov  al, 1              ; subservice 01 – update cursor        
              mov  bh, 0              ; output on page 0         
              mov  bl, 52 ;green;72; red;52; grey;22; blue ;             ; normal attributes         
              mov  cx, 1             ; length of string       
              push cs    
              pop  es                 ; segment of string   
			  
			  IB1:
			  mov  bp, space       ; offset of string
              call delay            
			  int  0x10               ; call BIOS video service 
              add dl,1
			  cmp dl,70
			  jne IB1
			  
			  IB2:
			  mov  bp, space       ; offset of string
			  call delay  
              int  0x10               ; call BIOS video service 
              add dh,1
			  cmp dh,21
			  jne IB2
			  
			  IB3:
			  mov  bp, space       ; offset of string
			  call delay  
              int  0x10               ; call BIOS video service 
              sub dl,1
			  cmp dl,40
			  jne IB3
			  
			  IB4:
			  mov  bp, space       ; offset of string
			  call delay  
              int  0x10               ; call BIOS video service 
              sub dh,1
			  cmp dh,18
			  jne IB4
			  
			  mov  al, 0x20     
			  out  0x20, al           ; end of interrupt 
			 
   			 pop  di           
			  pop  si        
			  pop  cx         
			  pop  ax        
			  pop  es       
 			  pop  bp      
              ret		

; This Sub-Routine Just Delay the Screen for Some TIme
delay:
push cx
mov cx,54000
loop1:
sub cx,1
cmp cx,0
jnz loop1
pop cx
ret 

; This Sub-Routine Removes the Dinasaur From its Coordinates
clearDinosaur:
              push bp      
              mov  bp, sp        
              push es           
              push ax          
              push cx          
              push si          
              push di 
			  mov dl,byte[cs:colvalue]
			  mov dh,byte[cs:rowvalue]
			  mov  ah, 0x13           ; service 13 - print string 
              mov  al, 1              ; subservice 01 – update cursor        
              mov  bh, 0              ; output on page 0         
              mov  bl, 11             ; normal attributes         
              mov  cx, 1             ; length of string       
              push cs    
              pop  es                 ; segment of string   
              mov  bp,space       ; offset of string         
              int  0x10               ; call BIOS video service 
              inc dh
			  int 0x10
			  inc dh
			  int 0x10
			  
			  pop  di           
			  pop  si        
			  pop  cx         
			  pop  ax        
			  pop  es       
 			  pop  bp      
              ret 
;This Sub-Routine Recieve the X(Higher byte) and Y(Lower Byte) Coorinates and Prints the Dinasaur From its Coordinates			  
Dinosaur:  
              push bp      
              mov  bp, sp        
              push es           
              push ax          
              push cx          
              push si          
              push di 
			  
			  mov ax,[bp+4]
			  mov dl,al
			  mov dh,ah
			  mov byte[cs:rowvalue],dh
			  mov byte[cs:colvalue],dl
			
			  mov  ah, 0x13           ; service 13 - print string 
              mov  al, 1              ; subservice 01 – update cursor        
              mov  bh, 0              ; output on page 0         
              mov  bl, 11             ; normal attributes         
              mov  cx, 1             ; length of string       
              push cs    
              pop  es                 ; segment of string   
              mov  bp,3200h       ; offset of string         
              int  0x10               ; call BIOS video service 
              inc dh
			  mov bp,body
			  int 0x10
			  inc dh
			  mov bp,legs 
			  int 0x10
			  
			  pop  di           
			  pop  si        
			  pop  cx         
			  pop  ax        
			  pop  es       
 			  pop  bp      
              ret 2
;; This Sub-Routine Recieves the Number in Hexadecimel which Convert it into Decimel and the Print  
 printnum:     
 
 push bp        
 mov  bp, sp       
 push es          
 push ax          
 push bx          
 push cx          
 push dx          
 push di 
 
              mov  ax, 0xb800    
			  mov  es, ax             ; point es to video base      
			  mov  ax, [bp+4]         ; load number in ax          
			  mov  bx, 10             ; use base 10 for division       
			  mov  cx, 0              ; initialize count of digits 
 
nextdigit:    mov  dx, 0              ; zero upper half of dividend  
             div  bx                 ; divide by 10       
			 add  dl, 0x30           ; convert digit into ascii value      
			 push dx                 ; save ascii value on stack       
			 inc  cx                 ; increment count of values      
			 cmp  ax, 0              ; is the quotient zero           
			 jnz  nextdigit          ; if no divide it again 
 
              mov di,word[cs:olddi]
              mov  di, 620            ; point di to 70th column
               add  word [cs:olddi],2			  
 
nextpos:      pop  dx                 ; remove a digit from the stack  
             mov  dh, 0x07           ; use normal attribute          
			 mov  [es:di], dx        ; print char on screen     
			 add  di, 2              ; move to next screen location    
			 loop nextpos            ; repeat for all digits on stack 
 
              pop  di       
			  pop  dx       
			  pop  cx        
			  pop  bx        
			  pop  ax 
			   pop  es           
			   pop  bp       
			   ret  2 
;; This Sub-Routine Recieves the Number in Hexadecimel which Convert it into Decimel and the Print  			   
printnum2:     
 push bp        
 mov  bp, sp       
 push es          
 push ax          
 push bx          
 push cx          
 push dx          
 push di 
 
              mov  ax, 0xb800    
			  mov  es, ax             ; point es to video base      
			  mov  ax, [bp+4]         ; load number in ax          
			  mov  bx, 10             ; use base 10 for division       
			  mov  cx, 0              ; initialize count of digits 
 
nextdigit2:    mov  dx, 0              ; zero upper half of dividend  
             div  bx                 ; divide by 10       
			 add  dl, 0x30           ; convert digit into ascii value      
			 push dx                 ; save ascii value on stack       
			 inc  cx                 ; increment count of values      
			 cmp  ax, 0              ; is the quotient zero           
			 jnz  nextdigit2          ; if no divide it again 
 
              mov di,word[cs:olddi]
              mov  di, 780            ; point di to 70th column
               add  word [cs:olddi],2			  
 
nextpos2:      pop  dx                 ; remove a digit from the stack  
             mov  dh, 0x07           ; use normal attribute          
			 mov  [es:di], dx        ; print char on screen     
			 add  di, 2              ; move to next screen location    
			 loop nextpos2            ; repeat for all digits on stack 
 
              pop  di       
			  pop  dx       
			  pop  cx        
			  pop  bx        
			  pop  ax 
			   pop  es           
			   pop  bp       
			   ret  2 		
;This Sub-Routine is Specially Design for Delay of Dinasaur 			   
DelayDino:
             call delay
			 call delay
			 call delay
			 call delay
			 call delay
			 call delay
			 call delay
			 ret
			 
;Key Board Interrupt			 
kbisr:        push ax 
 
              in   al, 0x60           ; read char from keyboard port  
			  cmp  al, 0x39           ; has the Space pressed   
			  jne  nextcmp            ; no, try next comparison 
			   
			   mov  word [cs:set], 1;   set flag to start printing   
			  mov byte[x],0
			   mov byte[colvalue],4;column
               mov byte[rowvalue],13;row
			  jmp  exit               ; leave the ISR  	
			  
			  nextcmp:
			   cmp  al, 28           ; has the Enter pressed   
			  jne  nextcmp2            ; no, try next comparison 
			  mov byte[cs:endgame],0
			  call cleargameisstart
			  
             		  
nextcmp2:      cmp  al, 0x2a           ; has the left shift Pressed      
             jne  nomatch            ; no, chain to old ISR 
mov byte[cs:y1], 60
mov byte[cs:y2], 61
mov byte[cs:y3], 62
mov byte[cs:y4], 63
mov byte[cs:y5], 70
mov byte[cs:y6], 68
mov byte[cs:y7], 72
mov byte[cs:y8], 25
call cleargameisend
mov byte[cs:endgame],0

push es
mov ax,0xb800
mov es,ax
mov di,620
mov ax,0
mov [es:di], ax        ; print char on screen 
add di,2
mov [es:di], ax        ; print char on screen 
add di,2
mov [es:di], ax        ; print char on screen 
add di,2
mov [es:di], ax        ; print char on screen 
pop es

mov word[cs:seconds],0
push word[cs:seconds]            
call printnum           ; print tick count
nomatch:      pop  ax           
             jmp  far [cs:oldkb]     ; call original ISR 
 
exit: 
   mov  al, 0x20     
          out  0x20, al           ; send EOI to PIC 
 
              pop  ax         
			  iret                    ; return from interrupt 

;Increase the Score One Times
increaseScore:
            inc  word [cs:seconds]  ; increment Current Score
            mov cx,word[cs:seconds]
            cmp cx,word[cs:Hscore]
            jng smaller		
			inc word[cs:Hscore]
			push word [cs:Hscore]            
			call printnum2           ; print Higest Score
			smaller:
			push word [cs:seconds]            
			call printnum           ; print Current count
ret

; timer interrupt service routine
 timer:        push ax 
		   
			mov ah,byte[cs:endgame]
		   cmp ah,0
           jne next  
		  
           call hurdles
		   
		   h2:mov ah,byte[cs:colvalue]
           cmp byte [cs:y8],ah 
           jne next
		    mov ah,byte[rowvalue]
            
			mov bh,13
			cmp ah,bh
			je ending
			inc ah
			cmp ah,bh
			je ending
			inc ah
			cmp ah,bh
			je ending
			
			mov bh,14
			cmp ah,bh
			je ending
			inc ah
			cmp ah,bh
			je ending
			inc ah
			cmp ah,bh
			je ending
			inc ah
			
			mov bh,15
			cmp ah,bh
			je ending
            inc ah
			cmp ah,bh
			je ending
            inc ah
			cmp ah,bh
			je ending
            inc ah
			
			call increaseScore
			
			
           jmp next

ending:
mov byte[cs:endgame],1
call gameisend

		   
             next:
			  mov ah,byte[cs:colvalue]
           cmp byte [cs:y6],ah 
           jne next2
		    mov ah,byte[rowvalue]
            
			mov bh,14
			cmp ah,bh
			je ending2
			inc ah
			cmp ah,bh
			je ending2
			
			
			mov bh,15
			cmp ah,bh
			je ending2
			inc ah
			cmp ah,bh
			je ending2
			
			call increaseScore
			jmp next2
			 
			 
			 
			 
ending2:			 
mov byte[cs:endgame],1
call gameisend		 
			 
			 next2:
			 
			  mov ah,byte[cs:colvalue]
           cmp byte [cs:y5],ah 
           jne next3
		    mov ah,byte[rowvalue]
            
			mov bh,13
			cmp ah,bh
			je ending3
			inc ah
			cmp ah,bh
			je ending3
			inc ah
			cmp ah,bh
			je ending3
			
			mov bh,14
			cmp ah,bh
			je ending3
			inc ah
			cmp ah,bh
			je ending3
			inc ah
			cmp ah,bh
			je ending3
			inc ah
			
			mov bh,15
			cmp ah,bh
			je ending3
            inc ah
			cmp ah,bh
			je ending3
            inc ah
			cmp ah,bh
			je ending3
            inc ah
			call increaseScore
           jmp next3
			 
			 
			 
			 
			 
ending3:			 
mov byte[cs:endgame],1
call gameisend		
		 
			 next3:
			 
			 cmp  word [cs:set], 1 ; is the printing flag set     
			  jne  skipall            ; no, leave the ISR 			  
             
			 
			 call clearDinosaur
			cmp byte[x],8
			jg  tim2 			
			dec byte[rowvalue]
			jmp tim3
			tim2:
			inc byte[rowvalue]
			tim3:
			mov ah,byte[rowvalue]
			mov al,byte[colvalue]
			push ax
			call Dinosaur
			inc byte[x]
			cmp byte[x],18
			jne skipall
			
			mov word[cs:set],0
			jmp skipall

skipall:    
              mov  al, 0x20         
              out  0x20, al           ; send EOI to PIC 
              pop  ax     
			  iret                    ; return from interrupt 

;This Sub-Routine Clears the Screen
clrscr: 
push es
push ax
push di
mov ax, 0xb800
mov es, ax ; point es to video base
mov di, 0 ; point di to top left column

nextloc: mov word [es:di], 0x0720 ; clear next char on screen
add di, 2 ; move to next screen location
cmp di, 4000 ; has the whole screen cleared
jne nextloc ; if no clear next position
pop di
pop ax
pop es
ret


;This Subroutine Clear the Hurdles from Their Current Coordinates
clear:
              push bp      
              mov  bp, sp        
              push es           
              push ax  
              push bx			  
              push cx
              push dx			  
              push si          
              push di 

mov ah, 0x13 ; service 13 - print string
mov al, 1 ; subservice 01 – update cursor
mov bh, 0 ; output on page 0
mov bl, 7 ; normal attrib
mov dh,0x0D
mov dl,byte[cs:y1]
mov cx, 1 ; length of string
push cs
pop es ; segment of string
mov bp, spc ; offset of string
;int 0x10 ; call BIOS video service


mov dh, 0x0D
mov dl,byte[cs:y2]
mov bp, spc ; offset of string
;int 0x10 ; call BIOS video service


mov dh, 0x0D
mov dl,byte[cs:y3] 
mov bp, spc ; offset of string
;int 0x10 ; call BIOS video service


mov dh, 0x0D
mov dl,byte[cs:y4]
mov bp, spc ; offset of string
;int 0x10 ; call BIOS video service



mov dh, 0x0D
mov dl,byte[cs:y5]
mov bp, spc ; offset of string
int 0x10 ; call BIOS video service


mov dh, 0x0E
mov dl,byte[cs:y6]
mov bp, spc ; offset of string
int 0x10 ; call BIOS video service


mov dh, 0x0E
mov dl,byte[cs:y5] 
mov bp, spc ; offset of string
int 0x10 ; call BIOS video service


mov dh, 0x0E
mov dl,byte[cs:y7]
mov bp, spc ; offset of string
int 0x10 ; call BIOS video service



mov dh, 0x0F
mov dl,byte[cs:y6]
mov bp, spc ; offset of string
int 0x10 ; call BIOS video service

mov dh, 0x0F
mov dl,byte[cs:y5]
mov bp, spc ; offset of string
int 0x10 ; call BIOS video service


mov dh, 0x0F
mov dl,byte[cs:y7]
mov bp, spc ; offset of string
int 0x10 ; call BIOS video service


mov dh, 0x0D
mov dl,byte[cs:y8]
mov bp, spc ; offset of string
int 0x10 ; call BIOS video service


mov dh, 0x0E
mov dl,byte [cs:y8]
mov bp, spc ; offset of string
int 0x10 ; call BIOS video service


mov dh, 0x0F
mov dl,byte[cs:y8]
mov bp, spc ; offset of string
int 0x10 ; call BIOS video service


              pop di
			  pop si
			  pop dx
			  pop cx
			  pop bx
			  pop ax
			  pop es
			  pop bp
			  
ret
;This Subroutine Prints the Hurdles on their Current Coordinates
hurdles:

push ax
push bx
push cx
push dx
push di
push si

mov ah, 0x13 ; service 13 - print string
mov al, 1 ; subservice 01 – update cursor
mov bh, 0 ; output on page 0
mov bl, 7 ; normal attrib
mov dh,0x0D
mov dl,byte[cs:y1]
mov cx, 1 ; length of string
push cs
pop es ; segment of string
mov bp, message1 ; offset of string
;int 0x10 ; call BIOS video service

mov dh, 0x0D
mov dl,byte[cs:y2]
mov bp, message2 ; offset of string
;int 0x10 ; call BIOS video service


mov dh, 0x0D
mov dl,byte[cs:y3] 
mov bp, message2 ; offset of string
;int 0x10 ; call BIOS video service


mov dh, 0x0D
mov dl,byte[cs:y4]
mov bp, message2 ; offset of string
;int 0x10 ; call BIOS video service


mov dh, 0x0D
mov dl,byte[cs:y5]
mov bp, message3 ; offset of string
int 0x10 ; call BIOS video service;3 middle 1



mov dh, 0x0E
mov dl,byte[cs:y6];y6 for 3 1st
mov bp, message3 ; offset of string
int 0x10 ; call BIOS video service;3 1st 1


mov dh, 0x0E
mov dl,byte[cs:y5] ;y5 for 3 middle
mov bp, message3 ; offset of string
int 0x10 ; call BIOS video service


mov dh, 0x0E
mov dl,byte[cs:y7] ;y7 for 3 last
mov bp, message3 ; offset of string
int 0x10 ; call BIOS video service



mov dh, 0x0F
mov dl,byte[cs:y6]
mov bp, message3 ; offset of string
int 0x10 ; call BIOS video service


mov dh, 0x0F
mov dl,byte[cs:y5]
mov bp, message3 ; offset of string
int 0x10 ; call BIOS video service


mov dh, 0x0F
mov dl,byte[cs:y7]
mov bp, message3 ; offset of string
int 0x10 ; call BIOS video service


mov dh, 0x0D
mov dl,byte[cs:y8]
mov bp, message3 ; offset of string
int 0x10 ; call BIOS video service


mov dh, 0x0E
mov dl,byte[cs:y8]
mov bp, message3 ; offset of string
int 0x10 ; call BIOS video service


mov dh, 0x0F
mov dl,byte[cs:y8]
mov bp, message3 ; offset of string
int 0x10 ; call BIOS video service

call delay

call clear

;updating all the coordinates
mov dl,byte[cs:y1]
sub dl,1
cmp dl,2
jne skip1
add dl,78
skip1:
mov byte [cs:y1],dl

mov dl,byte[cs:y2]
sub dl,1
cmp dl,2
jne skip2
add dl,78
skip2:
mov  byte[cs:y2],dl

mov dl,byte[cs:y3]
sub dl,1
cmp dl,2
jne skip3
add dl,78
skip3:
mov  byte[cs:y3],dl

mov dl,[y4]
sub dl,1
cmp dl,2
jne skip4
add dl,78
skip4:
mov byte [y4],dl

mov dl,byte[cs:y5]
sub dl,1
cmp dl,2
jne skip5
add dl,78
skip5:
mov byte [cs:y5],dl

mov dl,byte[cs:y6]
sub dl,1
cmp dl,2
jne skip6
add dl,78
skip6:
mov byte [cs:y6],dl

mov dl,byte[cs:y7]
sub dl,1
cmp dl,2
jne skip7
add dl,78
skip7:
mov byte [cs:y7],dl

mov dl,byte[cs:y8]
sub dl,1
cmp dl,2
jne skip8
add dl,78
skip8:
mov byte [cs:y8],dl

pop si
pop di
pop dx
pop cx
pop bx
pop ax

ret



;This Function have all the Function Calling with All the Working


MainFunction:

push ax
push bx
push cx
push dx
push si
push di

 call clrscr 
 call EnterPlayername
 call clrscr
 call Border
 call Printnameofthegame
 call Score
 ;call Scorehigest
 push word[cs:seconds]            
 call printnum           ; print tick count
 push word[cs:Hscore]            
 call printnum2           ; print tick count
 call startgame
 Call Printline
 mov al,4;column
 mov ah,13;row
 push ax
 call Dinosaur
 call CreditDetails
 call details 
 call InnerBorder
 call Playersname
 call gameistart
 
              pop di
			  pop si
			  pop dx
			  pop cx
			  pop bx
			  pop ax
ret

start:

call MainFunction
 
     xor  ax, ax       
        mov  es, ax             ; point es to IVT base   
		mov  ax, [es:9*4]      
		mov  [oldkb], ax        ; save offset of old routine     
		mov  ax, [es:9*4+2]         
		mov  [oldkb+2], ax      ; save segment of old routine     
		cli                     ; disable interrupts         
		mov  word [es:9*4], kbisr ; store offset at n*4    
		mov  [es:9*4+2], cs     ; store segment at n*4+2   
		mov  word [es:8*4], timer ; store offset at n*4      
		mov  [es:8*4+2], cs     ; store segment at n*4+     
		sti                     ; enable interrupts 
 
              mov  dx, start          ; end of resident portion   
			  add  dx, 15             ; round up to next para    
			  mov  cl, 4            
			  shr  dx, cl             ; number of paras     
			  mov  ax, 0x3100         ; terminate and stay resident 
              int  0x21
			  ;mov ax, 0x4c00          ; terminate program     
			  ;int 0x21