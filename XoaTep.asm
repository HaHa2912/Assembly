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
    xdong db 10,13,'$'
    tb4 db 10,13,'Nhap ten tep: $'
    ten db 30 dup(?),0
    pointer dw ?
    tb5 db 10,13,'Xoa thanh cong.$'

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
    inchuoi tb4
    mov si, 0
nhapten:
    mov ah, 01h
    int 21h
    cmp al, 0Dh
    je xoatep
    mov ten[si], al
    inc si
    jmp nhapten
    
xoatep:
    mov ah, 41h
    lea dx, ten
    int 21h
    inchuoi tb5
    
thoat:
    mov ah, 08h
    int 21h    
    mov ah, 4Ch
    int 21h
    main endp
end main