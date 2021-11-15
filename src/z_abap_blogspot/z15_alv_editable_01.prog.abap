*&---------------------------------------------------------------------*
*& Report Z15_ALV_EDITABLE_01
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z15_alv_editable_01.

TABLES scarr.

      "This will show the report title
DATA: wa_title  TYPE lvc_title VALUE 'Editable ALV Report',

      it_scarr  TYPE TABLE OF scarr,

      wa_fcat   TYPE slis_fieldcat_alv,
      it_fcat   TYPE slis_t_fieldcat_alv,

      wa_layout TYPE slis_layout_alv,

      wa_top    TYPE slis_listheader,
      it_top    TYPE slis_t_listheader.

INITIALIZATION.
  SELECT-OPTIONS s_carrid FOR scarr-carrid.

START-OF-SELECTION.
  PERFORM get_flight.       "Get data from database table
  PERFORM field_catalog.    "Creating the field catalog manually
  PERFORM layout.           "Creating the layout
  PERFORM alv_grid_display. "ALV grid output

TOP-OF-PAGE.
  PERFORM top_of_page.       "Top of page of editable ALV

*&---------------------------------------------------------------------*
*&      Form  get_flight
*&---------------------------------------------------------------------*
*       Get data from database table
*----------------------------------------------------------------------*
FORM get_flight.
  IF s_carrid[] IS NOT INITIAL.
    SELECT * FROM scarr INTO TABLE it_scarr
      WHERE carrid IN s_carrid.

    IF sy-subrc = 0.
      SORT it_scarr.
    ENDIF.
  ENDIF.
ENDFORM.                    " get_flight

*&---------------------------------------------------------------------*
*&      Form  field_catalog
*&---------------------------------------------------------------------*
*       Creating the field catalog manually
*----------------------------------------------------------------------*
FORM field_catalog.
  DATA lv_col TYPE i VALUE 0.

  IF it_scarr IS NOT INITIAL.
    lv_col            = 1 + lv_col.
    wa_fcat-col_pos   = lv_col.
    wa_fcat-fieldname = 'CARRID'.
    wa_fcat-tabname   = 'IT_SCARR'.
    wa_fcat-seltext_l = 'Airline Code'.
    APPEND wa_fcat TO it_fcat.
    CLEAR  wa_fcat.

    lv_col            = 1 + lv_col.
    wa_fcat-col_pos   = lv_col.
    wa_fcat-fieldname = 'CARRNAME'.
    wa_fcat-tabname   = 'IT_SCARR'.
    wa_fcat-seltext_l = 'Airline Name'.
    APPEND wa_fcat TO it_fcat.
    CLEAR  wa_fcat.

    lv_col            = 1 + lv_col.
    wa_fcat-col_pos   = lv_col.
    wa_fcat-fieldname = 'CURRCODE'.
    wa_fcat-tabname   = 'IT_SCARR'.
    wa_fcat-edit      = 'X'.               "Editable field
    wa_fcat-seltext_l = 'Local currency of airline'.
    APPEND wa_fcat TO it_fcat.
    CLEAR  wa_fcat.

    lv_col            = 1 + lv_col.
    wa_fcat-col_pos   = lv_col.
    wa_fcat-fieldname = 'URL'.
    wa_fcat-tabname   = 'IT_SCARR'.
    wa_fcat-edit      = 'X'.               "Editable field
    wa_fcat-seltext_l = 'Airline URL'.
    APPEND wa_fcat TO it_fcat.
    CLEAR  wa_fcat.
  ENDIF.
ENDFORM.                    " field_catalog

*&---------------------------------------------------------------------*
*&      Form  layout
*&---------------------------------------------------------------------*
*       Creating the layout
*----------------------------------------------------------------------*
FORM layout.
  wa_layout-colwidth_optimize = 'X'.
  wa_layout-zebra             = 'X'.
ENDFORM.                    " layout

*&---------------------------------------------------------------------*
*&      Form  alv_grid_display
*&---------------------------------------------------------------------*
*       ALV grid output
*----------------------------------------------------------------------*
FORM alv_grid_display.
  IF it_fcat IS NOT INITIAL.
    CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
      EXPORTING
        i_callback_program     = sy-repid
        i_callback_top_of_page = 'TOP_OF_PAGE'
        i_grid_title           = wa_title
        is_layout              = wa_layout
        it_fieldcat            = it_fcat
      TABLES
        t_outtab               = it_scarr
      EXCEPTIONS
        program_error          = 1
        OTHERS                 = 2.
  ENDIF.
ENDFORM.                    " alv_grid_display

*&---------------------------------------------------------------------*
*&      Form  top_of_page
*&---------------------------------------------------------------------*
*       Top of page of editable ALV
*----------------------------------------------------------------------*
FORM top_of_page.
  DATA date TYPE char10.

  CALL FUNCTION 'CONVERT_DATE_TO_EXTERNAL'
    EXPORTING
      date_internal            = sy-datum
    IMPORTING
      date_external            = date
    EXCEPTIONS
      date_internal_is_invalid = 1
      OTHERS                   = 2.

  REFRESH it_top.

  wa_top-typ  = 'H'.
  wa_top-info = 'Airline Information'.
  APPEND wa_top TO it_top.
  CLEAR  wa_top.

  wa_top-typ  = 'S'.
  wa_top-info = 'Date: '.
  CONCATENATE wa_top-info date INTO wa_top-info.
  APPEND wa_top TO it_top.
  CLEAR  wa_top.

  CALL FUNCTION 'REUSE_ALV_COMMENTARY_WRITE'
    EXPORTING
      it_list_commentary = it_top.
ENDFORM.                    "top_of_page
