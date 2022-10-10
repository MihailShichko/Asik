.model small                     
.stack 100h
.data
    size equ 200 
    stringTwo db size dup ('$')
    substring db ' number$'
    len dw 7
    strlen dw 0
    nstr db 0DH,0AH,24H
    nums db '0123456789$'
    
.code

macro scanf str
    lea dx, str
    mov offset str, size 
    mov ah, 0Ah
    int 21h
endm

macro print str
    mov dx, offset str[2]
    mov ah,9   
    int 21h
endm
 
macro NextString
    mov dx, offset nstr
    mov ah,9   
    int 21h    
endm

macro Leave
    mov ax, 4C00h
    int 21h
endm
    
start:   
    mov ax, @data
    mov ds, ax
    scanf stringTwo
    mov cx, 10
    mov di, offset nums   
    l1:
      mov si, offset stringTwo
      push cx
      mov cx, size
      mov bl, [di]
      l2:
        cmp [si], bl
        je L_Found
        jmp L_Cont
        L_Found:
            push cx
            push di
            mov di, si
            add si, len
            push si
            jmp Func
        L_Cont:
            inc si
            cmp [si], '$'
            je LeaveFirstLoop
      loop l2
      
      LeaveFirstLoop:
      inc di
      pop cx
    loop l1
    
    NextString
    print stringTwo
    Leave
    
Func: 
    ;cycle to get strlen
    mov si, offset stringTwo
    mov cx, 200
    len1:
        cmp [si], '$'
        je len1_Break
        inc si
        inc strlen
    loop len1
        
    len1_Break:
    ;cycle 
    
    mov si, offset stringTwo
    add si, strlen
    sub strlen, di ; how much symbols to push
    add strlen, 2
    mov cx, strlen         
    move1:
        push cx
        
         
        mov cx, len
        move2:
            mov al, [si]
            inc si
            mov ah, [si]
            mov [si], al
        loop move2
        
        sub si, len 
        dec si 
        pop cx
    loop move1      
          
    mov si, offset stringTwo     
    add si, di      
    mov cx, len
    mov di, si
    dec di
    mov si, offset substring
    f:  
        mov al, [si]
        mov [di], al  
        inc si
        inc di
    loop f
        
    pop si
    pop di
    pop cx
    jmp L_Cont
end start    