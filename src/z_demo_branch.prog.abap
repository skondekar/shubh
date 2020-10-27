*&---------------------------------------------------------------------*
*& Report Z_DEMO_BRANCH
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_DEMO_BRANCH.
data : val_add  type i.
data : val_mul  type i.


PARAMETERS p1 type N.
PARAMETERS p2 type N.

START-OF-SELECTION.
perform process_1 using p1 p2.
perform process_2 using p1 p2.
write :/ 'Test  Demo46'.
include Z_DEMo_BRANCH_INC1.
include Z_DEMo_BRANCH_INC2.
