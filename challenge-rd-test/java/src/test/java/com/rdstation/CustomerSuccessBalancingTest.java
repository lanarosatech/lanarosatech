package com.rdstation;

import org.junit.Test;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;
import java.util.stream.Collectors;
import java.util.stream.IntStream;

import static org.junit.Assert.assertEquals;

public class CustomerSuccessBalancingTest {


    @Test
    public void scenario1() {
        List<CustomerSuccess> css = toList(new CustomerSuccess(1, 60),
                                           new CustomerSuccess(2, 20),
                                           new CustomerSuccess(3, 95),
                                           new CustomerSuccess(4, 75)
        );
        List<Customer> customers = toList(new Customer(1, 90),
                                                 new Customer(2, 20),
                                                 new Customer(3, 70),
                                                 new Customer(4, 40),
                                                 new Customer(5, 60),
                                                 new Customer(6, 10));

        List<Integer> csAway = toList(2, 4);

        assertEquals(new CustomerSuccessBalancing(css, customers, csAway).run(), 1);
    }

    @Test
    public void scenario2() {
        List<CustomerSuccess> css = mapCustomerSuccess(11, 21, 31, 3, 4, 5);
        List<Customer> customers = mapCustomers(10, 10, 10, 20, 20, 30, 30, 30, 20, 60);
        List<Integer> csAway = Collections.emptyList();

        assertEquals(new CustomerSuccessBalancing(css, customers, csAway).run(), 0);
    }

    @Test(timeout=100)
    public void scenario3() {

        List<CustomerSuccess> css = mapCustomerSuccess(IntStream.range(1, 999).toArray());
        List<Customer> customers =  buildSizeEntities(100000, 998);
        List<Integer> csAway = toList(999);

        assertEquals(new CustomerSuccessBalancing(css, customers, csAway).run(), 998);
    }

    @Test
    public void scenario4() {
        List<CustomerSuccess> css = mapCustomerSuccess(1, 2, 3, 4, 5, 6);
        List<Customer> customers = mapCustomers(10, 10, 10, 20, 20, 30, 30, 30, 20, 60);
        List<Integer> csAway = Collections.emptyList();

        assertEquals(new CustomerSuccessBalancing(css, customers, csAway).run(), 0);
    }

    @Test
    public void scenario5() {
        List<CustomerSuccess> css = mapCustomerSuccess(100, 2, 3, 6, 4, 5);
        List<Customer> customers = mapCustomers(10, 10, 10, 20, 20, 30, 30, 30, 20, 60);
        List<Integer> csAway = Collections.emptyList();

        assertEquals(new CustomerSuccessBalancing(css, customers, csAway).run(), 1);
    }

    @Test
    public void scenario6() {
        List<CustomerSuccess> css = mapCustomerSuccess(100, 99, 88, 3, 4, 5);
        List<Customer> customers = mapCustomers(10, 10, 10, 20, 20, 30, 30, 30, 20, 60);
        List<Integer> csAway = toList(1, 3, 2);

        assertEquals(new CustomerSuccessBalancing(css, customers, csAway).run(), 0);
    }

    @Test
    public void scenario7() {
        List<CustomerSuccess> css = mapCustomerSuccess(100, 99, 88, 3, 4, 5);
        List<Customer> customers = mapCustomers(10, 10, 10, 20, 20, 30, 30, 30, 20, 60);
        List<Integer> csAway = toList(4,5,6);

        assertEquals(new CustomerSuccessBalancing(css, customers, csAway).run(), 3);
    }

    private List<CustomerSuccess> mapCustomerSuccess(int... scores) {
        List<CustomerSuccess> entities = new ArrayList<>(scores.length);
        for (int i = 0; i < scores.length; i++) {
            entities.add(new CustomerSuccess(i + 1, scores[i]));
        }
        return entities;
    }

    private List<Customer> mapCustomers(int... scores) {
        List<Customer> entities = new ArrayList<>(scores.length);
        for (int i = 0; i < scores.length; i++) {
            entities.add(new Customer(i + 1, scores[i]));
        }
        return entities;
    }

    private List<Customer> buildSizeEntities(int size, int score) {
        List<Customer> entities = new ArrayList<>(size);
        for (int i = 0; i < size; i++) {
            entities.add(new Customer(i + 1, score));
        }
        return entities;
    }


    private <T> List<T> toList(T... values) {
        return Arrays.stream(values).collect(Collectors.toList());
    }


}
