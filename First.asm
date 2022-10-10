.model tiny
.code               
org 100h            
start:
    mov dx,offset firstString    
    mov ah,9
    int 21h         
                
    mov dx,offset secondString       
    int 21h
                           
    mov dx,offset thirdString  
    int 21h
     
    mov ax, 4C00h
    int 21h
.data             
firstString db 'FirstString!'
db    0DH,0AH,24H  
secondString db 'SecondString!'
db    0DH,0AH,24H
thirdString db 'ThirdString!$'