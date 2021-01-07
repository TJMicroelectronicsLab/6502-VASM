PORTB = $6000
PORTA = $6001
DDRB = $6002
DDRA = $6003

E  = %10000000
RW = %01000000
RS = %00100000

  .org $8000





reset:
  ldx #$ff
  txs
  
  lda #%11111111 ; Set all pins on port B to output
  sta DDRB

  lda #%11100000 ; Set top 3 pins on port A to output
  sta DDRA

  lda #%00111000 ; Set 8-bit mode; 2-line display; 5x8 font
  jsr enable

  lda #%00001110 ; Display on; cursor on; blink off
  jsr enable

  lda #%00000110 ; Increment and shift cursor; don't shift display
  jsr enable

  lda #"H"
  jsr datawrite

  lda #"e"
  jsr datawrite

  lda #"l"
  jsr datawrite

  lda #"l"
  jsr datawrite

  lda #"o"
  jsr datawrite

  lda #","
  jsr datawrite

  lda #" "
  jsr datawrite

  lda #"w"
  jsr datawrite

  lda #"o"
  jsr datawrite

  lda #"r"
  jsr datawrite

  lda #"l"
  jsr datawrite

  lda #"d"
  jsr datawrite

  lda #"!"
  jsr datawrite

loop:
  jmp loop

enable: ; call pha and pla to push/pull from stack if a reg value is important
  
  sta PORTB
  lda #0         ; Clear RS/RW/E bits
  sta PORTA
  lda #E         ; Set E bit to send instruction
  sta PORTA
  lda #0         ; Clear RS/RW/E bits
  sta PORTA
  rts 

datawrite:
  sta PORTB
  lda #RS         ; Set RS; Clear RW/E bits
  sta PORTA
  lda #(RS | E)   ; Set E bit to send instruction
  sta PORTA
  lda #RS         ; Clear E bits
  sta PORTA
  rts

  .org $fffc
  .word reset
  .word $0000