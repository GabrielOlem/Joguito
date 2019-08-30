org 0x7e00
jmp 0x0000:main
data:
    start db 'Start', 0
    instructions db 'Instructions', 0
    credits db 'Credits', 0
    uc db 'Under Construction', 0
    it db 'Vai ter umas instrucoes aqui', 0
    gme db 'gme - Gabriel de Melo', 0
    ersa db 'ersa - Elisson Rodrigo', 0
    mbfg2 db 'mbfg2 - Morgana Beatriz', 0

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
        call tela
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
        call tela
        
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
            call tela

            mov si, it  
            mov bl, 15
            mov ah, 02h
            mov dh, 9
            mov dl, 10
            int 10h
            call print

            call ler_letra

            jmp .instructions
    .credits:
        call tela

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
            call tela

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

            jmp .credits
    .done:
        ret
joguito:
    call tela
    mov si, uc
    mov bl, 4
    mov ah, 02h
    mov dh, 9
    mov dl, 12
    int 10h
    call print
    ret
main:
    xor ax, ax
    mov ds, ax

    call tela

    call menu
    call joguito
done:
    jmp $
times 63*512-($-$$) db 0