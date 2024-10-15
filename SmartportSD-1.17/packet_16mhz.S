//*****************************************************************************
//
// Apple //c Smartport Compact Flash adapter
// Written by Robert Justice  email: rjustice(at)internode.on.net
// 
// Assembler routines for sending and receiving the smartport packets
// These are timing sensitive and assume a clk frequency of 16Mhz
// 
//*****************************************************************************

// required for register definitions
#include <avr/io.h>        

 
//*****************************************************************************
// Function: ReceivePacket
// Parameters: packet_buffer pointer
// Returns: status (not used yet, always returns 0)
//
// Description: This handles the ACK and REQ lines and reads a packet into the 
// packet_buffer
// 
//*****************************************************************************
.global ReceivePacket

ReceivePacket:
          mov  XL,r24                 ;mov buffer pointer into X 
          mov  XH,r25

          sbi  _SFR_IO_ADDR(PORTC),5  ;set ACK high to signal we are ready to send
          ;ldi  r24,'A'                ;for debug, A indicates ACK is high
          ;call uart_putc              ;output to serial port
          
          clr  r21                    ;setup timeout counter
          ldi  r20,10                 ;two stage timer, around 1ms

1:        sbic _SFR_IO_ADDR(PIND),2   ;1/2 wait for req line to go high
          rjmp start                  ;this indicates host is about to send packet   
          dec  r21                    ;1 
          brne 1b                     ;1/2
          dec  r20
          brne 1b
          rjmp timeout                ;yes, we have timed out

start:    ;ldi  r24,'R'                ;for debug, R indicates REQ is high
          ;call uart_putc              ;output to serial port

          ldi  r22,1                                                 ;1   remember tx line status when previously sampled
          sbis _SFR_IO_ADDR(PIND),7                                  ;1/2 wait for txd line to go low
          rjmp 2f                                                    ;2   txd cleared, start of packet data
          rjmp start                                                 ;2
                                                                 ;
                                                                     ;    wait for half a bit, 2us (28 cycles total) --> 32 cycles for 64Mhz
                                                                     ;    this is so we sample mid point  --> I think this is ok for 16Mhz                    
2:        ldi  r24,10                                        ;1   |delay total of 30 cycles
3:        dec  r24                                                   ;1   | each loop +3 final loop +2
          brne 3b                                                    ;1/2 | 1 + 9x3 + 1x2 = 30
                                                                     
nxtbyte:                                                             ;    full cycle time for each byte is 32us
          ldi  r25,8                                                 ;1   8bits to read
                                                               
nxtbit:   sbic _SFR_IO_ADDR(PIND),7           ;2   ;2    ;1  ;1      ;1/2 now read a bit, cycle time is 4us
          rjmp bitset                                    ;3  ;3      ;2   bit is set
          rjmp bitclr                         ;4   ;4                ;2   bit is clr
                                                                     
bitset:   sbrc r22,0                                     ;4  ;5      ;1/2 test previous bit recv'd
          rjmp carryclr                                  ;6          ;2   bit set, then we have a zero
          ldi  r22,1                                         ;6      ;1   remember prev tx bit is set
          sec                                                ;7      ;1   else we have a one
          nop                                                ;8      ;1
          nop                                                ;9      ;1
          rjmp loadbit                                       ;11     ;2
                                                                     
bitclr:   sbrc r22,0                          ;5   ;6                ;1/2 test previous bit recv'd
          rjmp carryset                       ;7                     ;2   bit set, then we have a one
          ldi  r22,0                               ;7                ;1   remember prev tx bit is clr
          clc                                      ;8                ;1   else we have a zero
          nop                                      ;9                ;1
          rjmp loadbit                             ;11               ;2
                                                                     
carryset: ldi  r22,0                          ;8                     ;1
          sec                                 ;9                     ;1   remember prev tx bit is clr
          rjmp loadbit                        ;11                    ;2
                                                                     
carryclr: ldi  r22,1                                    ;7           ;1   remember prev tx bit is set
          clc                                           ;8           ;1
          nop                                           ;9           ;1
          nop                                           ;10          ;1
          nop                                           ;11          ;1
                                                                     
loadbit:  rol  r23                            ;12  ;12  ;12  ;12     ;1   shift bit(carry) into r23
          dec  r25                            ;13  ;13  ;13  ;13     ;1   dec bit counter
          breq havebyte                       ;14  ;14  ;14  ;14     ;1/2 
                                                                     ;    delay to make up the rest of the 4us --> 64 cycles for 16Mhz (8 more)
                                     ;                                            2 more loops +2 nops      
                                   
          ldi  r24,15                                                ;1   |delay total of 45 cycles
3:        dec  r24                                                   ;1   | each loop +3 final loop +2
          brne 3b                                                    ;1/2 | 1 + 14x3 + 1x2 = 45
                                              ;59  ;59  ;59  ;59     
          nop                                 ;60  ;60  ;60  ;60     ;1
          nop                                 ;61  ;61  ;61  ;61     ;1
          nop                                 ;62  ;62  ;62  ;62     ;1
          rjmp nxtbit                         ;64  ;64  ;64  ;64     ;2   get next bit. --> 64 cycles = 4us for 16Mhz
                                             ;--------------------------------------
havebyte:                                                            
          st   x+,r23                         ;17                    ;2   save byte in buffer
          ldi  r25,100 ;era 100!!!!!!!!!                        ;18                    ;1   timeout counter if we are at the end
          cpi  r22,1                          ;19                    ;1   check for status of last bit    
          breq wasset                         ;20  ;21               ;1/2
                                                                     
wasclr:   sbic _SFR_IO_ADDR(PIND),7           ;21                    ;1/2 now read a bit, wait for transition to 1         
          rjmp havesbit                       ;23                    ;2   now set, lets get the next byte
          dec  r25                                                   ;1
          breq endpkt                                                ;1/2 we have timed out, must be end of packet
          rjmp wasclr                                                ;2   lets test again
                                                                     
wasset:   sbis _SFR_IO_ADDR(PIND),7                ;22               ;1/2 now read a bit, wait for transition to 0         
          rjmp havesbit                            ;24               ;2   now clr, lets get the next byte
          dec  r25                                                   ;1
          breq endpkt                                                ;1/2 we have timed out, must be end of packet
          rjmp wasset                                                ;2   lets test again
                                                                     
havesbit:                                                            ;    wait for half a bit, 2us (28 cycles total) --> 32 cycles for 16MHz
                                                                     ;    this is so we sample mid point --> again, i think this was long before, so try as is
          ldi  r24,7                                                 ;1   |delay total of 21 cycles
3:        dec  r24                                                   ;1   | each loop +3 final loop +2
          brne 3b                                                    ;1/2 | 1 + 6x3 + 1x2 = 21
                                              ;44  ;45             
          rjmp nxtbyte                        ;46  ;47               ;2   get next byte

endpkt:   clr  r23     
          st   x+,r23               ;save zero byte in buffer to mark end
          
          cbi  _SFR_IO_ADDR(PORTC),5  ;set ACK(BSY) low to signal we have recv'd the pkt
          ;ldi  r24,'a'                ;for debug, a indicates ACK is low
          ;call uart_putc              ;output to serial port

1:        sbis _SFR_IO_ADDR(PIND),2   ;wait for REQ line to go low
          rjmp finish                 ;this indicates host has acknowledged ACK   
          rjmp 1b
       
finish:   ;ldi  r24,'r'                ;for debug, r indicates REQ is low
          ;call uart_putc              ;output to serial port
          clr  r25                    ;return no error (for now)
          clr  r24
          ret
          
timeout:  cbi  _SFR_IO_ADDR(PORTC),5  ;set ACK(BSY) back to low
          ldi  r24,1                  ;setup return value, 1=error
          clr  r25
          ret
          
//*****************************************************************************
// Function: SendPacket
// Parameters: packet_buffer pointer
// Returns: status (not used yet, always returns 0)
//
// Description: This handles the ACK and REQ lines and sends the packet from the 
// pointer passed to it. (packet_buffer)
// 
//*****************************************************************************
.global SendPacket
 
SendPacket:
          mov  XL,r24                 ;mov buffer pointer into X 
          mov  XH,r25

          sbi  _SFR_IO_ADDR(PORTC),5  ;set ACK high to signal we are ready to send
          ;ldi  r24,'A'               ;for debug, A indicates ACK is high
          ;call uart_putc             ;output to serial port

1:        sbic _SFR_IO_ADDR(PIND),2   ;wait for req line to go high
          rjmp contin                 ;this indicates host is ready to receive packet   
          ;ldi  r24,'r'               ;for debug, r indicates REQ is low
          ;call uart_putc             ;output to serial port
          rjmp 1b

contin:   ;ldi  r24,'R'               ;for debug, R indicates REQ is high
          ;call uart_putc             ;output to serial port
;
;                                     ;Totals for loops             ;
;                           
nxtsbyte: ld   r23,x+                 ;59               ;43         ;2   get first byte from buffer
          cpi  r23,0                  ;60               ;44         ;1   zero marks end of data
          breq endspkt                ;61               ;45         ;1/2
                                                                    
          ldi  r25,8                  ;62               ;46         ;1   8bits to read
                                                    ;Clr  ;Set
nxtsbit:  sbrs r23,7                  ;64(Set) ;64      ;47   ;48   ;1/2 send bit 7 first  
                                      ;63(Clr)                       
          rjmp sbitclr                ;64+1             ;48+1       ;2   bit is clear
          sbi  _SFR_IO_ADDR(PORTD),6                          ;2    ;2   set bit for 1us (14 cycles)-->16 cycles for 16Mhz(2 more)
                                                                
          ldi  r24,4                                                ;1   |delay total of 12 cycles
3:        dec  r24                                                  ;1   | each loop +3 final loop +2
          brne 3b                                                   ;1/2 | 1 + 3x3 + 1x2 = 11
                                                              ;14                     
          nop                                                 ;15   ;1
          nop                                             ;16   ;1 
                                                                    
          cbi  _SFR_IO_ADDR(PORTD),6                          ;2    ;2   clr bit for 3us (42 cycles)-->48 cycles for 16Mhz(6 more)
                                                                    ;                                            2 more loops
          dec  r25                                            ;3    ;1   dec bit counter
          breq nxtsbyt1                                       ;4    ;1/2
          rol  r23                                            ;5    ;1
                                                                    
          ldi  r24,13                                               ;1   |delay total of 39 cycles
3:        dec  r24                                                  ;1   |  each loop +3 final loop +2
          brne 3b                                                   ;1/2 |  1 + 12x3 + 1x2 = 39
                                                              ;44
                                            
          rjmp nxtsbit                                        ;46   ;2
                                            
nxtsbyt1:                                               ;5          ;    delay to makeup 3us (42 cycles total)-->48 cycles for 16Mhz(6 more)
                                                                    ;                                            2 more loops
          ldi  r24,11                                               ;1   |delay total of 33 cycles
3:        dec  r24                                                  ;1   | each loop +3 final loop +2
          brne 3b                                                   ;1/2 | 1 + 10x3 + 1x2 = 33
                                                    ;38  
          nop                                           ;39         ;1
                                                             
          rjmp nxtsbyte                                 ;41         ;2

; bit is clr, we need to check if its the last one, otherwise delay for 4us before next bit
sbitclr:  dec  r25                             ;2                   ;1   
          breq nxtsbycl               ;4       ;3                   ;1/2 end of byte, delay then get nxt
          rol  r23                             ;4                   ;1
                                                                    ;    delay to makeup 4us (56 cycles total)-->64 cycles for 16Mhz(8 more)
                                  ;                                            2 more loops +2 nops      
          ldi  r24,18                                               ;1   |delay total of 54 cycles
3:        dec  r24                                                  ;1   | each loop +3 final loop +2
          brne 3b                                                   ;1/2 | 1 + 17x3 + 1x2 = 54
                                               ;58
          nop                                  ;59                  ;1
          nop                                  ;60                ;1
          rjmp nxtsbit                         ;62                  ;2
                                                  
nxtsbycl:                                                           ;    delay to makeup 4us (56 cycles total)-->64 cycles for 16Mhz(8 more)
                                  ;                                            2 more loops +2 nops      
                                                                    ;
          ldi  r24,16                                               ;1   |delay total of 48 cycles
3:        dec  r24                                                  ;1   | each loop +3 final loop +2
          brne 3b                                                   ;1/2 | 1 + 15x3 + 1x2 = 48
                                      ;52         
          nop                         ;53                           ;1
          nop                         ;54                           ;1
          nop                         ;55                           ;1      
                                                  
          rjmp nxtsbyte               ;57                           ;2


endspkt:  cbi  _SFR_IO_ADDR(PORTC),5  ;set ACK(BSY) low to signal we have sent the pkt
          ;ldi  r24,'a'                ;for debug, a indicates ACK is low
          ;call uart_putc              ;output to serial port
          
1:        ldi  r24,5
          sbis _SFR_IO_ADDR(PIND),2   ;wait for REQ line to go low
          rjmp finishs                ;this indicates host has acknowledged ACK   
          dec  r24
          brne 1b
          rjmp error
   
finishs:  ;ldi  r24,'r'                ;for debug, r indicates REQ is low
          ;call uart_putc              ;output to serial port
          clr  r25
          clr  r24                    ;return no error
          ret

error:    clr  r25
          ldi  r24,1
          ret


        

