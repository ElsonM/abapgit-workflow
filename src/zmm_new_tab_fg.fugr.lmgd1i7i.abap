*&---------------------------------------------------------------------*
*&      Module  SET_DATEN_SUB  INPUT
*&---------------------------------------------------------------------*
* Zurückgeben der Daten des Bildbausteins an die U-WA´s                *
* Gehören die Bildbausteine des Bildes zu einem einheitlichen Programm,
* so werden die Daten erst beim letzten Bildbaustein an die U-WA´s
* übergeben, sonst immer.
*----------------------------------------------------------------------*
MODULE SET_DATEN_SUB INPUT.

  IF ANZ_SUBSCREENS IS INITIAL.
    PERFORM ZUSATZDATEN_SET_SUB.
    PERFORM MATABELLEN_SET_SUB.
  ELSEIF NOT KZ_EIN_PROGRAMM IS INITIAL.
    IF SUB_ZAEHLER EQ ANZ_SUBSCREENS.
      PERFORM ZUSATZDATEN_SET_SUB.
      PERFORM MATABELLEN_SET_SUB.
    ENDIF.
  ELSE.
    PERFORM ZUSATZDATEN_SET_SUB.
    PERFORM MATABELLEN_SET_SUB.
  ENDIF.
  IF T130M-AKTYP = AKTYPH.
    PERFORM ZUSATZDATEN_SET_SUB.
  ENDIF.

ENDMODULE.                             " SET_DATEN_SUB  INPUT
