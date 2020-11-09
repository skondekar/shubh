*&---------------------------------------------------------------------*
*& Report Z_DEM_ALV
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_DEMO_ALV.
*-----
TABLES : VBAK.
types  : begin of ty_vbak,
         vbeln type VBELN_VA,
         erdat type erdat,
         netwr type netwr,
         end of ty_vbak.
DATA : GR_TABLE TYPE REF TO CL_sALV_TABLE.
SELECT-OPTIONS  S_ERDAT FOR VBAK-ERDAT.
SELECT-OPTIONS  S_VBELN For VBAK-VBELN.

Types  : begin of g_type_s,
         repid type syrepid,
         end of g_type_s.
***
data : gv_list_display type sap_bool,
       gs_globals type g_type_s.
data : gv_header type string.
data : gr_functions type ref to cl_salv_functions_list.
data : it_vbak TYPE TABLE OF ty_VBAK,
       WA_VBAK TYPE TY_VBAK.

gs_globals-repid = sy-repid.
SELECT VBELN ERDAT
       NETWR
  FROM VBAK INTO TABLE IT_VBAK
      WHERE ERDAT IN S_ERDAT.

  perform crt_cat using gr_table it_vbak.
  perform chg_cat using gr_table.

gr_table->display( ).
*&---------------------------------------------------------------------*
*&      Form  USER_HEADER
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*      -->P_GV_HEADER  text
*----------------------------------------------------------------------*
FORM USER_HEADER  USING    P_GV_HEADER.
  data : datum(10) type C.

  p_gv_header = 'Text-TH0'.

ENDFORM.                    " USER_HEADER
*&---------------------------------------------------------------------*
*&      Form  CRT_CAT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*      -->P_GR_TABLE  text
*      -->P_IT_VBAK  text
*----------------------------------------------------------------------*
FORM CRT_CAT  USING    P_GR_TABLE type REF TO cl_salv_table
                       P_IT_VBAK.
  TRY.
  CL_SALV_TABLE=>FACTORY(
  EXPORTING
    list_display = gv_list_display
  IMPORTING
     r_salv_table = p_gr_table
   CHANGING
     t_table = p_it_vbak
        ).
  catch cx_salv_msg.
ENDTRY.

gr_functions = gr_table->get_functions( ).
gr_table->set_screen_status(
pfstatus = 'STANDARD'
report  = gs_globals-repid
set_functions = gr_table->c_functions_all ).
data : ir_title_grid type REF TO cl_salv_form_layout_grid.
create OBJECT ir_title_grid.
ir_title_grid->set_grid_lines(
         value  = if_salv_form_C_grid_lines=>no_lines
         ).
perform user_header using gv_header.
perform set_header using gr_table gv_header.
perform set_ttl using gr_table .

ENDFORM.                    " CRT_CAT
*&---------------------------------------------------------------------*
*&      Form  SET_TTL
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*      -->P_GR_TABLE  text
*----------------------------------------------------------------------*
FORM SET_TTL  USING    P_GR_TABLE type ref to cl_salv_table.
data : ir_title_grid type ref to cl_salv_form_layout_grid.
create object ir_title_grid.
p_gr_table->set_top_of_list( value = ir_title_grid ).
perform user_top_of_list using ir_title_grid.

ENDFORM.                    " SET_TTL
*&---------------------------------------------------------------------*
*&      Form  SET_HEADER
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*      -->P_GR_TABLE  text
*      -->P_GV_HEADER  text
*----------------------------------------------------------------------*
FORM SET_HEADER  USING    P_GR_TABLE type ref to cl_salv_table
                          P_GV_HEADER.
  data:  lr_display type ref to cl_salv_display_settings,
        lv_header type lvc_title.
  lr_display = p_gr_table->get_display_settings( ).
  if not p_gv_header is initial.
    move gv_header to lv_header.
    lr_display->set_list_header_size( value = 0 ).
    lr_display->set_list_header( value =  lv_header  ).
  endif.
ENDFORM.                    " SET_HEADER
*&---------------------------------------------------------------------*
*&      Form  USER_TOP_OF_LIST
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*      -->P_IR_TITLE_GRID  text
*----------------------------------------------------------------------*
FORM USER_TOP_OF_LIST  USING    P_IR_TITLE_GRID
                       type REF TO cl_salv_form_layout_grid.
  data : zeile type i,
        spalte type i,
        zloop type i,
        wert(50) type c,
        wertvon(10) type c,
        werbis(10) type c.
  add 1 to zeile.
  add 1 to spalte.
  p_ir_title_grid->create_header_information(
  row = zeile
  column = spalte
  text = 'texts header').
p_ir_title_grid->set_grid_lines(
value  = if_salv_form_c_grid_Lines=>no_lines
).
ENDFORM.                    " USER_TOP_OF_LIST
*&---------------------------------------------------------------------*
*&      Form  CHG_CAT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*      -->P_GR_TABLE  text
*----------------------------------------------------------------------*
FORM CHG_CAT  USING    P_GR_TABLE type REF TO cl_salv_table.

data : lr_columns    type REF TO cl_salv_columns_table,
       lr_column     type REF TO cl_salv_column_table,
       lr_display    type REF TO cl_salv_display_settings,
       lr_selections TYPE REF TO cl_salv_selections,
       lt_rows       TYPE  salv_t_row,
       lt_column     Type  salv_t_column,
       ls_cell       TYPE  salv_t_cell.

  lr_columns  = p_gr_table->get_columns( ).
  lr_display  = p_gr_table->get_display_settings( ).


ENDFORM.                    " CHG_CAT
