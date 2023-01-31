package com.rdstation;

import java.util.*;

public class CustomerSuccessBalancing {

    private final List<CustomerSuccess> customerSuccess;
    private final List<Customer> customers;
    private final List<Integer> customerSuccessAway;

    public CustomerSuccessBalancing(List<CustomerSuccess> customerSuccess,
                                    List<Customer> customers,
                                    List<Integer> customerSuccessAway) {
        this.customerSuccess = customerSuccess;
        this.customers = customers;
        this.customerSuccessAway = customerSuccessAway;
    }


    public int run() {
        return 0;
    }
}
