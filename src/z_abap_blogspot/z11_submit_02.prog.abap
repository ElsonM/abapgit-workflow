*&---------------------------------------------------------------------*
*& Report Z11_SUBMIT_02
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z11_submit_02 NO STANDARD PAGE HEADING.

PARAMETER p_text1 TYPE char40.

DO 5 TIMES.
  WRITE: / p_text1.
ENDDO.
