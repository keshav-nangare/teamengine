package com.occamlab.te.saxon;

import java.util.logging.Logger;

import net.sf.saxon.expr.Expression;
import net.sf.saxon.expr.FunctionCall;
import net.sf.saxon.expr.StaticContext;
import net.sf.saxon.expr.StaticProperty;
import net.sf.saxon.expr.parser.ExpressionVisitor;
import net.sf.saxon.om.StructuredQName;
import net.sf.saxon.trans.XPathException;
import net.sf.saxon.type.AnyItemType;
import net.sf.saxon.type.ItemType;
//import net.sf.saxon.type.TypeHierarchy;

/**
 * Represents a call to a user-defined function.
 */
public class TEFunctionCall extends FunctionCall {

    protected final Logger logger = Logger.getLogger(this.getClass().getPackage().getName());

    public TEFunctionCall(StructuredQName functionName, Expression[] staticArgs, StaticContext env) {
        super();
        this.setFunctionName(functionName);
        this.setArguments(staticArgs);
    }

    @Override
    protected void checkArguments(ExpressionVisitor visitor) throws XPathException {
    }

    @Override
    public ItemType getItemType() {
        return AnyItemType.getInstance();
    }

    public Expression preEvaluate(ExpressionVisitor visitor) {
        return this;
    }

    public int getImplementationMethod() {
        return ITERATE_METHOD;
    }

    protected int computeCardinality() {
        return StaticProperty.ALLOWS_ZERO_OR_MORE;
    }

    public Expression copy() {
        throw new UnsupportedOperationException();
    }
    /*
     * public ItemType getItemType(TypeHierarchy th) { return
     * AnyItemType.getInstance(); }
     */
}
