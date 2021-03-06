inchuoi macro chuoi
    mov ah, 09h
    lea dx, chuoi
    int 21h
endm

.model small
.stack 50
.data 
    tb1 db 'Nhap ma SV gom 8 ky tu: $'
    tb2 db 10,13,'Ho ten SV la Tran Thi Ha.$'
    tb3 db 10,13,'Thong tin sai!!!$'
    masv db 100,8,100 dup('$')
    masv1 db 'at160614'
    masv2 db 'AT160614'
    tb4 db 10,13,'Nhap chuoi: $'
    tb5 db 10,13,'Ky tu hoa la: $'
    str db 100,?,100 dup('$')
    xdong db 10,13,'$'
    kytu db ?
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
    nhap:
        mov ah, 01h
        int 21h
        cmp al, 0Dh
        je chuyen
        mov [si], al
        inc si
        inc cx
        inc count
        jmp nhap
    
chuyen:
    inchuoi tb5
    lea si, str
    xor cx, cx
    xuat:
        xor dx,dx
        mov dl, [si]
        cmp dl, 'A'
        jae soZ
        jb inkytu
        
        soZ:
        cmp dl, 'Z'
        jbe inkytu
        sub dl, 20h 
        mov ah, 02h
        int 21h
        dec count
        inc si
        cmp count , 0
        je thoat
        jmp xuat
   
inkytu:
    mov ah, 02h
    int 21h
    dec count
    inc si 
    cmp count, 0
    je thoat
    jmp xuat
      
thoat:
    mov ah, 08h
    int 21h    
    mov ah, 4Ch
    int 21h
    main endp
end main