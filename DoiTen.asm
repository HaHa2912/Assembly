inchuoi macro chuoi
    mov ah, 09h
    lea dx, chuoi
    int 21h
endm

.model small
.stack 100
.data 
    tb1 db 'Nhap ma SV: $'
    tb2 db 10,13,'Ho ten SV la Tran Thi Ha.$'
    tb3 db 10,13,'Thong tin sai!!!$'
    masv db 100,8,100 dup('$')
    masv1 db 'at160614'
    masv2 db 'AT160614'
    xdong db 10,13,'$'
    tb4 db 10,13,'Nhap ten tep cu: $'
    tencu db 30 dup(?),0
    tb5 db 10,13,'Nhap ten tep moi: $'
    tenmoi db 30 dup(?),0
    tb7 db 10,13,'Doi thanh cong.$'

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
    nhapten1:
        mov ah, 01h
        int 21h
        cmp al, 0Dh
        je intb5
        mov tencu[si], al
        inc si
        jmp nhapten1
        
intb5:
    inchuoi tb5
    mov si, 0
    nhapten2:
        mov ah, 01h
        int 21h
        cmp al, 0Dh
        je doiten
        mov tenmoi[si], al
        inc si
        jmp nhapten2
        
doiten:
    mov ah, 56h
    lea dx, tencu
    lea di, tenmoi
    int 21h
    inchuoi tb7
    
thoat:
    mov ah, 4Ch
    int 21h
    main endp
end main