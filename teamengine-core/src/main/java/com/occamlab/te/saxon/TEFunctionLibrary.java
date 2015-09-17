package com.occamlab.te.saxon;

import java.util.List;

import net.sf.saxon.Configuration;
import net.sf.saxon.expr.Container;
import net.sf.saxon.expr.Expression;
import net.sf.saxon.expr.StaticContext;
import net.sf.saxon.functions.FunctionLibrary;
import net.sf.saxon.om.StandardNames;
import net.sf.saxon.om.StructuredQName;
import net.sf.saxon.trans.SymbolicName;
import net.sf.saxon.trans.XPathException;

import com.occamlab.te.Test;
import com.occamlab.te.index.FunctionEntry;
import com.occamlab.te.index.Index;

public class TEFunctionLibrary implements FunctionLibrary {
    Configuration config = null;
    Index index = null;

    public TEFunctionLibrary(Configuration config, Index index) {
        this.config = config;
        this.index = index;
    }

    @Override
    public Expression bind(SymbolicName functionName, Expression[] staticArgs, StaticContext env, Container container)
            throws XPathException {
        StructuredQName qName = functionName.getComponentName();
        if (qName.getURI().equals(Test.TE_NS) && qName.getLocalPart().equals("get-type")) {
            return new GetTypeFunctionCall(qName, staticArgs, env);
        }
        String key = qName.getClarkName();
        List<FunctionEntry> functions = index.getFunctions(key);
        int argCount = staticArgs.length;
        Expression expr = null;
        if (functions != null) {
            for (FunctionEntry fe : functions) {
                if (argCount >= fe.getMinArgs() && argCount <= fe.getMaxArgs()) {
                    if (fe.isJava()) {
                        expr = new TEJavaFunctionCall(fe, qName, staticArgs, env);
                    } else {
                        expr = new TEXSLFunctionCall(fe, qName, staticArgs, env);
                    }
                }
            }
        }
        return expr;
    }

    @Override
    public boolean isAvailable(SymbolicName functionName) {
        StructuredQName qName = functionName.getComponentName();
        String key = qName.getClarkName();
        List<FunctionEntry> functions = index.getFunctions(key);
        int arity = functionName.getArity();
        if (functions != null) {
            for (FunctionEntry fe : functions) {
                if (arity == -1) {
                    return true;
                }
                if (arity >= fe.getMinArgs() && arity <= fe.getMaxArgs()) {
                    return true;
                }
            }
        }
        return false;
    }

    public Expression bind(StructuredQName functionQName, Expression[] staticArgs, StaticContext env)
            throws XPathException {
        return bind(new SymbolicName(StandardNames.XSL_FUNCTION, functionQName), staticArgs, env, null);
    }

    public boolean isAvailable(StructuredQName functionQName, int arity) {
        return isAvailable(new SymbolicName(StandardNames.XSL_FUNCTION, functionQName, arity));
    }

    public FunctionLibrary copy() {
        return new TEFunctionLibrary(config, index);
    }

}
