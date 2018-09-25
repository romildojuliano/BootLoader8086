org 0x7e00
jmp 0x0000:start

titulo db 'O LABIRINTO CEGO', 0
inst db ' Pressione qualquer tecla para iniciar', 0
comando db ' Movimento: W, S, A, D ', 0

inst1 db ' Leve o tempo que precisar para ', 0
inst2 db ' memorizar cada mapa! ', 0
inst3 db ' Quando estiver pronto, ', 0
inst4 db ' pressione qualquer tecla ', 0
inst5 db ' A tela ficara preta e voce deve ', 0
inst6 db ' alcancar o final de cada fase ', 0
inst7 db ' Boa sorte :) ', 0

pontuacao1 db ' Parabens, voce terminou o jogo com ', 0
score dw 0
pontuacao2 db ' mortes. ', 0
pontuacao3 db ' Deseja jogar novamente ? ', 0
pontuacao4 db ' Pressione qualquer tecla para ', 0
pontuacao5 db ' voltar ao menu inicial. ', 0

white equ 15
darkgreen equ 2
green equ 10
blue equ 1
black equ 0
brown equ 6
red equ 12
grey equ 7
dark_red equ 4
yellow equ 14

leftarrow equ $1E
rightarrow equ $20
uparrow equ $11
downarrow equ $1F

start:
	call initVideo

	ini:
	mov ax, 0
	mov [score], ax

	call menu
	call tutorial

	call nv1
	call nv2
	call nv3
	call nv4
	call nv5
	call nv6
	call nv7
	call nv8

	call scoreboard

jmp ini

initVideo:
	mov al, 13h
	mov ah, 0
	int 10h
ret

print_pixel:
	mov ah, 0Ch
	int 10h
ret

read_char:
    mov ah, 0
    int 16h
ret

print_char:
    mov ah, 0eh
    int 10h
ret

printString:
	lodsb
	mov cl, 0
	cmp cl, al
	je .done
	mov ah, 0xe
	int 0x10
	jmp printString
	.done:
ret

menu:
	mov al, black
	call LimpaArea

	mov  dl, 12
	mov  dh, 9
	mov  bh, 0
	mov  bl, yellow
	mov  ah, 02h
	int  10h
	mov si, titulo
	call printString

	mov  dl, 0
	mov  dh, 22
	mov  ah, 02h
	int  10h
	mov si, inst
	call printString

	call read_char
ret

tutorial:
	call DrawMaze1
	mov al, red
	mov cx, 10
	mov dx, 10
	call DrawPers

	mov  bl, yellow
	mov  dl, 8
	mov  dh, 8
	mov  ah, 02h
	int  10h
	mov si, comando
	call printString

	mov  dl, 4
	mov  dh, 13
	mov  ah, 02h
	int  10h
	mov si, inst1
	call printString

	mov  dl, 9
	mov  dh, 14
	mov  ah, 02h
	int  10h
	mov si, inst2
	call printString

	mov  dl, 8
	mov  dh, 16
	mov  ah, 02h
	int  10h
	mov si, inst3
	call printString

	mov  dl, 7
	mov  dh, 17
	mov  ah, 02h
	int  10h
	mov si, inst4
	call printString

	mov  dl, 4
	mov  dh, 19
	mov  ah, 02h
	int  10h
	mov si, inst5
	call printString

	mov  dl, 5
	mov  dh, 20
	mov  ah, 02h
	int  10h
	mov si, inst6
	call printString

	mov  dl, 13
	mov  dh, 22
	mov  ah, 02h
	int  10h
	mov si, inst7
	call printString

	call read_char
ret

scoreboard:
	mov al, black
	call LimpaArea

	mov bl, yellow
	mov dl, 2
	mov dh, 5
	mov ah, 02h
	int 10h
	mov si, pontuacao1
	call printString

	mov dl, 18
	mov dh, 7
	mov ah, 02h
	int 10h

	mov ax, [score]
	sub ax, 8
	cmp ax, 10
	jl umdig

	mov dx, 0
	mov bx, 10
	div bx
	add al, '0'
	mov bl, yellow
	call print_char
	mov al, dl

	umdig:
	mov bl, yellow
	add al, '0'
	call print_char

	mov  dl, 15
	mov  dh, 9
	mov  ah, 02h
	int  10h
	mov si, pontuacao2
	call printString

	mov  dl, 7
	mov  dh, 16
	mov  ah, 02h
	int  10h
	mov si, pontuacao3
	call printString

	mov  dl, 4
	mov  dh, 20
	mov  ah, 02h
	int  10h
	mov si, pontuacao4
	call printString

	mov  dl, 7
	mov  dh, 21
	mov  ah, 02h
	int  10h
	mov si, pontuacao5
	call printString

	call read_char
ret

nv1:
	push ax
	mov ax, [score]
	inc ax
	mov [score], ax
	pop ax

	call DrawMaze1

	mov al, red
	mov cx, 10
	mov dx, 10
	call DrawPers

	call read_char

	mov al, black
	call LimpaArea
	mov al, red
	call DrawPers

	call read_char
	cmp ah, rightarrow
	jne nv1
	call move_right

	call read_char
	cmp ah, downarrow
	jne nv1
	call move_down

	call read_char
	cmp ah, downarrow
	jne nv1
	call move_down

	call read_char
	cmp ah, leftarrow
	jne nv1
	call move_left

	call read_char
	cmp ah, downarrow
	jne nv1
	call move_down

	call read_char
	cmp ah, downarrow
	jne nv1
	call move_down

	call read_char
	cmp ah, rightarrow
	jne nv1
	call move_right

	call read_char
	cmp ah, rightarrow
	jne nv1
	call move_right

	call read_char
	cmp ah, uparrow
	jne nv1
	call move_up

	call read_char
	cmp ah, rightarrow
	jne nv1
	call move_right

	call read_char
	cmp ah, rightarrow
	jne nv1
	call move_right

	call read_char
	cmp ah, downarrow
	jne nv1
	call move_down

	call read_char
	cmp ah, rightarrow
	jne nv1
	call move_right

	call read_char
	cmp ah, rightarrow
	jne nv1
	call move_right

	call read_char
	cmp ah, uparrow
	jne nv1
	call move_up

	call read_char
	cmp ah, uparrow
	jne nv1
	call move_up

	call read_char
	cmp ah, leftarrow
	jne nv1
	call move_left

	call read_char
	cmp ah, uparrow
	jne nv1
	call move_up

	call read_char
	cmp ah, uparrow
	jne nv1
	call move_up

	call read_char
	cmp ah, rightarrow
	jne nv1
	call move_right

	call read_char
	cmp ah, rightarrow
	jne nv1
	call move_right

	call read_char
	cmp ah, downarrow
	jne nv1
	call move_down


	mov al, green
	call LimpaArea

ret

nv2:
	push ax
	mov ax, [score]
	inc ax
	mov [score], ax
	pop ax

	call DrawMaze2

	mov al, red
	mov cx, 290
	mov dx, 50
	call DrawPers

	call read_char

	mov al, black
	call LimpaArea

	mov al, red
	mov cx, 290
	mov dx, 50
	call DrawPers

	call read_char
	cmp ah, downarrow
	jne nv2
	call move_down

	call read_char
	cmp ah, downarrow
	jne nv2
	call move_down

	call read_char
	cmp ah, downarrow
	jne nv2
	call move_down

	call read_char
	cmp ah, leftarrow
	jne nv2
	call move_left

	call read_char
	cmp ah, leftarrow
	jne nv2
	call move_left

	call read_char
	cmp ah, leftarrow
	jne nv2
	call move_left

	call read_char
	cmp ah, leftarrow
	jne nv2
	call move_left

	call read_char
	cmp ah, uparrow
	jne nv2
	call move_up

	call read_char
	cmp ah, uparrow
	jne nv2
	call move_up

	call read_char
	cmp ah, rightarrow
	jne nv2
	call move_right

	call read_char
	cmp ah, rightarrow
	jne nv2
	call move_right
	
	call read_char
	cmp ah, uparrow
	jne nv2
	call move_up

	call read_char
	cmp ah, uparrow
	jne nv2
	call move_up

	call read_char
	cmp ah, leftarrow
	jne nv2
	call move_left

	call read_char
	cmp ah, leftarrow
	jne nv2
	call move_left

	call read_char
	cmp ah, leftarrow
	jne nv2
	call move_left

	call read_char
	cmp ah, downarrow
	jne nv2
	call move_down

	call read_char
	cmp ah, leftarrow
	jne nv2
	call move_left

	call read_char
	cmp ah, leftarrow
	jne nv2
	call move_left

	call read_char
	cmp ah, downarrow
	jne nv2
	call move_down

	call read_char
	cmp ah, downarrow
	jne nv2
	call move_down

	call read_char
	cmp ah, rightarrow
	jne nv2
	call move_right

	call read_char
	cmp ah, downarrow
	jne nv2
	call move_down

	mov al, green
	call LimpaArea
ret

nv3:
	push ax
	mov ax, [score]
	inc ax
	mov [score], ax
	pop ax

	call DrawMaze3

	mov al, red
	mov cx, 50
	mov dx, 170
	call DrawPers

	call read_char

	mov al, black
	call LimpaArea

	mov al, red
	mov cx, 50
	mov dx, 170
	call DrawPers

	call read_char
	cmp ah, leftarrow
	jne nv3
	call move_left

	call read_char
	cmp ah, uparrow
	jne nv3
	call move_up

	call read_char
	cmp ah, uparrow
	jne nv3
	call move_up

	call read_char
	cmp ah, uparrow
	jne nv3
	call move_up

	call read_char
	cmp ah, rightarrow
	jne nv3
	call move_right

	call read_char
	cmp ah, uparrow
	jne nv3
	call move_up

	call read_char
	cmp ah, rightarrow
	jne nv3
	call move_right

	call read_char
	cmp ah, rightarrow
	jne nv3
	call move_right

	call read_char
	cmp ah, rightarrow
	jne nv3
	call move_right

	call read_char
	cmp ah, rightarrow
	jne nv3
	call move_right

	call read_char
	cmp ah, downarrow
	jne nv3
	call move_down

	call read_char
	cmp ah, downarrow
	jne nv3
	call move_down

	call read_char
	cmp ah, leftarrow
	jne nv3
	call move_left

	call read_char
	cmp ah, leftarrow
	jne nv3
	call move_left

	call read_char
	cmp ah, downarrow
	jne nv3
	call move_down

	call read_char
	cmp ah, downarrow
	jne nv3
	call move_down

	call read_char
	cmp ah, rightarrow
	jne nv3
	call move_right

	call read_char
	cmp ah, rightarrow
	jne nv3
	call move_right

	call read_char
	cmp ah, rightarrow
	jne nv3
	call move_right

	call read_char
	cmp ah, uparrow
	jne nv3
	call move_up

	call read_char
	cmp ah, rightarrow
	jne nv3
	call move_right

	call read_char
	cmp ah, uparrow
	jne nv3
	call move_up

	call read_char
	cmp ah, uparrow
	jne nv3
	call move_up

	call read_char
	cmp ah, uparrow
	jne nv3
	call move_up

	mov al, green
	call LimpaArea
ret

nv4:
	push ax
	mov ax, [score]
	inc ax
	mov [score], ax
	pop ax

	call DrawMaze4

	mov al, red
	mov dx, 10
	mov cx, 290
	call DrawPers

	call read_char

	mov al, black
	call LimpaArea

	mov al, red
	mov cx, 290
	mov dx, 10
	call DrawPers

	call read_char
	cmp ah, leftarrow
	jne nv4
	call move_left

	call read_char
	cmp ah, leftarrow
	jne nv4
	call move_left

	call read_char
	cmp ah, downarrow
	jne nv4
	call move_down

	call read_char
	cmp ah, leftarrow
	jne nv4
	call move_left

	call read_char
	cmp ah, leftarrow
	jne nv4
	call move_left

	call read_char
	cmp ah, uparrow
	jne nv4
	call move_up

	call read_char
	cmp ah, leftarrow
	jne nv4
	call move_left

	call read_char
	cmp ah, leftarrow
	jne nv4
	call move_left

	call read_char
	cmp ah, downarrow
	jne nv4
	call move_down

	call read_char
	cmp ah, leftarrow
	jne nv4
	call move_left

	call read_char
	cmp ah, downarrow
	jne nv4
	call move_down

	call read_char
	cmp ah, downarrow
	jne nv4
	call move_down

	call read_char
	cmp ah, rightarrow
	jne nv4
	call move_right

	call read_char
	cmp ah, downarrow
	jne nv4
	call move_down

	call read_char
	cmp ah, rightarrow
	jne nv4
	call move_right

	call read_char
	cmp ah, rightarrow
	jne nv4
	call move_right

	call read_char
	cmp ah, uparrow
	jne nv4
	call move_up

	call read_char
	cmp ah, rightarrow
	jne nv4
	call move_right

	call read_char
	cmp ah, rightarrow
	jne nv4
	call move_right

	call read_char
	cmp ah, downarrow
	jne nv4
	call move_down

	call read_char
	cmp ah, rightarrow
	jne nv4
	call move_right

	call read_char
	cmp ah, rightarrow
	jne nv4
	call move_right

	mov al, green
	call LimpaArea
ret

nv5:
	push ax
	mov ax, [score]
	inc ax
	mov [score], ax
	pop ax

	call DrawMaze5

	mov al, red
	mov dx, 170
	mov cx, 290
	call DrawPers

	call read_char

	mov al, black
	call LimpaArea

	mov al, red
	mov cx, 290
	mov dx, 170
	call DrawPers

	call read_char
	cmp ah, leftarrow
	jne nv5
	call move_left

	call read_char
	cmp ah, leftarrow
	jne nv5
	call move_left

	call read_char
	cmp ah, uparrow
	jne nv5
	call move_up

	call read_char
	cmp ah, uparrow
	jne nv5
	call move_up

	call read_char
	cmp ah, rightarrow
	jne nv5
	call move_right

	call read_char
	cmp ah, uparrow
	jne nv5
	call move_up

	call read_char
	cmp ah, uparrow
	jne nv5
	call move_up

	call read_char
	cmp ah, leftarrow
	jne nv5
	call move_left

	call read_char
	cmp ah, leftarrow
	jne nv5
	call move_left

	call read_char
	cmp ah, downarrow
	jne nv5
	call move_down

	call read_char
	cmp ah, leftarrow
	jne nv5
	call move_left

	call read_char
	cmp ah, downarrow
	jne nv5
	call move_down

	call read_char
	cmp ah, downarrow
	jne nv5
	call move_down

	call read_char
	cmp ah, leftarrow
	jne nv5
	call move_left

	call read_char
	cmp ah, downarrow
	jne nv5
	call move_down

	call read_char
	cmp ah, leftarrow
	jne nv5
	call move_left

	call read_char
	cmp ah, leftarrow
	jne nv5
	call move_left

	call read_char
	cmp ah, uparrow
	jne nv5
	call move_up

	call read_char
	cmp ah, uparrow
	jne nv5
	call move_up

	call read_char
	cmp ah, rightarrow
	jne nv5
	call move_right

	call read_char
	cmp ah, uparrow
	jne nv5
	call move_up

	call read_char
	cmp ah, uparrow
	jne nv5
	call move_up

	call read_char
	cmp ah, leftarrow
	jne nv5
	call move_left

	mov al, green
	call LimpaArea
ret

nv6:
	push ax
	mov ax, [score]
	inc ax
	mov [score], ax
	pop ax

	call DrawMaze6

	mov al, red
	mov dx, 10
	mov cx, 10
	call DrawPers

	call read_char

	mov al, black
	call LimpaArea

	mov al, red
	mov cx, 10
	mov dx, 10
	call DrawPers

	call read_char
	cmp ah, downarrow
	jne nv6
	call move_down

	call read_char
	cmp ah, downarrow
	jne nv6
	call move_down

	call read_char
	cmp ah, rightarrow
	jne nv6
	call move_right

	call read_char
	cmp ah, rightarrow
	jne nv6
	call move_right

	call read_char
	cmp ah, uparrow
	jne nv6
	call move_up

	call read_char
	cmp ah, rightarrow
	jne nv6
	call move_right

	call read_char
	cmp ah, uparrow
	jne nv6
	call move_up

	call read_char
	cmp ah, rightarrow
	jne nv6
	call move_right

	call read_char
	cmp ah, rightarrow
	jne nv6
	call move_right

	call read_char
	cmp ah, rightarrow
	jne nv6
	call move_right

	call read_char
	cmp ah, downarrow
	jne nv6
	call move_down

	call read_char
	cmp ah, downarrow
	jne nv6
	call move_down

	call read_char
	cmp ah, rightarrow
	jne nv6
	call move_right

	call read_char
	cmp ah, downarrow
	jne nv6
	call move_down

	call read_char
	cmp ah, downarrow
	jne nv6
	call move_down

	call read_char
	cmp ah, leftarrow
	jne nv6
	call move_left

	call read_char
	cmp ah, leftarrow
	jne nv6
	call move_left

	call read_char
	cmp ah, uparrow
	jne nv6
	call move_up

	call read_char
	cmp ah, leftarrow
	jne nv6
	call move_left

	call read_char
	cmp ah, leftarrow
	jne nv6
	call move_left

	call read_char
	cmp ah, downarrow
	jne nv6
	call move_down

	call read_char
	cmp ah, leftarrow
	jne nv6
	call move_left

	call read_char
	cmp ah, leftarrow
	jne nv6
	call move_left
	
	call read_char
	cmp ah, leftarrow
	jne nv6
	call move_left

	mov al, green
	call LimpaArea
ret

nv7:
	push ax
	mov ax, [score]
	inc ax
	mov [score], ax
	pop ax

	call DrawMaze7

	mov al, red
	mov dx, 170
	mov cx, 10
	call DrawPers

	call read_char

	mov al, black
	call LimpaArea

	mov al, red
	mov cx, 10
	mov dx, 170
	call DrawPers

	call read_char
	cmp ah, uparrow
	jne nv7
	call move_up

	call read_char
	cmp ah, uparrow
	jne nv7
	call move_up

	call read_char
	cmp ah, uparrow
	jne nv7
	call move_up

	call read_char
	cmp ah, uparrow
	jne nv7
	call move_up

	call read_char
	cmp ah, rightarrow
	jne nv7
	call move_right

	call read_char
	cmp ah, rightarrow
	jne nv7
	call move_right

	call read_char
	cmp ah, downarrow
	jne nv7
	call move_down

	call read_char
	cmp ah, downarrow
	jne nv7
	call move_down

	call read_char
	cmp ah, downarrow
	jne nv7
	call move_down

	call read_char
	cmp ah, rightarrow
	jne nv7
	call move_right

	call read_char
	cmp ah, downarrow
	jne nv7
	call move_down

	call read_char
	cmp ah, rightarrow
	jne nv7
	call move_right

	call read_char
	cmp ah, rightarrow
	jne nv7
	call move_right

	call read_char
	cmp ah, rightarrow
	jne nv7
	call move_right

	call read_char
	cmp ah, rightarrow
	jne nv7
	call move_right

	call read_char
	cmp ah, uparrow
	jne nv7
	call move_up

	call read_char
	cmp ah, uparrow
	jne nv7
	call move_up

	call read_char
	cmp ah, leftarrow
	jne nv7
	call move_left

	call read_char
	cmp ah, leftarrow
	jne nv7
	call move_left

	call read_char
	cmp ah, leftarrow
	jne nv7
	call move_left

	call read_char
	cmp ah, uparrow
	jne nv7
	call move_up

	call read_char
	cmp ah, uparrow
	jne nv7
	call move_up

	call read_char
	cmp ah, rightarrow
	jne nv7
	call move_right

	call read_char
	cmp ah, rightarrow
	jne nv7
	call move_right

	call read_char
	cmp ah, rightarrow
	jne nv7
	call move_right

	mov al, green
	call LimpaArea
ret

nv8:
	push ax
	mov ax, [score]
	inc ax
	mov [score], ax
	pop ax

	call DrawMaze8

	mov al, red
	mov dx, 10
	mov cx, 290
	call DrawPers

	call read_char

	mov al, black
	call LimpaArea

	mov al, red
	mov cx, 290
	mov dx, 10
	call DrawPers

	call read_char
	cmp ah, leftarrow
	jne nv8
	call move_left

	call read_char
	cmp ah, leftarrow
	jne nv8
	call move_left

	call read_char
	cmp ah, downarrow
	jne nv8
	call move_down

	call read_char
	cmp ah, downarrow
	jne nv8
	call move_down

	call read_char
	cmp ah, leftarrow
	jne nv8
	call move_left

	call read_char
	cmp ah, leftarrow
	jne nv8
	call move_left

	call read_char
	cmp ah, uparrow
	jne nv8
	call move_up

	call read_char
	cmp ah, leftarrow
	jne nv8
	call move_left

	call read_char
	cmp ah, uparrow
	jne nv8
	call move_up

	call read_char
	cmp ah, leftarrow
	jne nv8
	call move_left

	call read_char
	cmp ah, leftarrow
	jne nv8
	call move_left

	call read_char
	cmp ah, downarrow
	jne nv8
	call move_down

	call read_char
	cmp ah, downarrow
	jne nv8
	call move_down

	call read_char
	cmp ah, rightarrow
	jne nv8
	call move_right

	call read_char
	cmp ah, downarrow
	jne nv8
	call move_down

	call read_char
	cmp ah, downarrow
	jne nv8
	call move_down

	call read_char
	cmp ah, rightarrow
	jne nv8
	call move_right

	call read_char
	cmp ah, rightarrow
	jne nv8
	call move_right

	call read_char
	cmp ah, rightarrow
	jne nv8
	call move_right

	call read_char
	cmp ah, rightarrow
	jne nv8
	call move_right

	call read_char
	cmp ah, rightarrow
	jne nv8
	call move_right

	call read_char
	cmp ah, rightarrow
	jne nv8
	call move_right

	call read_char
	cmp ah, uparrow
	jne nv8
	call move_up

	call read_char
	cmp ah, uparrow
	jne nv8
	call move_up

	mov al, green
	call LimpaArea
ret

move_left:
	call clean_move
	sub cx, 40
	call make_move
ret

move_right:
	call clean_move
	add cx, 40
	call make_move
ret

move_up:
	call clean_move
	sub dx, 40
	call make_move
ret

move_down:
	call clean_move
	add dx, 40
	call make_move
ret

clean_move:
	mov al, black
	call DrawPers
ret

make_move:
	mov al, red
	call DrawPers
ret

DrawMaze1:
	mov al, grey
	call LimpaArea

	mov al, brown
	mov dx, 40
	mov cx, 0
	call DrawWall
	mov dx, 0
	mov cx, 80
	call DrawWall
	mov dx, 40
	call DrawWall
	mov dx, 80
	call DrawWall
	mov dx, 120
	mov cx, 40
	call DrawWall
	mov cx, 120
	mov dx, 0
	call DrawWall
	mov dx, 40
	call DrawWall
	mov dx, 80
	call DrawWall
	mov dx, 160
	call DrawWall
	mov cx, 160
	mov dx, 0
	call DrawWall
	mov dx, 40
	call DrawWall
	mov dx, 80
	call DrawWall
	mov cx, 200
	mov dx, 120
	call DrawWall
	mov dx, 40
	mov cx, 240
	call DrawWall
	mov dx, 80
	mov cx, 280
	call DrawWall
	mov dx, 120
	call DrawWall
	mov dx, 160
	call DrawWall

	mov cx, 280
	mov dx, 40
	mov al, green
	call DrawWall
ret


DrawMaze2:
	mov al, grey
	call LimpaArea

	mov al, brown
	mov cx, 0
	mov dx, 0
	call DrawWall
	mov dx, 160
	call DrawWall
	mov cx, 40
	mov dx, 0
	call DrawWall
	mov dx, 80
	call DrawWall
	mov cx, 80
	call DrawWall
	mov dx, 120
	call DrawWall
	mov dx, 160
	call DrawWall
	mov cx, 120
	mov dx, 40
	call DrawWall
	mov cx, 160
	call DrawWall
	mov dx, 120
	call DrawWall
	mov cx, 200
	call DrawWall
	mov cx, 240
	call DrawWall
	mov dx, 80
	call DrawWall
	mov dx, 40
	call DrawWall
	mov dx, 0
	call DrawWall
	mov cx, 280
	call DrawWall

	mov cx, 40
	mov dx, 160
	mov al, green
	call DrawWall
ret

DrawMaze3:
	mov al, grey
	call LimpaArea

	mov al, brown
	mov cx, 0
	mov dx, 0
	call DrawWall
	mov cx, 240
	call DrawWall
	mov dx, 40
	call DrawWall
	mov cx, 160
	call DrawWall
	mov cx, 120
	call DrawWall
	mov cx, 80
	call DrawWall
	mov dx, 80
	call DrawWall
	mov dx, 120
	call DrawWall
	mov dx, 80
	mov cx, 240
	call DrawWall
	mov cx, 40
	call DrawWall
	mov dx, 120
	call DrawWall
	mov cx, 160
	call DrawWall
	mov cx, 200
	call DrawWall
	mov dx, 160
	mov cx, 80
	call DrawWall
	mov cx, 280
	call DrawWall

	mov cx, 280
	mov dx, 0
	mov al, green
	call DrawWall
ret

DrawMaze4:
	mov al, grey
	call LimpaArea

	mov al, brown
	mov cx, 0
	mov dx, 0
	call DrawWall
	mov cx, 160
	call DrawWall
	mov dx, 80
	call DrawWall
	mov cx, 40
	call DrawWall
	mov cx, 80
	call DrawWall
	mov cx, 120
	call DrawWall
	mov cx, 200
	call DrawWall
	mov cx, 240
	call DrawWall
	mov cx, 280
	call DrawWall
	mov dx, 40
	call DrawWall
	mov cx, 240
	call DrawWall
	mov dx, 120
	call DrawWall
	mov cx, 280
	call DrawWall
	mov cx, 80
	call DrawWall
	mov dx, 40
	call DrawWall
	mov dx, 160
	mov cx, 0
	call DrawWall
	mov cx, 160
	call DrawWall

	mov cx, 280
	mov al, green
	call DrawWall
ret

DrawMaze5:
	mov al, grey
	call LimpaArea

	mov al, brown
	mov cx, 80
	mov dx, 0
	call DrawWall
	mov cx, 120
	call DrawWall
	mov cx, 280
	call DrawWall
	mov dx, 40
	call DrawWall
	mov cx, 200
	call DrawWall
	mov cx, 0
	call DrawWall
	mov cx, 80
	call DrawWall
	mov dx, 80
	call DrawWall
	mov cx, 160
	call DrawWall
	mov cx, 280
	call DrawWall
	mov dx, 120
	call DrawWall
	mov cx, 240
	call DrawWall
	mov cx, 40
	call DrawWall
	mov cx, 160
	call DrawWall
	mov dx, 160
	call DrawWall
	mov cx, 120
	call DrawWall

	mov cx, 0
	mov dx, 0
	mov al, green
	call DrawWall
ret

DrawMaze6:
	mov al, grey
	call LimpaArea

	mov al, brown
	mov cx, 40
	mov dx, 0
	call DrawWall
	mov cx, 80
	call DrawWall
	mov cx, 280
	call DrawWall
	mov dx, 40
	call DrawWall
	mov cx, 200
	call DrawWall
	mov cx, 40
	call DrawWall
	mov cx, 160
	call DrawWall
	mov dx, 80
	call DrawWall
	mov cx, 120
	call DrawWall
	mov cx, 200
	call DrawWall
	mov dx, 120
	mov cx, 0
	call DrawWall
	mov cx, 40
	call DrawWall
	mov cx, 80
	call DrawWall
	mov cx, 240
	call DrawWall
	mov dx, 160
	mov cx, 160
	call DrawWall

	mov cx, 0
	mov al, green
	call DrawWall
ret

DrawMaze7:
	mov al, grey
	call LimpaArea

	mov al, brown
	mov cx, 120
	mov dx, 0
	call DrawWall
	mov dx, 40
	call DrawWall
	mov cx, 280
	call DrawWall
	mov cx, 240
	call DrawWall
	mov cx, 200
	call DrawWall
	mov cx, 40
	call DrawWall
	mov dx, 80
	call DrawWall
	mov dx, 120
	call DrawWall
	mov dx, 160
	call DrawWall
	mov cx, 80
	call DrawWall
	mov dx, 120
	mov cx, 160
	call DrawWall
	mov cx, 200
	call DrawWall
	mov cx, 240
	call DrawWall
	mov dx, 80
	mov cx, 120
	call DrawWall

	mov dx, 0
	mov cx, 280
	mov al, green
	call DrawWall
ret

DrawMaze8:
	mov al, grey
	call LimpaArea

	mov al, brown
	mov cx, 120
	mov dx, 0
	call DrawWall
	mov cx, 160
	call DrawWall
	mov dx, 40
	call DrawWall
	mov cx, 40
	call DrawWall
	mov cx, 240
	call DrawWall
	mov dx, 80
	call DrawWall
	mov cx, 80
	call DrawWall
	mov dx, 120
	call DrawWall
	mov cx, 120
	call DrawWall
	mov cx, 160
	call DrawWall
	mov cx, 200
	call DrawWall
	mov cx, 240
	call DrawWall
	mov cx, 0
	call DrawWall
	mov dx, 160
	call DrawWall
	mov dx, 40
	mov cx, 280
	call DrawWall

	mov dx, 80
	mov al, green
	call DrawWall
ret

;funcao que desenha um bloco 40x40 a partir da posicao cx e dx
;dx = linha // cx = coluna // janela: 200x320
DrawWall:
	mov bx, dx
	add bx, 40

	.forwall:
		cmp dx, bx
		je .endforwall

		push bx
		mov bx, cx
		add bx, 40

		.forwall2:
			cmp cx, bx
			je .endforwall2

			call print_pixel
			inc cx

			jmp .forwall2

		.endforwall2:

		sub cx, 40
		pop bx

		inc dx
		jmp .forwall

	.endforwall:
	sub dx, 40
ret

;Desenha um quadradinho 20x20
DrawPers:
	mov bx, dx
	add bx, 20

	.forpers:
		cmp dx, bx
		je .endforpers

		push bx
		mov bx, cx
		add bx, 20

		.forpers2:
			cmp cx, bx
			je .endforpers2

			call print_pixel
			inc cx

			jmp .forpers2

		.endforpers2:

		sub cx, 20
		pop bx

		inc dx
		jmp .forpers

	.endforpers:
	sub dx, 20
ret

;Desenha em toda janela com a cor em al
LimpaArea:
	push dx
	push cx

	mov dx, 0
	.ForLA:
		cmp dx, 200
		je .endForLA

		mov cx, 0

		.forinLA:
			cmp cx, 320
			je .endForinLA

			call print_pixel
			inc cx
			jmp .forinLA

		.endForinLA:

		inc dx
		jmp .ForLA

	.endForLA:

	pop cx
	pop dx
ret

done:
	jmp $