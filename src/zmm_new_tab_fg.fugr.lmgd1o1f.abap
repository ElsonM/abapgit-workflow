*&---------------------------------------------------------------------*
*&      Module  BILDSTATUS  OUTPUT
*&---------------------------------------------------------------------*
* Ermitteln Pflegestatus und PTAB zum Bild(baustein) für das Vorlage-
* handling/Handling Bezeichnungen gemäß dem AKTVSTATUS.
* Außerdem wird überprüft, daß die Pflegestatus aller Felder auf
* dem kompletten Bild zum Bildstatus gemäß T133A passen.
*----------------------------------------------------------------------*
MODULE BILDSTATUS OUTPUT.

  CALL FUNCTION 'SCREEN_IDENTIFY_ACT_PSTAT'
       EXPORTING
            FLG_REFRESH   = KZ_BILDBEGINN
            PSTAA         = T133S-PSTAA
            AKTVSTATUS    = AKTVSTATUS
            BILDSTATUS    = T133A-PSTAT
       IMPORTING
            AKT_PSTAT     = SUB_STATUS
            KZ_STATUS_ABW = KZ_STATUS_ABW
            FNAME_ABW     = FNAME_ABW
       TABLES
            FAUSWTAB      = FAUSWTAB
            MPTAB         = PTAB
            AKT_PTAB      = SUB_PTAB.

  IF NOT KZ_STATUS_ABW IS INITIAL.
* Bild enthält Feld, dessen Status nicht im Bildstatus vorkommt
* Customizing muß angepaßt werden
    MESSAGE A826(M3) WITH FNAME_ABW T133A-PSTAT.

  ENDIF.

ENDMODULE.                             " BILDSTATUS  OUTPUT
