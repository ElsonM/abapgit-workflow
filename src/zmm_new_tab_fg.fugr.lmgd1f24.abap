*&---------------------------------------------------------------------*
*&      Form  Zusdaten_Get_Bild
*&---------------------------------------------------------------------*
* //br141195(30C) BILDFLAG ergänzt
*----------------------------------------------------------------------*
FORM ZUSATZDATEN_GET_SUB.

  CALL FUNCTION 'MAIN_PARAMETER_GET_ZUS_SUB'
       IMPORTING
            WRMMZU      = RMMZU
            WRMMG2      = RMMG2
            RMMG1_SPRAS = RMMG1-SPRAS
            BILDFLAG    = BILDFLAG
            WRMMG1      = RMMG1        "mk/1.2A1
            WRLTEX      = RLTEX
       TABLES
            REFTAB      = REFTAB.      "cfo/4.5B

* note 623656
  PERFORM ZUSATZDATEN_GET_RLTEX.

ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  ZUSATZDATEN_GET_RLTEX
*&---------------------------------------------------------------------*
form ZUSATZDATEN_GET_RLTEX .

  LANGTEXTBILD = RLTEX-LANGTEXTBILD.
  LANGTXTVKORG = RLTEX-LANGTXTVKORG.
  LANGTXTVTWEG = RLTEX-LANGTXTVTWEG.
  LANGTEXT_MATNR_BEST = RLTEX-LANGTEXT_MATNR_BEST.
  LANGTEXT_MATNR_GRUN = RLTEX-LANGTEXT_MATNR_GRUN.
  LANGTEXT_MATNR_IVER = RLTEX-LANGTEXT_MATNR_IVER.
  LANGTEXT_MATNR_PRUE = RLTEX-LANGTEXT_MATNR_PRUE.
  LANGTEXT_MATNR_VERT = RLTEX-LANGTEXT_MATNR_VERT.
  KZ_BEST_PROZ = RLTEX-KZ_BEST_PROZ.
  KZ_GRUN_PROZ = RLTEX-KZ_GRUN_PROZ.
  KZ_IVER_PROZ = RLTEX-KZ_IVER_PROZ.
  KZ_PRUE_PROZ = RLTEX-KZ_PRUE_PROZ.
  KZ_VERT_PROZ = RLTEX-KZ_VERT_PROZ.
  longtextcontainer = RLTEX-longtextcontainer.
  refresh_textedit_control = RLTEX-refresh_textedit_control.
  desc_langu_gdtxt = RLTEX-desc_langu_gdtxt.
  desc_langu_prtxt = RLTEX-desc_langu_prtxt.
  desc_langu_iverm = RLTEX-desc_langu_iverm.
  desc_langu_bestell = RLTEX-desc_langu_bestell.
  desc_langu_vertriebs = RLTEX-desc_langu_vertriebs.
  editor_obj_gd = RLTEX-editor_obj_gd.
  editor_obj_pr = RLTEX-editor_obj_pr.
  editor_obj_iv = RLTEX-editor_obj_iv.
  editor_obj_be = RLTEX-editor_obj_be.
  editor_obj_ve = RLTEX-editor_obj_ve.
  textedit_custom_container_gd = RLTEX-textedit_custom_container_gd.
  textedit_custom_container_pr = RLTEX-textedit_custom_container_pr.
  textedit_custom_container_iv = RLTEX-textedit_custom_container_iv.
  textedit_custom_container_be = RLTEX-textedit_custom_container_be.
  textedit_custom_container_ve = RLTEX-textedit_custom_container_ve.
  rm03m_spras_grundd = RLTEX-rm03m_spras_grundd.
  rm03m_spras_pruef = RLTEX-rm03m_spras_pruef.
  rm03m_spras_vertriebs = RLTEX-rm03m_spras_vertriebs.
  rm03m_spras_bestell = RLTEX-rm03m_spras_bestell.
  rm03m_spras_iverm = RLTEX-rm03m_spras_iverm.

endform.                    " ZUSATZDATEN_GET_RLTEX
