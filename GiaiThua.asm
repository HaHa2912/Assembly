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
    masv1 db 'at160614'
    masv2 db 'AT160614'
    tb4 db 10,13,'Nhap n: $'
    n dw ?
    tb5 db 10,13,'Gia tri n! la: $'
    gt dw 1

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
    jmp thoat
    
intb2:
    inchuoi tb2
    lap:
    inchuoi tb4
    mov ah, 01h
    int 21h
    cmp al, 30h
    je lap  
    mov ah, 0
    mov n, ax
    inchuoi tb5
    sub n, 30h
    mov bx,n
    mov ax, gt
    nhan:
        mul bx
        dec bx
        cmp bx, 0
        je chuyen
        jmp nhan
        
chuyen:
    mov gt, ax
    mov bx, 10
    mov ax, gt
    xor cx,cx
    chia:
        xor dx, dx
        div bx
        add dl, 30h 
        push dx
        inc cx
        cmp ax, 0
        je xuat
        jmp chia
    xuat:
        pop dx
        mov ah, 02h
        int 21h
        loop xuat 
    
thoat:
    mov ah, 08h
    int 21h    
    mov ah, 4Ch
    int 21h
    main endp
end main