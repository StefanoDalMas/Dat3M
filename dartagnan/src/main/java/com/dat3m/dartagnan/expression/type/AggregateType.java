package com.dat3m.dartagnan.expression.type;

import com.dat3m.dartagnan.expression.Type;

import java.util.List;
import java.util.stream.Collectors;
import java.util.stream.IntStream;

public class AggregateType implements Type {

    private final List<TypeOffset> directFields;

    AggregateType(List<Type> fields, List<Integer> offsets) {
        this.directFields = IntStream.range(0, fields.size()).boxed().map(i -> new TypeOffset(fields.get(i), offsets.get(i))).toList();
    }

    public List<TypeOffset> getTypeOffsets() {
        return directFields;
    }

    @Override
    public int hashCode() {
        return directFields.hashCode();
    }

    @Override
    public boolean equals(Object obj) {
        return this == obj || obj instanceof AggregateType o && directFields.equals(o.directFields);
    }

    @Override
    public String toString() {
        return directFields.stream().map(f -> f.offset() + ": " + f.type()).collect(Collectors.joining(", ", "{ ", " }"));
    }
}
