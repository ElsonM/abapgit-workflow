*---------------------------------------------------------------------*
*       FORM MLAN_SET_SUB                                             *
*---------------------------------------------------------------------*
*       ........                                                      *
*---------------------------------------------------------------------*
FORM MLAN_SET_SUB.

  CALL FUNCTION 'MLAN_SET_SUB'
       TABLES
            WSTEUERTAB = STEUERTAB
            WSTEUMMTAB = STEUMMTAB.

ENDFORM.
