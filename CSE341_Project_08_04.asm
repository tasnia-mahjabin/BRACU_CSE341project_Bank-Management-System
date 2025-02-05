.MODEL SMALL
 
.STACK 100H

.DATA
a db 100
b db 10
c dw ? 
d dw ?
e dw ?
accounts dw 123, 456, 789 
pins dw 111, 222, 333 

msg_enter_acc db "Enter Account Number: $"
msg_enter_pin db "Enter Pin: $"
msg_login_fail db "Invalid Account Number or Pin. Try Again.$"
msg_welcome db "Welcome to the Bank!$"

msg_menu db "1.View Balance 2.Deposit 3.Withdraw 4.Loan 5.Interest 6.Transaction History 7.Exit$"
msg_choice db "Enter your choice: $"
choice db ?

balance dw 1000 ; Initial balance
msg_balance db "Your Balance: $"
msg_deposit db "Enter Deposit Amount: $"
msg_withdraw db "Enter Withdrawal Amount: $"
msg_insufficient db "Insufficient Balance!$"
msg_success db "Transaction Successful!$"

msg_loan_amt db "Enter Loan Amount: $"
msg_loan_year db "Enter Duration (Years): $"
loan_grant db "Loan Granted$"
loan_fail db "Loan Not Granted$"
loan_repayment db "Loan Repayment Amount: $"
loan_amt dw 0
loan_year db 0
interest_amt dw 0
loan_interest dw 5 
total_repayment dw 0 
msg_interest_calc db " Tk Interest Added to Your Account.$"
deposit_transactions dw 100 dup(0)
withdraw_transactions dw 100 dup(0)
deposit_msg_transactions db "Deposit: $"
withdraw_msg_transactions db "Withdraw: $"
msg_nodeposit db "No Deposits Done!$"
msg_nowithdraw db "No Withdrawal Done!$"
.CODE
MAIN PROC

;iniitialize DS

MOV AX,@DATA
MOV DS,AX
 
; enter your code here\

;Feature 1

login_prompt:
    ;Prompt for Account Number
    mov ah,2
    mov dl,0dh
    int 21h
    mov dl,0ah
    int 21h
    lea dx, msg_enter_acc
    mov ah, 9
    int 21h
    
    mov ah,1
    int 21h
    mov bh, al
    mov ah,1     
    int 21h
    mov bl, al
    mov ah,1
    int 21h   
    mov ch, al    

  
    sub bh, 30h
    sub bl, 30h  
    sub ch, 30h      

    mov al, bh   
    mov cl, a  
    mul cl
        
        
    mov c,ax   


    mov al,bl    
    mov cl,b
    mul cl

    mov d,ax   


    mov dh,0
    mov dl,ch    

    mov e,dx      


    mov bx,c  
    mov ax,d  
    add bx,ax 
    mov ax,e  
    add bx,ax 

    
    mov ah,2
    mov dl,0dh
    int 21h
    mov dl,0ah
    int 21h
    ; Prompt for Pin
    lea dx, msg_enter_pin
    mov ah, 9
    int 21h
    mov ah,1
    int 21h
    mov bh, al
    mov ah,1     
    int 21h
    mov bl, al
    mov ah,1
    int 21h   
    mov ch, al    

  
    sub bh, 30h
    sub bl, 30h  
    sub ch, 30h      

    mov al, bh   
    mov cl, a  
    mul cl
        
        
    mov c,ax   


    mov al,bl    
    mov cl,b
    mul cl

    mov d,ax   


    mov dh,0
    mov dl,ch    

    mov e,dx      


    mov cx,c  
    mov ax,d  
    add cx,ax 
    mov ax,e  
    add cx,ax 
    

; Validate Account Number and Password
validate: 
    mov si,0
    mov ax,accounts[si]
    cmp ax,bx      
    
    mov si,0
    mov ax,pins[si]
    cmp ax,cx
   
    jne next_account
    je login_success
      

next_account:
    mov si,1
    mov ax,accounts[si]
    cmp ax,bx      
    
    mov si,1
    mov ax,pins[si]
    cmp ax,cx
   
    jne next_next_account
    je login_success
    
next_next_account:
    mov si,2
    mov ax,accounts[si]
    cmp ax,bx      
    
    mov si,2
    mov ax,pins[si]
    cmp ax,cx

    jne login_fail
    je login_success

login_success:
    mov ah,2
    mov dl,0dh
    int 21h
    mov dl,0ah
    int 21h
    lea dx, msg_welcome
    mov ah, 9
    int 21h
    jmp display_menu

login_fail:
    mov ah,2
    mov dl,0dh
    int 21h
    mov dl,0ah
    int 21h
    lea dx, msg_login_fail
    mov ah, 9
    int 21h
    jmp login_prompt
    

;Feature 2

display_menu:
    mov ah,2
    mov dl,0dh
    int 21h
    mov dl,0ah
    int 21h
    lea dx, msg_menu
    mov ah, 9
    int 21h
    
    mov ah,2
    mov dl,0dh
    int 21h
    mov dl,0ah
    int 21h
    lea dx, msg_choice
    mov ah, 9
    int 21h

    mov ah, 1
    int 21h
    sub al, '0' 
    mov choice, al
    jmp process_choice

process_choice:
    cmp choice, 1
    je view_balance
    cmp choice, 2
    je deposit_money
    cmp choice, 3
    je withdraw_money
    cmp choice, 4
    je loan_calculation
    cmp choice, 5
    je calculate_interest
    cmp choice, 6
    je view_transaction_history
    cmp choice, 7
    je exit_program
    jmp display_menu
    
    
;Feature 3
view_balance:
    mov ah,2
    mov dl,0dh
    int 21h
    mov dl,0ah
    int 21h
    lea dx, msg_balance
    mov ah, 9
    int 21h
    mov ax,balance
PrintNumber:
    push ax      
    push dx      

    mov cx, 0    

DivideLoop:
    mov dx, 0    
    mov bx, 10   
    div bx       

    push dx      
    inc cx       
    cmp ax, 0    
    jne DivideLoop 

PrintDigits:
    pop dx       
    add dl, '0'  
    mov ah, 2    
    int 21h     
    loop PrintDigits 

    pop dx       
    pop ax         

    jmp display_menu
    
deposit_money:
    mov ah,2
    mov dl,0dh
    int 21h
    mov dl,0ah
    int 21h
    lea dx, msg_deposit
    mov ah, 9
    int 21h
    
    mov ah,1
    int 21h
    mov bh, al
    mov ah,1     
    int 21h
    mov bl, al
    mov ah,1
    int 21h   
    mov ch, al    

  
    sub bh, 30h
    sub bl, 30h  
    sub ch, 30h      

    mov al, bh   
    mov cl, a  
    mul cl
        
        
    mov c,ax   


    mov al,bl    
    mov cl,b
    mul cl

    mov d,ax   


    mov dh,0
    mov dl,ch    

    mov e,dx      


    mov bx,c  
    mov ax,d  
    add bx,ax 
    mov ax,e  
    add bx,ax 
    
    add balance, bx
    mov deposit_transactions,bx
    
    mov ah,2
    mov dl,0dh
    int 21h
    mov dl,0ah
    int 21h
    lea dx, msg_success
    mov ah, 9
    int 21h
    jmp display_menu

withdraw_money:
    mov ah,2
    mov dl,0dh
    int 21h
    mov dl,0ah
    int 21h
    lea dx, msg_withdraw
    mov ah, 9
    int 21h
    mov ah,1
    int 21h
    mov bh, al
    mov ah,1     
    int 21h
    mov bl, al
    mov ah,1
    int 21h   
    mov ch, al    

  
    sub bh, 30h
    sub bl, 30h  
    sub ch, 30h      

    mov al, bh   
    mov cl, a  
    mul cl
        
        
    mov c,ax   


    mov al,bl    
    mov cl,b
    mul cl

    mov d,ax   


    mov dh,0
    mov dl,ch    

    mov e,dx      


    mov bx,c  
    mov ax,d  
    add bx,ax 
    mov ax,e  
    add bx,ax 
    cmp bx, balance
    ja insufficient_balance
    sub balance, bx
    mov withdraw_transactions,bx
    
    mov ah,2
    mov dl,0dh
    int 21h
    mov dl,0ah
    int 21h
    lea dx, msg_success
    mov ah, 9
    int 21h
    jmp display_menu

insufficient_balance:
    mov ah,2
    mov dl,0dh
    int 21h
    mov dl,0ah
    int 21h
    lea dx, msg_insufficient
    mov ah, 9
    int 21h
    jmp display_menu
    


;Feature 4

loan_calculation:
    mov ah,2
    mov dl,0dh
    int 21h
    mov dl,0ah
    int 21h
    lea dx, msg_loan_amt
    mov ah, 9
    int 21h
    
    mov ah,1
    int 21h
    mov bh, al
    mov ah,1     
    int 21h
    mov bl, al
    mov ah,1
    int 21h   
    mov ch, al    

  
    sub bh, 30h
    sub bl, 30h  
    sub ch, 30h      

    mov al, bh   
    mov cl, a  
    mul cl
        
        
    mov c,ax   


    mov al,bl    
    mov cl,b
    mul cl

    mov d,ax   


    mov dh,0
    mov dl,ch    

    mov e,dx      


    mov bx,c  
    mov ax,d  
    add bx,ax 
    mov ax,e  
    add bx,ax 
    
    mov loan_amt, bx

    mov ah,2
    mov dl,0dh
    int 21h
    mov dl,0ah
    int 21h
    lea dx, msg_loan_year
    mov ah, 9
    int 21h
    
    mov ah,1
    int 21h 
    sub al,30h
    mov loan_year, al

Loan_Status:
    cmp loan_amt,500
    jb Loan_Not_Granted
    
    mov ah,2
    mov dl,0dh
    int 21h
    mov dl,0ah
    int 21h
    lea dx, loan_grant
    mov ah, 9
    int 21h

    ;Calculate total repayment
    mov ax, loan_amt
    mul loan_interest
    div a
    mul loan_year
    add ax,loan_amt
    mov total_repayment, ax

    mov ah,2
    mov dl,0dh
    int 21h
    mov dl,0ah
    int 21h
    lea dx, loan_repayment
    mov ah, 9
    int 21h
    
    mov ax,total_repayment
PrintNumber1:
    push ax      
    push dx      

    mov cx, 0    

DivideLoop1:
    mov dx, 0    
    mov bx, 10   
    div bx       

    push dx      
    inc cx       
    cmp ax, 0    
    jne DivideLoop1 

PrintDigits1:
    pop dx       
    add dl, '0'  
    mov ah, 2    
    int 21h      
    loop PrintDigits1 ; 

    pop dx       
    pop ax       
    jmp display_menu

    
Loan_Not_Granted:
    mov ah,2
    mov dl,0dh
    int 21h
    mov dl,0ah
    int 21h
    lea dx, loan_fail
    mov ah, 9
    int 21h

      
    
    
;Feature 5

calculate_interest:
    cmp balance, 1000
    jb no_interest

    cmp balance, 5000
    jb low_interest
    cmp balance, 10000
    jb medium_interest

high_interest:
    mov ax, balance 
    mov bx,15
    mul bx ; 15% interest
    mov bx,100
    div bx
    add balance, ax
    add interest_amt, ax
    jmp interest_done

medium_interest:
    mov ax, balance
    mov bx,10
    mul bx ; 10% interest
    mov bx,100
    div bx
    add balance, ax
    add interest_amt, ax
    jmp interest_done

low_interest:
    mov ax, balance
    mov bx,5
    mul bx ; 5% interest
    mov bx,100
    div bx
    add balance, ax
    add interest_amt, ax

interest_done:
    mov ah,2
    mov dl,0dh
    int 21h
    mov dl,0ah
    int 21h
    
    mov ax,interest_amt
PrintNumber2:
    push ax      
    push dx      

    mov cx, 0    

DivideLoop2:
    mov dx, 0    
    mov bx, 10   
    div bx       

    push dx      
    inc cx       
    cmp ax, 0    
    jne DivideLoop2 

PrintDigits2:
    pop dx       
    add dl, '0'  
    mov ah, 2    
    int 21h      
    loop PrintDigits2 

    pop dx       
    pop ax        
    lea dx, msg_interest_calc
    mov ah, 9
    int 21h
    jmp display_menu

no_interest:
    mov ah,2
    mov dl,0dh
    int 21h
    mov dl,0ah
    int 21h
    lea dx, msg_insufficient
    mov ah, 9
    int 21h
    jmp display_menu
    
; Feature 6: 

view_transaction_history:
    ; Display Deposit Transactions
    mov ah, 2
    mov dl, 0dh
    int 21h
    mov dl, 0ah
    int 21h

    lea dx, deposit_msg_transactions
    mov ah, 9
    int 21h

    ; Print deposit transactions
    
print_deposit_transactions:    
    mov ax, deposit_transactions[si] 
    cmp ax, 0                
    je skip_deposit_transaction
    

    
    push ax                  
    mov cx, 0                

deposit_amount_divide_loop:
    mov dx, 0                
    mov bx, 10               
    div bx                   
    push dx                  
    inc cx                   
    cmp ax, 0                
    jne deposit_amount_divide_loop 

deposit_amount_print_digits:
    pop dx                  
    add dl, '0'              
    mov ah, 2                
    int 21h                  
    loop deposit_amount_print_digits 

    pop ax                   
    jmp check_withdraw_transactions
    
skip_deposit_transaction:
    mov ah,2
    mov dl,0dh
    int 21h
    mov dl,0ah
    int 21h
    lea dx, msg_nodeposit
    mov ah, 9
    int 21h


check_withdraw_transactions:
    ; Display Withdrawal Transactions
    mov ah, 2
    mov dl, 0dh
    int 21h
    mov dl, 0ah
    int 21h

    lea dx, withdraw_msg_transactions
    mov ah, 9
    int 21h

    ; Print withdrawal transactions                
print_withdraw_transactions:
    mov ax, withdraw_transactions[si] 
    cmp ax, 0                
    je skip_withdraw_transaction

    
    push ax                  
    mov cx, 0                

withdraw_amount_divide_loop:
    mov dx, 0                
    mov bx, 10               
    div bx                   
    push dx                  
    inc cx                   
    cmp ax, 0                
    jne withdraw_amount_divide_loop 

withdraw_amount_print_digits:
    pop dx                   
    add dl, '0'              
    mov ah, 2                
    int 21h                  
    loop withdraw_amount_print_digits 

    pop ax                   
    jmp display_menu
skip_withdraw_transaction:
    mov ah,2
    mov dl,0dh
    int 21h
    mov dl,0ah
    int 21h
    lea dx, msg_nowithdraw
    mov ah, 9
    int 21h
    jmp display_menu
   

end_transaction_display:
    jmp display_menu




exit_program:


 

;exit to DOS
               
MOV AX,4C00H
INT 21H

MAIN ENDP
    END MAIN





