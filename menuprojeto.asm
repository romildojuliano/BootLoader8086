org 0x7c00
jmp 0x0000:parameters

data:
	newline8 db 0x0A, 0x0A, 0x0A, 0x0A, 0x0A, 0x0A, 0x0A, 0x0A, 0x0D, 0
	hello db ' Hello, welcome to the blind labyrinth!', 0x0D, 0x0A, 0
	areyou db ' Are you ready to face the challenge?', 0x0A, 0x0D, 0
	option1 db '      Yes!', 0x0D, 0x0A, 0
	option2 db '      Of course!', 0x0D, 0x0A, 0
	executing db ' The game is being executed... ', 0x0D, 0x0A, 0
	title db '           THE BLIND LABYRINTH', 0x0D, 0x0A, 0
	commands db ' COMMANDS:', 0x0d, 0x0A, 0
	space db ' SPACE: START', 0x0d, 0x0a, 0
	presst db ' T: TUTORIAL', 0x0d, 0x0a, 0
	newline db 0x0A, 0x0D, 0
	newline3 db 0x0A, 0x0A, 0x0A, 0x0D, 0
	uparrow equ $11
  	downarrow equ $1F

parameters:
;Zerar os parametros
	xor AX, AX
	mov DS, AX
	mov CL, 0

;Chamada de função para habilitar o modo monitor VGA 200 x 320 (Modo diferente de habilitar)
videomode:
	mov AH, 0
	mov AL, 13h
	int 10h
;Pinta o terminal
paintTerminal:
	mov AH, 0xb
	mov BH, 0
	mov BL, 4
	int 10h

main:
;Define a string a ser printada
	mov SI, newline8
	call printString

	mov SI, hello
	call printString

	mov SI, areyou
	call printString

	mov SI, option1
	call printString

	mov SI, option2
	call printString

	call curUp
loop:
	call getchar
	cmp AH, downarrow
	je setdown

	cmp AH, uparrow
	je setup

	cmp AL, 0x0d
	je exitloop

	jmp loop
exitloop:

titlescreen:
	mov AH, 00h
	mov AL, 13h
	int 10h

	mov SI, newline
	call printString

	mov SI, title
	call printString

	mov SI, newline3
	call printString

	mov SI, presst
	call printString

	mov SI, newline
	call printString

	mov SI, space
	call printString
	call getchar

backtextmode:
	mov AH, 0
	mov AL, 03h
	int 10h
	call drawNone

	mov SI, executing
	call printString

.deleteCursor:
	call drawNone
jmp .deleteCursor

;BLOCO DAS FUNÇÕES:

	setdown: ;Coloca o cursor na opção de baixo
		call drawNone
		call curDown
		jmp loop
	ret

	setup: ;Coloca o cursor na posição de cima
		call drawNone
		call curUp
		jmp loop
	ret

;Desenha a seta para indicar a opção atual
	drawArrow:
		mov AH, 0AH
		mov AL, 62
		mov BL, 1
		mov BH, 0
		mov CX, 1
		int 10h
	ret

;Desenha um espaço em branco na posição atual
	drawNone:
		mov AH, 0AH
		mov AL, 32
		mov BL, 1
		mov BH, 0
		mov CX, 1
		int 10h
	ret

;Move o cursor para baixo e chama a função para pintar a seta
	curDown:
		mov AH, 02H
		mov BH, 0
		mov DH, 11
		mov DL, 4
		int 10h
		call drawArrow
	ret

;Move o cursor para cima e chama a função para pintar a seta
	curUp:
		mov AH, 02H
		mov BH, 0
		mov DH, 10
		mov DL, 4
		int 10h
		call drawArrow
	ret
;Recebe um caractere do teclado
	getchar:
		mov AH, 0x00
		int 16h
	ret

;Printa as palavras chamadas
	printString:
		lodsb
		mov CL, 0
		cmp CL, AL
		je .done
		mov AH, 0xe
		mov BH, 0
		mov BL, 2
		int 0x10
	jmp printString
	.done:
	ret
end:
times 510-($-$$) db 0
dw 0xAA55
