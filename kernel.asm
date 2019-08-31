org 0x7e00
jmp 0x0000:main
data:
    start db 'Start', 0
    instructions db 'Instructions', 0
    credits db 'Credits', 0
    uc db 'Under Construction', 0
    it db 'Vai ter umas instrucoes aqui', 0
    gme db 'gme - Gabriel de Melo', 0
    ersa db 'ersa - Elisson Araujo', 0
    mbfg2 db 'mbfg2 - Morgana Galamba', 0
    ready db 'Are you ready?', 0
    titulo db  'TITULO DO JOGO', 0
    yon db 'Y - Yes   N - No', 0
    resolvido db '534678912672195348198342567859761423426853791713924856961537284287419635345286179', 0
    hollow3 db '53  7    6  195    98    6 8   6   34  8 3  17   2   6 6    28    419  5    8  79', 0
    highlight3 db 2, 3, 5, 6, 7, 8, 10, 11, 15, 16, 17, 18, 21, 22, 23, 24, 26, 28, 29, 30, 32, 33, 34, 37, 38, 40, 42, 43, 46, 47, 48, 50, 51, 52, 54, 56, 57, 58, 59, 62, 63, 64, 65, 69, 70, 72, 73, 74, 75, 77, 78
    counth db 0
    count db 0
    winner db 'You won!', 0
    loser db 'You lost!', 0
pular_linha:
    mov al, 0x0d
    mov ah, 0x0e
    int 10h
    mov al, 0x0a
    int 10h
    ret
clear:                   
    mov al, 0
    mov bh, 0
    mov cx, 0
    mov dx, 0 

    .for_v:
        .for_h:
            mov ah, 0ch
            int 10h

            inc cx
            cmp cx, 320
                jne .for_h
            mov cx, 0
            inc dx
            cmp dx, 200
            jne .for_v
            ret
    
  
    mov dx, 0 
    mov bh, 0      
    mov ah, 0x2
    int 0x10
    ret

print:
    .loop:
        lodsb
        cmp al, 0
        je .vai
        call printar_letra
        jmp .loop
    .vai:
        ret

printar_letra: 
    mov ah, 0xe
    mov bh, 0
    int 10h
    ret
ler_letra:
    mov ah, 0
    int 16h
    ret
tela:
    mov ah, 0
    mov al, 13h
    int 10h

    mov ah, 0xb
    mov al, 13h
    int 10h

    mov ah, 0xb
    mov bh, 0
    mov bl, 0
    int 10h

    ret
menu:
    .start:

        mov si, titulo
        mov bl, 14
        mov ah, 02h
        mov dh, 5
        mov dl, 10
        int 10h
        call print

        mov si, start  
        mov bl, 10
        mov ah, 02h
        mov dh, 9
        mov dl, 15
        int 10h
        call print

        mov si, instructions  
        mov bl, 15
        mov ah, 02h
        mov dh, 12
        mov dl, 15
        int 10h
        call print

        mov si, credits  
        mov bl, 15
        mov ah, 02h
        mov dh, 15
        mov dl, 15
        int 10h
        call print

        call ler_letra

        cmp al, 's'
        je .instructions
        cmp al, 13
        je .done

        jmp .start
    .instructions:

        mov si, titulo
        mov bl, 14
        mov ah, 02h
        mov dh, 5
        mov dl, 10
        int 10h
        call print

        mov si, start  
        mov bl, 15
        mov ah, 02h
        mov dh, 9
        mov dl, 15
        int 10h
        call print

        mov si, instructions  
        mov bl, 10
        mov ah, 02h
        mov dh, 12
        mov dl, 15
        int 10h
        call print

        mov si, credits  
        mov bl, 15
        mov ah, 02h
        mov dh, 15
        mov dl, 15
        int 10h
        call print

        call ler_letra

        cmp al, 'w'
        je .start
        cmp al, 's'
        je .credits
        cmp al, 13
        je .printInstructions

        jmp .instructions

        .printInstructions:
            call clear

            mov si, it  
            mov bl, 15
            mov ah, 02h
            mov dh, 9
            mov dl, 10
            int 10h
            call print

            call ler_letra

            call clear

            jmp .instructions
    .credits:

        mov si, titulo
        mov bl, 14
        mov ah, 02h
        mov dh, 5
        mov dl, 10
        int 10h
        call print

        mov si, start  
        mov bl, 15
        mov ah, 02h
        mov dh, 9
        mov dl, 15
        int 10h
        call print

        mov si, instructions  
        mov bl, 15
        mov ah, 02h
        mov dh, 12
        mov dl, 15
        int 10h
        call print

        mov si, credits  
        mov bl, 10
        mov ah, 02h
        mov dh, 15
        mov dl, 15
        int 10h
        call print

        call ler_letra

        cmp al, 'w'
        je .instructions
        cmp al, 13
        je .printCredits

        jmp .credits
        .printCredits:
            call clear

            mov si, credits  
            mov bl, 10
            mov ah, 02h
            mov dh, 6
            mov dl, 15
            int 10h
            call print

            mov si, ersa  
            mov bl, 15
            mov ah, 02h
            mov dh, 10
            mov dl, 10
            int 10h
            call print

            mov si, gme  
            mov bl, 15
            mov ah, 02h
            mov dh, 13
            mov dl, 10
            int 10h
            call print

            mov si, mbfg2  
            mov bl, 15
            mov ah, 02h
            mov dh, 16
            mov dl, 10
            int 10h
            call print

            call ler_letra

            call clear
            
            jmp .credits
    .done:
        ret
printar_tabuleiro:
    mov ah, 02h
    mov bh, 0
    mov dh, 4
    mov dl, 10
    int 10h
    mov cl, 0
    .printa:
        lodsb
        inc cl

        cmp al, 0
        je .fim

        mov bl, 15
        call printar_letra

        mov al, '|'
        call printar_letra

        cmp cl, 9
        je .endl
        jmp .printa
        .endl:
            mov cl, 0
            mov ah, 02h
            mov bh, 0
            add dh, 2
            int 10h
            jmp .printa
    .fim:
        ret
joguito:
    mov si, ready
    mov bl, 4
    mov ah, 02h
    mov dh, 9
    mov dl, 12
    int 10h
    call print

    mov si, yon
    mov bl, 5
    mov ah, 02h
    mov dh, 12
    mov dl, 10
    int 10h
    call print

    call ler_letra

    cmp al, 'y'
    je gameitself

    cmp al, 'n'
    jne joguito

    ret
gameitself:
    call clear
    mov si, hollow3
    call printar_tabuleiro
    mov di, highlight3
    mov al, [di]
    mov byte[counth], al
    call printar_highlight
    .jogo:
        call ler_letra

        cmp al, 'd'
        je .direita

        cmp al, 'a'
        je .esquerda

        cmp al, 13
        je .escolhenum
        
        cmp al, 'f'
        je .verifica

        jmp .jogo

        .direita:
            cmp byte[count], 50
            je .jogo
            add byte[count], 1
            mov al, 8
            call printar_letra
            mov al, ' '
            call printar_letra
            
            inc di
            mov al, [di]
            
            mov byte[counth], al
            call printar_highlight
            jmp .jogo
        .esquerda:
            cmp byte[count], 0
            je .jogo
            add byte[count], -1 

            mov al, 8
            call printar_letra
            mov al, ' '
            call printar_letra

            dec di
            mov al, [di]
           
            mov byte[counth], al
            call printar_highlight
            jmp .jogo
        .escolhenum:
            call ler_letra

            cmp al, '0'
            jl .escolhenum
            cmp al, '9'
            jg .escolhenum

            mov ah, 02h
            int 10h

            mov bl, byte[counth]
            mov si, hollow3
            .aumenta:
                cmp bl, 0
                je .movido
                inc si
                dec bl
                jmp .aumenta
            .movido:
            mov [si], al
            mov bl, 15
            call printar_letra
            mov si, hollow3
            call printar_tabuleiro
            jmp .jogo
        .verifica:
            mov si, hollow3
            mov di, resolvido
            call compara
            je .ganhou
            jmp .perdeu
            .ganhou:
                call clear
                mov si, winner  
                mov bl, 12
                mov ah, 02h
                mov dh, 12
                mov dl, 15
                int 10h
                call print
                call ler_letra
                jmp .end
            .perdeu:
                call clear
                mov si, loser  
                mov bl, 10
                mov ah, 02h
                mov dh, 12
                mov dl, 15
                int 10h
                call print
                call ler_letra
                jmp .end
    .end:       
        jmp main
printar_highlight:
    mov ah, 02h
    mov bh, 0
    mov dh, 4
    mov dl, 10
    int 10h
    mov cl, 0
    mov al, 0
    .for_a:
        inc cl

        cmp cl, 10
        je .pula

        

        cmp al, byte[counth]
        je .sai

        add dl, 2
        inc al

        jmp .for_a

        .pula:
            mov cl, 0
            add dh, 2
            mov dl, 10
            int 10h
            jmp .for_a
    .sai:
        int 10h
        mov al, '_'
        mov bl, 12
        call printar_letra
    ret
compara:
    .loop:
        mov al, [si]
        mov bl, [di]
        cmp al, bl
        jne .diferente

        cmp al,0
        je .igual
        inc di
        inc si
        jmp .loop
    .diferente:
        clc
        ret
    .igual:
        stc
        ret
main:
    xor ax, ax
    mov ds, ax

    call tela
    ;call menu
    ;call clear
    call joguito
done:
    jmp $
    times 63*512-($-$$) db 0