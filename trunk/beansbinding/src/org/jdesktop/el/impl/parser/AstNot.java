/*
 * Copyright (C) 2007 Sun Microsystems, Inc. All rights reserved. Use is
 * subject to license terms.
 *
 *//* Generated By:JJTree: Do not edit this line. AstNot.java */

package org.jdesktop.el.impl.parser;

import org.jdesktop.el.ELContext;
import org.jdesktop.el.ELException;

import org.jdesktop.el.impl.lang.EvaluationContext;

/**
 * @author Jacob Hookom [jacob@hookom.net]
 * @version $Change: 181177 $$DateTime: 2001/06/26 08:45:09 $$Author: kchung $
 */
public final class AstNot extends SimpleNode {
    public AstNot(int id) {
        super(id);
    }

    public Class getType(EvaluationContext ctx)
            throws ELException {
        return Boolean.class;
    }

    public Object getValue(EvaluationContext ctx)
            throws ELException {
        Object obj = this.children[0].getValue(ctx);
        if (obj == ELContext.UNRESOLVABLE_RESULT) {
            return ELContext.UNRESOLVABLE_RESULT;
        }
        Boolean b = coerceToBoolean(obj);
        return Boolean.valueOf(!b.booleanValue());
    }
}
