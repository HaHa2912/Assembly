inchuoi macro chuoi
    mov ah, 09h
    lea dx, chuoi
    int 21h
endm

.model small
.stack 50
.data 
    tb1 db 'Nhap ma SV: $'
    tb2 db 10,13,'Ho ten SV la Tran Thi Ha.$'
    tb3 db 10,13,'Thong tin sai!!!$'
    masv db 100,8,100 dup('$')
    xdong db 10,13,'$'
    masv1 db 'at160614'
    masv2 db 'AT160614'
    chuoi db 1,2,3,4,5,6,7,8,9,10,11,12,13,14
    count db 0
    tb5 db 10,13,'So luong chia het la: $'

.code
main proc
    mov ax, @data
    mov ds, ax
    mov es, ax
    
    inchuoi tb1
    lea si, masv
    xor cx, cx
    nhapmasv: 
        mov ah, 01h
        int 21h
        mov [si], al
        inc cx 
        inc si
        cmp cx, 8
        je sosanh
        jmp nhapmasv

sosanh:
    cld ; chon chieu xu ly chuoi
    mov cx,8
    lea si, masv
    lea di, masv1
    repe cmpsb
    je intb2
    cld
    mov cx, 8
    lea si, masv
    lea di, masv2
    repe cmpsb
    je intb2 
    inchuoi tb3
    inchuoi xdong
    jmp main
    
intb2:
    inchuoi tb2
nhaplai: 
    mov si, 0
    mov cl, 14
    lap:
        xor ax, ax
        mov al, chuoi[si] 
        xor dx, dx
        mov bx, 1      ; nhap so bi chia
        idiv bx
        cmp dl, 0
        je tang
lap1:
     inc si
        cmp si, 14
        je xuat
        jmp lap
        
tang:
    inc count
    inc si
    cmp si, 14
    je xuat
    jmp lap
    
xuat:
inchuoi tb5
    xor cx, cx
    mov bx, 10
    mov ah, 0
    mov al, count
    chuyen:
        xor dx, dx
        div bx
        add dl, 30h
        push dx 
        inc cx
        cmp ax, 0
        je incount
        jmp chuyen
        
incount:
    pop dx
    mov ah, 02h
    int 21h
    loop incount
                
thoat:
    mov ah, 08h
    int 21h    
    mov ah, 4Ch
    int 21h
    main endp
end main