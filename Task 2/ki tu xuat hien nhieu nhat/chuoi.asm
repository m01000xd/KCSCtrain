section .data
    msg db 'Nhap chuoi: ', 0
    output_msg db 'Ki tu xuat hien nhieu nhat la: %c, so lan xuat hien: %d',10 , 0

section .bss
    input_str resb 255
    char_count resb 256

section .text
    global _start

_start:
    ; In ra thông báo nhập chuỗi
    mov eax, 4
    mov ebx, 1
    mov ecx, msg
    mov edx, 12
    int 0x80

    ; Nhập chuỗi từ người dùng
    mov eax, 3
    mov ebx, 0
    mov ecx, input_str
    mov edx, 255
    int 0x80

    ; Đếm số lần xuất hiện của từng kí tự trong chuỗi
    mov esi, input_str       ; esi = địa chỉ bắt đầu của chuỗi
    xor eax, eax             ; eax = 0
    xor ebx, ebx             ; ebx = 0
    cld                      ; clear direction flag
count_loop:
    lodsb                    ; load byte from string to al, and increment esi
    cmp al, 0                ; end of string?
    je count_done
    inc byte [char_count + eax]  ; tăng biến đếm tương ứng với kí tự
    cmp byte [char_count + eax], bl ; so sánh với max_count
    jle count_loop
    mov bl, byte [char_count + eax] ; cập nhật max_count
    mov byte [max_char], al         ; lưu kí tự xuất hiện nhiều nhất
    jmp count_loop
count_done:
    ; In kết quả
    mov eax, 4
    mov ebx, 1
    mov ecx, output_msg
    mov edx, 50
    int 0x80

    ; Kết thúc chương trình
    mov eax, 1
    xor ebx, ebx
    int 0x80

section .data
    max_char db 0
