inchuoi macro chuoi
    mov ah, 09h
    lea dx, chuoi
    int 21h
endm

.model small
.stack 50
.data
    tb db 'Ma SV bao gom 8 ky tu dang AT160*** hoac at160*** $' 
    tb1 db 10,13,'Nhap ma SV: $'
    tb2 db 10,13,'=> Ho ten SV la Tran Thi Ha.$'
    tb3 db 10,13,'Thong tin sai!!!$'
    masv db 100,8,100 dup('$')
    masv1 db 'at160614'
    masv2 db 'AT160614'
    tb4 db 10,13,'Nhap ten tep tin can tao: $'
    ten1 db 100 dup(?),0
    pointer1 dw ?
    tb5 db 10,13,'Tao tep tin thanh cong.$'
    tb6 db 10,13,'Nhap ten tep tin can ghi: $'
    ten2 db 100 dup(?),0
    pointer2 dw ?
    tb7 db 10,13,'Nhap noi dung: $'
    str db 100,?,100 dup('$')

.code
main proc
    mov ax, @data
    mov ds, ax
    mov es, ax
    inchuoi tb
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
    inchuoi tb4 
    mov si, 0
    nhapten1:
        mov ah, 01h
        int 21h
        cmp al, 0Dh
        je taotep
        mov ten1[si], al
        inc si
        jmp nhapten1
    ;tao tep tin
    taotep:
    mov ah, 3ch
    lea dx, ten1
    mov cx, 0
    int 21h 
    mov pointer1, ax
    
    inchuoi tb5
    inchuoi tb6
    mov si, 0
nhapten2:
        mov ah, 01h
        int 21h
        cmp al, 0Dh
        je nhapnd
        mov ten2[si], al
        inc si
        jmp nhapten2
nhapnd:
    inchuoi tb7
    lea si, str
    xor cx,cx
    nhap:
        mov ah, 01h
        int 21h
        cmp al, 0Dh
        je ghitep
        mov [si], al
        inc si
        inc cx
        jmp nhap 
ghitep:
    mov ah, 3dh
    lea dx, ten2
    mov al, 2
    int 21h
    mov pointer2, ax
    
    mov ah, 40h
    mov bx, pointer2
    lea dx, str
    int 21h
    
    mov ah, 3eh
    mov bx, pointer2
    int 21h
        
thoat:
    mov ah, 08h
    int 21h    
    mov ah, 4Ch
    int 21h
    main endp
end main