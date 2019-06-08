package com.monotonic.collections.visualiser;

import java.lang.reflect.Field;

public class Type
{
    private final Class<?> cls;

    public Type(final String name)
    {
        try
        {
            cls = Class.forName(name);
        }
        catch (ClassNotFoundException e)
        {
            throw new IllegalStateException(e);
        }
    }

    public Type(final Class<?> cls)
    {
        this.cls = cls;
    }

    public Field getField(final String fieldName)
    {
        try
        {
            final Field field = cls.getDeclaredField(fieldName);
            field.setAccessible(true);
            return field;
        }
        catch (NoSuchFieldException e)
        {
            throw new IllegalStateException(e);
        }
    }

    public static Object get(final Field field, final Object object)
    {
        try
        {
            return field.get(object);
        }
        catch (IllegalAccessException e)
        {
            throw new IllegalStateException(e);
        }
    }
}
