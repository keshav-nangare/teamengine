package com.occamlab.te.saxon;

import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;

import net.sf.saxon.Controller;
import net.sf.saxon.expr.Expression;
import net.sf.saxon.expr.JPConverter;
//import net.sf.saxon.expr.ExpressionTool;
import net.sf.saxon.expr.StaticContext;
import net.sf.saxon.expr.XPathContext;
import net.sf.saxon.expr.parser.ExpressionTool;
//import net.sf.saxon.om.EmptyIterator;
import net.sf.saxon.om.Item;
import net.sf.saxon.om.Sequence;
import net.sf.saxon.om.SequenceIterator;
import net.sf.saxon.om.SequenceTool;
import net.sf.saxon.om.StructuredQName;
//import net.sf.saxon.om.ValueRepresentation;
import net.sf.saxon.trans.XPathException;
import net.sf.saxon.tree.iter.EmptyIterator;
import net.sf.saxon.value.ObjectValue;
//import net.sf.saxon.value.SequenceType;
//import net.sf.saxon.value.Value;

import com.occamlab.te.TEClassLoader;
import com.occamlab.te.TECore;
import com.occamlab.te.Test;
import com.occamlab.te.index.FunctionEntry;
import com.occamlab.te.util.Misc;

/**
 * Calls an extension function that is implemented by a Java method.
 */
public class TEJavaFunctionCall extends TEFunctionCall {
    FunctionEntry fe;
    Method[] methods = null;

    public TEJavaFunctionCall(FunctionEntry fe, StructuredQName functionName, Expression[] staticArgs,
            StaticContext env) throws XPathException {
        super(functionName, staticArgs, env);
        this.fe = fe;
    }

    public SequenceIterator iterate(XPathContext context) throws XPathException {
        Controller controller = context.getController();
        StructuredQName qName = StructuredQName.fromClarkName("{" + Test.TE_NS + "}core");
        @SuppressWarnings("unchecked")
        ObjectValue<TECore> objVal = (ObjectValue<TECore>) controller.getParameter(qName);
        TECore core = objVal.getObject();
        TEClassLoader cl = core.getEngine().getClassLoader(core.getOpts().getSourcesName());
        if (methods == null) {
            methods = new Method[fe.getMaxArgs() + 1];
            for (int i = fe.getMinArgs(); i <= fe.getMaxArgs(); i++) {
                try {
                    methods[i] = Misc.getMethod(fe.getClassName(), fe.getMethod(), cl, i);
                } catch (Exception e) {
                    throw new XPathException("Error: Unable to bind function " + fe.getName(), e);
                }
            }
        }
        Object instance = null;
        if (fe.isInitialized()) {
            instance = core.getFunctionInstance(fe.hashCode());
            if (instance == null) {
                try {
                    instance = Misc.makeInstance(fe.getClassName(), fe.getClassParams(), cl);
                    core.putFunctionInstance(fe.hashCode(), instance);
                } catch (Exception e) {
                    throw new XPathException(e);
                }
            }
        }
        Expression[] argExpressions = getArguments();
        Object[] javaArgs = new Object[argExpressions.length];
        Method m;
        //Class[] types;
        int argsIndex;
        if (fe.usesContext()) {
            m = methods[argExpressions.length + 1];
            //types = m.getParameterTypes();
            Item contextItem = context.getContextItem();
            javaArgs[0] = SequenceTool.convertToJava(contextItem);
            // REPLACED! javaArgs[0] = Value.asValue(contextItem).convertToJava(types[0], context);
            argsIndex = 1;
        } else {
            m = methods[argExpressions.length];
            //types = m.getParameterTypes();
            argsIndex = 0;
        }
        for (int i = 0; i < argExpressions.length; i++) {
            Item item = (Item) ExpressionTool.lazyEvaluate(argExpressions[i], context, 1);
            javaArgs[argsIndex] = SequenceTool.convertToJava(item);
            // REPLACED! javaArgs[argsIndex] = Value.asValue(item).convertToJava(types[argsIndex], context);
            argsIndex++;
        }
        Object result;
        try {
            result = m.invoke(instance, javaArgs);
        } catch (Exception e) {
            Throwable cause = e;
            if (e instanceof InvocationTargetException) {
                cause = e.getCause();
            }
            String msg = "Error invoking " + fe.getId() + "\n" + cause.getClass().getName();
            if (cause.getMessage() != null) {
                msg += ": " + cause.getMessage();
            }
            throw new XPathException(msg, cause);
        }
        if (result == null) {
            return EmptyIterator.getInstance();
        } else {
            // Value v = Value.convertJavaObjectToXPath(result, SequenceType.ANY_SEQUENCE, context);
            JPConverter converter = JPConverter.allocate(result.getClass(), null, context.getConfiguration());
            Sequence seq = converter.convert(result, context);
            return seq.iterate();
        }
    }
}
