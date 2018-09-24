org 0x7c00
jmp 0x0000:start

data:
	word times 11 db 0

start:
	; Nunca se esqueca de zerar o ds,
	; Pois apartir dele que o processador busca os
	; Dados utilizados no programa.
	xor ax, ax
	mov ds, ax
	; Início do seu código
	jmp readWord
	call printString
ret

readWord:
	mov al, 0x0d
	push ax
	mov di, word
	stosb
	mov si, word
	lodsb
	.loop_read
		jmp readChar ; Pula para a função de ler um caractere

		cmp al, 0x0d ; Se o caractere digitado for o enter ('\n')...
		je .end_loop_read ; Sai do laço de leitura

		cmp al, 0x08 ; Se o caractere digitado for o backspace...
		je backspace ; Pula imediatamente para a função backspace

		push ax ; Adiciona um elemento à pilha
		call printChar ; Chama a função para printar o caractere

		jmp .loop_read ; Retorna ao começo para ler outro caractere
	.end_loop_read

	call newLine ; Printa uma linha no terminal
ret ; retorna o valor da função para a principal

printString:
	lodsb
	or al, al
	jz done
	mov ah, 0x0e
	int 0x10
	jmp printString
ret

done:
ret

printChar: ; Printa o caractere inserido pelo usuário
	mov ah, 0eh
	int 10h
ret

readChar: ; Lê o caractere inserido pelo usuário
	mov ah, 0eh
	int 10h
ret

newLine: ; Dá um ENTER no terminal
	mov al, 10
	call print_char
	mov al, 13
	call print_char
ret

backspace: ; Coloca o cursor em cima da última letra
	pop ax
	cmp al, 0x0d
	jmp correction

	mov al, 0x08
	call printChar
	mov al, ''
	call printChar
	mov al, 0x08
	call printChar
	jmp .loop_read
ret

correction: ; Apaga o caractere em que o cursor está em cima
	push ax
	jmp .loop_read
ret


jmp $
times 510 - ($ - $$) db 0		; preenche o resto do setor com zeros
dw 0xAA55			; coloca a assinatura de boot no final
				; do setor (x86 : little endian)
