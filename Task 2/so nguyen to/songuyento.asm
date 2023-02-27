section .data
    str_input db "%d", 0
    str_output db "%d ", 0
    array_size equ 10
    array dd array_size dup(0)
    
section .text
    global _start
    
_start:
    ; Lap de lay mang input tu nguoi dung
    mov esi, array
    mov ecx, array_size
    get_input:
        ; doc input
        mov eax, 0 ; sys_read
        mov ebx, 0 ; stdin
        mov edx, str_input
        int 0x80
        
        ; chuyen input thanh so nguyen
        xor eax, eax
        mov ebx, esi
        call atoi
        
        ; kiem tra neu so la so nguyen to
        cmp eax, 2
        jl not_prime
        mov edx, 2
        check_prime:
            cmp edx, eax
            jg is_prime
            mov ebx, eax
            xor eax, eax
            div edx
            cmp edx, 0
            je not_prime
            inc edx
            jmp check_prime
        is_prime:
            ; Print prime number
            mov eax, ebx
            mov edx, str_output
            mov ebx, 1 ; stdout
            mov eax, 4 ; sys_write
            int 0x80
        
        ; chuyen den phan tu tiep theo
        add esi, 4
        dec ecx
        jnz get_input
    
    ; Thoat chuong trinh
    mov eax, 1 ; sys_exit
    xor ebx, ebx
    int 0x80
    
; Subroutine to convert input string to integer
; Input: ebx - pointer to input string
; Output: eax - integer value of input string
atoi:
    push eax
    push edx
    xor eax, eax
    mov edx, 10
    atoi_loop:
        cmp byte [ebx], 0
        je atoi_done
        movzx ecx, byte [ebx]
        sub ecx, '0'
        mul edx
        add eax, ecx
        inc ebx
        jmp atoi_loop
    atoi_done:
    pop edx
    pop eax
    ret

not_prime:
    ; chuyen toi phan tu tiep theo
    add esi, 4
    dec ecx
    jnz get_input
