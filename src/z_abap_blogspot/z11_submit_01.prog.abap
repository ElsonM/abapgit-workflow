*&---------------------------------------------------------------------*
*& Report Z11_SUBMIT_01
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z11_submit_01 NO STANDARD PAGE HEADING.

PARAMETERS p_text TYPE char50.

SUBMIT z11_submit_02 WITH p_text1 EQ p_text.
