PORTB = $6000
PORTA = $6001
DDRB = $6002
DDRA = $6003

E  = %10000000
RW = %01000000
RS = %00100000

  .org $8000

enable:
  lda #0         ; Clear RS/RW/E bits
  sta PORTA
  lda #E         ; Set E bit to send instruction
  sta PORTA
  lda #0         ; Clear RS/RW/E bits
  sta PORTA

datawrite:
  lda #RS         ; Set RS; Clear RW/E bits
  sta PORTA
  lda #(RS | E)   ; Set E bit to send instruction
  sta PORTA
  lda #RS         ; Clear E bits
  sta PORTA

reset:
  lda #%11111111 ; Set all pins on port B to output
  sta DDRB

  lda #%11100000 ; Set top 3 pins on port A to output
  sta DDRA

  lda #%00111000 ; Set 8-bit mode; 2-line display; 5x8 font
  sta PORTB
  .word enable

  lda #%00001110 ; Display on; cursor on; blink off
  sta PORTB
  .word enable

  lda #%00000110 ; Increment and shift cursor; don't shift display
  sta PORTB
  .word enable

  lda #"H"
  sta PORTB
  .word datawrite

  lda #"e"
  sta PORTB
  .word datawrite

  lda #"l"
  sta PORTB
  .word datawrite

  lda #"l"
  sta PORTB
  .word datawrite

  lda #"o"
  sta PORTB
  .word datawrite

  lda #","
  sta PORTB
  .word datawrite

  lda #" "
  sta PORTB
  .word datawrite

  lda #"w"
  sta PORTB
  .word datawrite

  lda #"o"
  sta PORTB
  .word datawrite

  lda #"r"
  sta PORTB
  .word datawrite

  lda #"l"
  sta PORTB
  .word datawrite

  lda #"d"
  sta PORTB
  .word datawrite

  lda #"!"
  sta PORTB
  .word datawrite

loop:
  jmp loop

  .org $fffc
  .word reset
  .word $0000