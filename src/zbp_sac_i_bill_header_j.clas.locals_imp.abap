CLASS lhc_ZSAC_I_BILL_HEADER_j DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      keys REQUEST requested_authorizations FOR ZSAC_I_BILL_HEADER_j RESULT result.
    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      REQUEST requested_authorizations FOR zsac_i_bill_header_j RESULT result.
    METHODS precheck_create FOR PRECHECK
      IMPORTING entities FOR CREATE zsac_i_bill_header_j.

    METHODS validateamount FOR VALIDATE ON SAVE
     IMPORTING keys FOR zsac_i_bill_header_j~validateamount.

ENDCLASS.

CLASS lhc_ZSAC_I_BILL_HEADER_j IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD get_global_authorizations.
  ENDMETHOD.

  METHOD precheck_create.
    LOOP AT entities INTO DATA(ls_entity).

      IF ls_entity-CustomerId IS NOT INITIAL.

        SELECT SINGLE * FROM /DMO/I_Customer
            WHERE CustomerID = @ls_entity-CustomerId
            INTO @DATA(ls_customer).
        IF sy-subrc NE 0.
          APPEND VALUE #( %key = ls_entity-%key ) TO failed-zsac_i_bill_header_j.
          APPEND VALUE #( %key = ls_entity-%key
                        %element-CustomerId = if_abap_behv=>mk-on
                        %msg = new_message_with_text( severity = if_abap_behv_message=>severity-error
                                                      text = 'Customer does not exists' )
                       ) TO reported-zsac_i_bill_header_j.
        ENDIF.

      ENDIF.

    ENDLOOP.
  ENDMETHOD.

  METHOD validateAmount.

    READ ENTITIES OF ZSAC_I_BILL_HEADER_j  IN LOCAL MODE
        ENTITY ZSAC_I_BILL_HEADER_j
        FIELDS ( NetAmount ) WITH CORRESPONDING #( keys )
        RESULT DATA(lt_billdoc).

    LOOP AT lt_billdoc INTO DATA(ls_billdoc).
      IF ls_billdoc-NetAmount IS NOT INITIAL AND ls_billdoc-NetAmount < 1000.
        APPEND VALUE #( %tky = ls_billdoc-%tky ) TO failed-zsac_i_bill_header_j.
        APPEND VALUE #( %tky = ls_billdoc-%tky
                        %element-NetAmount = if_abap_behv=>mk-on
                        %msg = new_message_with_text( severity = if_abap_behv_message=>severity-error
                                                      text = 'Net Amount cannot be less than 1000' )
                       ) TO reported-zsac_i_bill_header_j.
      ENDIF.
    ENDLOOP.

  ENDMETHOD.

ENDCLASS.
