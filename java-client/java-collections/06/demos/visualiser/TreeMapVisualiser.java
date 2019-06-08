package com.monotonic.collections.visualiser;

import java.lang.reflect.Field;
import java.util.TreeMap;

import static com.monotonic.collections.visualiser.Type.get;

public class TreeMapVisualiser
{
    private static final boolean BLACK = true;
    private static final boolean RED = false;

    private static final Field rootField;
    private static final Field colorField;
    private static final Field leftField;
    private static final Field rightField;

    static
    {
        Type entry = new Type("java.util.TreeMap$Entry");
        Type treeMap = new Type(TreeMap.class);

        rootField = treeMap.getField("root");
        leftField = entry.getField("left");
        rightField = entry.getField("right");
        colorField = entry.getField("color");
    }

    private final Console console;

    public TreeMapVisualiser(final Console console)
    {
        this.console = console;
    }

    public void visualise(final TreeMap<?, ?> map)
    {
        console.printf("Size: %d, %n", map.size());

        Object root = get(rootField, map);

        visualiseSubTree(root, 0);
    }

    private int visualiseSubTree(final Object node, int index)
    {
        console.indent(index);
        final boolean colour = (boolean) get(colorField, node);
        if (colour == RED)
        {
            console.red();
        }

        console.println(node);
        console.resetColour();

        return 1
             + visualiseBranch(node, index, leftField)
             + visualiseBranch(node, index, rightField);
    }

    private int visualiseBranch(final Object node, final int index, final Field field)
    {
        Object branch = get(field, node);
        if (branch != null)
        {
            return visualiseSubTree(branch, index + 1);
        }
        return 0;
    }
}
