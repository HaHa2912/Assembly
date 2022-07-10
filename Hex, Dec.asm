inchuoi macro chuoi         ; tao ham de in chuoi ra man hinh
    mov ah, 09h
    lea dx, chuoi
    int 21h
endm

.model small     ; khai bao mo hinh loai nho
.stack 50        ; khai bao bien stack gom 50 phan tu
.data            ; khai bao bien/du lieu
    tb1 db 'Nhap ma SV: $'
    tb2 db 10,13,'Ho ten SV la Tran Thi Ha.$'
    tb3 db 10,13,'Thong tin sai!!!$'
    xdong db 10,13,'$'
    masv db 100,8,100 dup('$')
    masv1 db 'at160614'
    masv2 db 'AT160614'
    tb4 db 10,13,'Nhap vao so he thap phan: $'
    tb6 db 10,13,'==> Doi sang co so 16: $'
    tb5 db 10,13,'==> Doi sanh co so 2(16 bit): $' 
    x dw 0               ; dãy so
    y dw 0               ; so nhap vao

.code
main proc        ; phan ham chinh
    mov ax, @data
    mov ds, ax
    mov es, ax
    
    inchuoi tb1    ; in thong bao 1 ra man hinh
    lea si, masv    ; gan si la masv
    xor cx, cx      ; lam sach cx
    nhapmasv: 
        mov ah, 01h     ; nhap 1 ky tu
        int 21h
        mov [si], al     ; gan ky tu vua nhap vao gia tri si
        inc cx           ; tang cx, tang si len 1 don vi
        inc si
        cmp cx, 8        ; so sanh cx voi 8
        je sosanh         ; neu bang thi chuyen sang phan sosanh
        jmp nhapmasv      ;neu k bang thì quay lai nhapmasv

sosanh:
    cld ; chon chieu xu ly chuoi
    mov cx,8          ; so ky tu can so sanh la 8
    lea si, masv      ; gan dia chi nguon
    lea di, masv1      ; gan dia chi dich
    repe cmpsb        ; so sanh tung ky tu
    je intb2          ; neu bang thi chuyen intb2
    cld               ; neu k bang thi chon chieu xu ly chuoi
    mov cx, 8         ;
    lea si, masv
    lea di, masv2
    repe cmpsb
    je intb2          ; neu bang thi intb2
    inchuoi tb3
    inchuoi xdong       ; in tb3 ra man hinh
    jmp main         ; nhay den thoat
    
intb2:
    inchuoi tb2
    inchuoi tb4
    ;nhap so
    mov bx, 10
    nhap_so:
        mov ah, 01h
        int 21h
        cmp al, 13
        je nhiphan
        sub al, 30h
        mov ah, 0
        mov y, ax
        mov ax, x
        mul bx
        add ax, y
        mov x, ax
        inc si 
        jmp nhap_so
        
nhiphan:
    inchuoi tb5
    xor bx, bx
    mov bx, x
    mov cx, 16
    nhiphan1:
        mov dl, 30h
        shl bx, 1 ; day bit cao nhat cua bx vao co CF
        adc dl, 0
        mov ah, 2
        int 21h
        loop nhiphan1             
thapluc: 
    inchuoi tb6
    xor cx, cx
    mov ax, x
    chuyenhe16:
        xor dx, dx
        mov bl, 16
        div bx
        cmp dx, 9
        ja chucai
        add dx, 30h
        jmp chuso 
    chucai:
        add dx,37h ; chuyen snag chu cai
    chuso:
        push dx
        inc cx
        cmp ax, 0
        jne chuyenhe16
in_16:
    pop dx
    mov ah, 02h
    int 21h
    loop in_16
            
thoat:
    mov ah, 08h      ; dung man hinh xem kq
    int 21h    
    mov ah, 4Ch      ; thoat chuong trinh
    main endp
end main