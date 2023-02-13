segment .data
	output db "Chuoi dao nguoc: ", 0
	len_output equ $-output

segment .bss
	
	msg resb 50
	len_msg resb 50

	; tao 2 bien dem
	dem  resb 2
	dem1 resb 2


segment .text

	global _start

_start:
	mov eax, 3 ; sys_read
	mov ebx, 0
	mov ecx, msg

	mov byte [dem], 0x30 ; dem = 0
	mov byte [dem1], 0x30 ; dem1 = 0
	mov edx, 50
	mov esi, len_msg
	int 0x80

_loop:
	cmp byte [ecx], 0x00 ; so sanh [ecx]
	je _reverse ; nhay dem ham _reverse
	inc ecx ; ecx = ecx + 1
	inc byte [dem]
	inc byte [dem1]
	jmp _loop ; lap lai

_reverse:
	cmp byte [dem1], 0x30 ; so sanh dem1
	je _output ; nhay dem ham _output
	mov al, [ecx-1] ; chu cai cuoi cua msg
	mov [esi], al

	dec byte [dem1]
	dec ecx ; ecx = ecx -1
	inc esi ; esi = esi + 1
	jmp _reverse ; lap lai

_output:
	int 0x80 ; goi kernel
	mov eax, 4 ; sys_write
	mov ebx, 1 ; stdin
	mov ecx, output ; in output
	mov edx, len_output ; do dai output

	int 0x80
	mov eax, 4
	mov ebx, 1
	mov byte [esi+1], 0xA
	mov ecx, len_msg
	mov edx, 50d
	int 0x80

	mov eax, 1 ; sys_exit
	int 0x80

