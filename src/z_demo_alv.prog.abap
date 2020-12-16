*&---------------------------------------------------------------------*
*& Report Z_DEM_ALV
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_demo_alv.

TABLES: vbak.

TYPES:
  BEGIN OF ty_vbak,
    vbeln TYPE vbeln_va,
*****         erdat TYPE erdat,
*****         auart TYPE auart,
    netwr TYPE netwr,
  END OF ty_vbak.

DATA:
      gr_table TYPE REF TO CL_sALV_TABLE.

SELECT-OPTIONS  s_vbeln FOR vbak-vbeln.
*****SELECT-OPTIONS  s_erdat FOR vbak-erdat.
*****SELECT-OPTIONS  s_auart FOR vbak-auart.

TYPES  : BEGIN OF g_type_s,
           repid TYPE syrepid,
         END OF g_type_s.

DATA:
  gv_list_display TYPE sap_bool,
  gs_globals      TYPE g_type_s,
  gv_header       TYPE string,
  gr_functions    TYPE REF TO cl_salv_functions_list,
  it_vbak         TYPE TABLE OF ty_VBAK,
  wa_vbak         TYPE ty_vbak.

START-OF-SELECTION.
  PERFORM get_data.
  PERFORM crt_cat USING gr_table it_vbak.
  PERFORM chg_cat USING gr_table.

END-of-SELECTION.
  PERFORM display_output.

FORM get_data.

  gs_globals-repid = sy-repid.

  SELECT vbeln
*  ****       erdat
*  ****       auart
       netwr
  FROM vbak INTO TABLE it_vbak
    WHERE vbeln IN s_vbeln
*  ****     AND erdat IN s_erdat
*  ****     AND auart IN s_auart
    .
ENDFORM.

FORM display_output.
  gr_table->display( ).
ENDFORM.

FORM user_header  USING    p_gv_header.
  DATA : datum(10) TYPE c.

  p_gv_header = 'Text-TH0'.

ENDFORM.                    " USER_HEADER

FORM crt_cat  USING    p_gr_table TYPE REF TO cl_salv_table
                       p_it_vbak.

  DATA: ir_title_grid TYPE REF TO cl_salv_form_layout_grid.

  TRY.
      cl_salv_table=>factory(
      EXPORTING
        list_display = gv_list_display
      IMPORTING
         r_salv_table = p_gr_table
       CHANGING
         t_table = p_it_vbak
            ).
    CATCH cx_salv_msg.
  ENDTRY.

  gr_functions = gr_table->get_functions( ).
  gr_table->set_screen_status(
  pfstatus = 'STANDARD'
  report  = gs_globals-repid
  set_functions = gr_table->c_functions_all ).

  CREATE OBJECT ir_title_grid.

  ir_title_grid->set_grid_lines(
           value  = if_salv_form_C_grid_lines=>no_lines
           ).

  PERFORM user_header USING gv_header.
  PERFORM set_header USING gr_table gv_header.
  PERFORM set_ttl USING gr_table .
ENDFORM.                    " CRT_CAT

FORM set_ttl  USING    p_gr_table TYPE REF TO cl_salv_table.
  DATA: ir_title_grid TYPE REF TO cl_salv_form_layout_grid.

  CREATE OBJECT ir_title_grid.

  p_gr_table->set_top_of_list( value = ir_title_grid ).

  PERFORM user_top_of_list USING ir_title_grid.

ENDFORM.                    " SET_TTL

FORM set_header  USING    p_gr_table TYPE REF TO cl_salv_table
                          p_gv_header.
  DATA:
    lr_display TYPE REF TO cl_salv_display_settings,
    lv_header  TYPE lvc_title.

  lr_display = p_gr_table->get_display_settings( ).

  IF NOT p_gv_header IS INITIAL.
    MOVE gv_header TO lv_header.

    lr_display->set_list_header_size( value = 0 ).
    lr_display->set_list_header( value =  lv_header  ).
  ENDIF.
ENDFORM.                    " SET_HEADER

FORM user_top_of_list  USING    p_ir_title_grid
                       TYPE REF TO cl_salv_form_layout_grid.
  DATA:
    zeile       TYPE i,
    spalte      TYPE i,
    zloop       TYPE i,
    wert(50)    TYPE c,
    wertvon(10) TYPE c,
    werbis(10)  TYPE c.

  ADD 1 TO zeile.
  ADD 1 TO spalte.

  p_ir_title_grid->create_header_information(
  row = zeile
  column = spalte
  text = 'Sales Order Details').

  p_ir_title_grid->set_grid_lines(
  value  = if_salv_form_c_grid_Lines=>no_lines
  ).
ENDFORM.                    " USER_TOP_OF_LIST

FORM chg_cat  USING    p_gr_table TYPE REF TO cl_salv_table.
  DATA:
    lr_columns    TYPE REF TO cl_salv_columns_table,
    lr_column     TYPE REF TO cl_salv_column_table,
    lr_display    TYPE REF TO cl_salv_display_settings,
    lr_selections TYPE REF TO cl_salv_selections,
    lt_rows       TYPE salv_t_row,
    lt_column     TYPE salv_t_column,
    ls_cell       TYPE salv_t_cell.

  lr_columns  = p_gr_table->get_columns( ).
  lr_display  = p_gr_table->get_display_settings( ).
ENDFORM.                    " CHG_CAT
