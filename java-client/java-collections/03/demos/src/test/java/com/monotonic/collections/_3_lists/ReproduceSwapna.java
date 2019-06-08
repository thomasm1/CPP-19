package com.monotonic.collections._3_lists;

import com.monotonic.collections.Product;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Iterator;
import java.util.List;

import static com.monotonic.collections._3_lists.ProductFixtures.floorPanel;
import static com.monotonic.collections._3_lists.ProductFixtures.door;
import static com.monotonic.collections._3_lists.ProductFixtures.window;

public class ReproduceSwapna
{
    public static void main(String[] args)
    {
        List<String> numbers = new ArrayList<>();
        numbers.add("1");
        numbers.add("3");
        numbers.add("2");

        System.err.println("Removing numbers using for loop");
        for (String number : numbers)
        {
            System.err.println("number = " + number);
            if (number.equals("2")) {
                numbers.remove(number);
            }
        }

        System.err.println(numbers);
    }
}
