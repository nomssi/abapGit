CLASS ltcl_user_master_record DEFINITION DEFERRED.

CLASS zcl_abapgit_user_master_record DEFINITION LOCAL FRIENDS ltcl_user_master_record.

CLASS ltcl_user_master_record DEFINITION FINAL FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    CONSTANTS gc_wrong_user TYPE sy-uname VALUE 'WRONG_USER'.
    METHODS:
      test_valid_user FOR TESTING RAISING cx_static_check,
      test_invalid_user FOR TESTING RAISING cx_static_check.
ENDCLASS.


CLASS ltcl_user_master_record IMPLEMENTATION.

  METHOD test_valid_user.
    DATA: lo_user_master_record TYPE REF TO zcl_abapgit_user_master_record.

    zcl_abapgit_user_master_record=>reset( ).
    lo_user_master_record = zcl_abapgit_user_master_record=>get_instance( sy-uname ).

    cl_abap_unit_assert=>assert_equals(
      exp = 1
      act = lines( zcl_abapgit_user_master_record=>gt_user )
      msg = |User { sy-uname } is missing in the list| ).
  ENDMETHOD.

  METHOD test_invalid_user.
    DATA: lo_user_master_record TYPE REF TO zcl_abapgit_user_master_record.

    zcl_abapgit_user_master_record=>reset( ).
    lo_user_master_record = zcl_abapgit_user_master_record=>get_instance( gc_wrong_user ).

    cl_abap_unit_assert=>assert_equals(
      exp = 0
      act = lines( zcl_abapgit_user_master_record=>gt_user )
      msg = |User { gc_wrong_user } is missing in the list| ).
  ENDMETHOD.

ENDCLASS.
