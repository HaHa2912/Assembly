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
    chuoi db 0,1,2,3,4,5,6,7,8,-9
    tb4 db 10,13,'Tong cac phan tu trong chuoi la: $'
    sum db 0

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
    lea si, chuoi
    mov cx, 10
    tinhtong:
        xor dx, dx
        mov dl, [si]
        add sum, dl
        inc si
        dec cx
        cmp cx, 0
        je intb4
        jmp tinhtong
        
intb4:
    inchuoi tb4
    chuyen:
    mov bx, 10
    mov ah, 0
    mov al, sum
    xor cx, cx
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