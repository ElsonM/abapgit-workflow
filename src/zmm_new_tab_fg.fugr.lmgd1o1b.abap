*------------------------------------------------------------------
* INIT_SUB
*
*Es werden die zentralen Steuerungsdaten für die Bildbausteine geholt.
*------------------------------------------------------------------
MODULE init_sub OUTPUT.

*TF 4.0C================================================================
*  DATA: INIT_PROGN_FB  LIKE T133D-ROUTN VALUE 'INIT_'.
** INIT_PROGN_FB+5(4) = SY-REPID+4.          "//br40
*  INIT_PROGN_FB+5 = SY-REPID+4.             " Namensraumverlängerung
*  CALL FUNCTION INIT_PROGN_FB.
** CALL FUNCTION 'INIT_MGD1'.   "Aufruf jeweiliges Bildbausteinprogramm
*TF 4.0C================================================================

  PERFORM init_baustein.

ENDMODULE.                    "INIT_SUB OUTPUT
