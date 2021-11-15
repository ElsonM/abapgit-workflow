*&---------------------------------------------------------------------*
*&      Module  VERBRAUCH_ANZEIGEN  OUTPUT
*&---------------------------------------------------------------------*
*       Anzeigen der Verbrauchswerte.
*----------------------------------------------------------------------*
MODULE VERBRAUCH_ANZEIGEN OUTPUT.
*wk/4.0 field selection here now due to tc
ENHANCEMENT-POINT VERBRAUCH_ANZEIGEN_01 SPOTS ES_LMGD1O0L STATIC INCLUDE BOUND.
  IF KZVERB = 'U'.
* AHE: 30.01.97 - A
    LOOP AT SCREEN.
*     if screen-group1 = '001'.  mk/4.0A
      IF SCREEN-GROUP1 = '001' OR SCREEN-GROUP2 = '001'.
*     Button für ungepl. Verbrauch deaktivieren
*       SCREEN-INPUT  = 0.    " schaltet auf "nur Ausgabe"
        SCREEN-OUTPUT = 1.             " schaltet auf "nur Ausgabe"
        SCREEN-ACTIVE = 0.             " schaltet auf "unsichtbar"
        MODIFY SCREEN.
      ENDIF.
    ENDLOOP.
* AHE: 30.01.97 - E
  ELSE.
* AHE: 30.01.97 - A
    LOOP AT SCREEN.
*     if screen-group1 = '002'.   mk/4.0A
      IF SCREEN-GROUP1 = '002' OR SCREEN-GROUP2 = '002'.
*     Button für Gesamtverbrauch deaktivieren
*       SCREEN-INPUT  = 0.    " schaltet auf "nur Ausgabe"
        SCREEN-OUTPUT = 1.             " schaltet auf "nur Ausgabe"
        SCREEN-ACTIVE = 0.             " schaltet auf "unsichtbar"
        MODIFY SCREEN.
      ENDIF.
    ENDLOOP.
* AHE: 30.01.97 - E
  ENDIF.

  IF SY-STEPL = 1.
    VW_ZLEPROSEITE = SY-LOOPC.
  ENDIF.

  VW_AKT_ZEILE = VW_ERSTE_ZEILE + SY-STEPL.
  IF KZVERB = 'U'.
    READ TABLE UNG_VERBTAB INDEX VW_AKT_ZEILE.
  ELSE.
    READ TABLE GES_VERBTAB INDEX VW_AKT_ZEILE.
  ENDIF.

ENHANCEMENT-POINT VERBRAUCH_ANZEIGEN_02 SPOTS ES_LMGD1O0L INCLUDE BOUND.
  IF SY-SUBRC NE 0.
    IF T130M-AKTYP = AKTYPA OR
       T130M-AKTYP = AKTYPZ.
      EXIT FROM STEP-LOOP.
    ELSE.
      CLEAR T009B_ERROR.
      NO_T009B_ABEND = X.
* AHE: 08.04.98 - A (4.0c) HW 100826
* vorgezogen
      RM03M-ANTEI = 1.                 " wegen Fließkommaarithmetik
* AHE: 08.04.98 - E
      PERFORM VERBRAUCH_ERWEITERN.
      CLEAR NO_T009B_ABEND.
      IF T009B_ERROR = X.
        EXIT FROM STEP-LOOP.
      ENDIF.
      IF KZVERB = 'U'.
        MOVE-CORRESPONDING UNG_VERBTAB TO RM03M.
        PERFORM DATUMSAUFBEREITUNG USING UNG_VERBTAB-ERTAG RM03M-PRIOD.
      ELSE.
        MOVE-CORRESPONDING GES_VERBTAB TO RM03M.
        PERFORM DATUMSAUFBEREITUNG USING GES_VERBTAB-ERTAG RM03M-PRIOD.
      ENDIF.
*     RM03M-ANTEI = 100.   " Wert aus altem Mat-Stamm heißt: 1.00
* AHE: 08.04.98 - A (4.0c) HW 100826
* nach oben gezogen
*     RM03M-ANTEI = 1.                 " wegen Fließkommaarithmetik
* AHE: 08.04.98 - E
    ENDIF.
  ELSE.
    IF KZVERB = 'U'.
      MOVE-CORRESPONDING UNG_VERBTAB TO RM03M.
      PERFORM DATUMSAUFBEREITUNG USING UNG_VERBTAB-ERTAG RM03M-PRIOD.
    ELSE.
      MOVE-CORRESPONDING GES_VERBTAB TO RM03M.
      PERFORM DATUMSAUFBEREITUNG USING GES_VERBTAB-ERTAG RM03M-PRIOD.
    ENDIF.
ENHANCEMENT-POINT VERBRAUCH_ANZEIGEN_03 SPOTS ES_LMGD1O0L INCLUDE BOUND.
    IF RM03M-VBWRT NE 0.
*--- Feldüberlauf abgefragt;
*     RECHFELD = RM03M-KOVBW * 100 / RM03M-VBWRT.  " raus wg. Fließkomm.
      RECHFELD = RM03M-KOVBW / RM03M-VBWRT.
* AHE: 25.10.96 - A
* Falls Betrag von RECHFELD größer als MAX_ANTEI bei negativem
* Wert für RECHFELD
      IF RECHFELD < 0.
        RECHFELD = ABS( RECHFELD ).
      ENDIF.
* AHE: 25.10.96 - E
      IF RECHFELD GT MAX_ANTEI.
        CLEAR RM03M-ANTEI.
      ELSE.
*       RM03M-ANTEI = RM03M-KOVBW * 100 / RM03M-VBWRT. "raus wg. Fließko
        RM03M-ANTEI = RM03M-KOVBW / RM03M-VBWRT.
      ENDIF.
    ELSE.
      IF RM03M-KOVBW = 0.
*       RM03M-ANTEI = 100.   " Wert aus altem Mat-Stamm heißt: 1.00
        RM03M-ANTEI = 1.
      ELSE.
        CLEAR RM03M-ANTEI.      "hier müßte Anteil unendlich sein !
      ENDIF.
    ENDIF.

* AHE: 08.04.98 - A (4.0c) HW 100826
    IF KZVERB = 'U'.
      MOVE RM03M-ANTEI TO UNG_VERBTAB-ANTEI.
      MODIFY UNG_VERBTAB INDEX VW_AKT_ZEILE.
    ELSE.
      MOVE RM03M-ANTEI TO GES_VERBTAB-ANTEI.
      MODIFY GES_VERBTAB INDEX VW_AKT_ZEILE.
    ENDIF.
* AHE: 08.04.98 - E

  ENDIF.

ENDMODULE.                             " VERBRAUCH_ANZEIGEN  OUTPUT
