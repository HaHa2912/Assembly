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
    tb4 db 10,13,'Nhap chuoi hoa: $'
    tb5 db 10,13,'Chuoi thuong la: $'
    str db 100,?,100 dup('$')
    count db 0

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
intb4:
    inchuoi tb4
    lea si, str
    xor cx, cx
    nhapchuoi:
        mov ah, 01h
        int 21h
        cmp al, 0Dh
        je intb5
        mov [si], al
        inc si
        inc cx
        jmp nhapchuoi
    
intb5:
    inchuoi tb5
    lea si, str
    xuat:
        mov dl, [si]
        cmp dl, 'A'
        jae soZ
        jb inkytu
        
        soZ:
            cmp dl, 'Z'
            jbe doi
            jmp inkytu
            
        inkytu:
            mov ah, 02h
            int 21h
            inc si
            dec cx
            cmp cx, 0
            je thoat
            jmp xuat
            
        doi:
            add dl, 20h
            jmp inkytu

thoat:
    mov ah, 08h
    int 21h    
    mov ah, 4Ch
    int 21h
    main endp
end main