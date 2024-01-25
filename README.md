Programmable Stopwatch/Timer

The stopwatch/timer uses the four 7-segment displays on the Basys 3 board to
display time. The two MSB digits display seconds. The two LSB digits 
are used to display time with the resolution of 10 milliseconds: in other words, these
digits should go through the sequence 0...99 in one second.
The design has four programmable modes:

Mode 1 (Counting Up from 00.00) – In this mode, the design acts as a
normal stopwatch. 1) It is initialized to 00.00, 2) It starts counting up after
the Start/Stop button is pressed, and counts to 99.99, where it stops if no
action is taken, 3) It stops counting when the Start/Stop is pressed again, 4)
It resumes counting if the Start/Stop is pressed again, 5) It resets to 00.00
if the Reset button is pressed.

Mode 2 (Counting Up from an Externally Loaded Value) – In this
mode, the design behaves the same way as in Mode 1 except that it allows
loading an initial value on to the stopwatch and counting up from that value.
Only the two most significant bits corresponding to “seconds” need to be
loaded. Eight switches on the Basys board are used to define the
initial value (four switches for the tens digit corresponding to “seconds” and
four switches for the ones digit corresponding to “seconds” – also, both the
digits can take values only from 0 to 9, i.e., 0000 to 1001 and the case when
these switches are set to values greater than 1001 can be ignored).

Mode 3 (Counting Down from 99.99) – In this mode, the design acts
as a timer counting from “99.99” to “00.00”. 1) It is initialized to 99.99, 2)
It starts counting down after the Start/Stop button is pressed, and counts to
00.00, where it stops if no action is taken, 3) It stops counting down when
the Start/Stop is pressed again, 4) It resumes counting if the Start/Stop is
pressed again, 5) It resets to 99.99 if the Reset button is pressed.

Mode 4 (Counting Down from an Externally Loaded Value) - In
this mode, the design behaves the same way as in Mode 3 except that it
allows loading an initial value on to the timer and counting down from that
value. Only the two most significant bits corresponding to “seconds” need to
be loaded. Eight switches on the Basys board should be used to define the
initial value (four switches for the tens digit corresponding to “seconds” and
four switches for the ones digit corresponding to “seconds” – also, both the
digits can take values only from 0 to 9, i.e., 0000 to 1001 and the case when
these switches are set to values greater than 1001 can be ignored).
