package com.occamlab.te.saxon;

import static com.occamlab.te.saxon.GetTypeFunctionCall.getTypeName;

//import java.io.CharArrayReader;
import java.io.StringReader;
import java.util.List;
import java.util.logging.Level;

import javax.xml.namespace.QName;
import javax.xml.transform.Source;
import javax.xml.transform.stream.StreamSource;

import net.sf.saxon.Controller;
import net.sf.saxon.expr.Expression;
import net.sf.saxon.expr.StaticContext;
import net.sf.saxon.expr.XPathContext;
import net.sf.saxon.expr.parser.ExpressionTool;
import net.sf.saxon.om.AxisInfo;
import net.sf.saxon.om.Item;
//import net.sf.saxon.om.Axis;
//import net.sf.saxon.om.EmptyIterator;
import net.sf.saxon.om.NodeInfo;
import net.sf.saxon.om.Sequence;
import net.sf.saxon.om.SequenceIterator;
import net.sf.saxon.om.SequenceTool;
import net.sf.saxon.om.StructuredQName;
//import net.sf.saxon.om.ValueRepresentation;
import net.sf.saxon.trans.XPathException;
import net.sf.saxon.tree.iter.EmptyIterator;
import net.sf.saxon.type.ItemType;
import net.sf.saxon.type.SchemaType;
import net.sf.saxon.value.ObjectValue;
//import net.sf.saxon.value.Value;

import org.w3c.dom.Attr;
import org.w3c.dom.Node;

import com.occamlab.te.TECore;
import com.occamlab.te.Test;
import com.occamlab.te.index.FunctionEntry;
import com.occamlab.te.util.DomUtils;

public class TEXSLFunctionCall extends TEFunctionCall {
    FunctionEntry fe;

    public TEXSLFunctionCall(FunctionEntry fe, StructuredQName functionName, Expression[] staticArgs,
            StaticContext env) {
        super(functionName, staticArgs, env);
        this.fe = fe;
    }

    public static String getType(Expression expr, XPathContext context) throws XPathException {
        // ValueRepresentation vr = ExpressionTool.lazyEvaluate(expr, context,
        // 1);
        Sequence seq = ExpressionTool.lazyEvaluate(expr, context, 1);
        // ItemType it = Value.asValue(vr).getItemType(
        // context.getConfiguration().getTypeHierarchy());
        ItemType itemType = SequenceTool.getItemType(seq, context.getConfiguration().getTypeHierarchy());
        if (itemType instanceof SchemaType) {
            return "xs:" + ((SchemaType) itemType).getName();
        }
        return "xs:any";
    }

    public SequenceIterator iterate(XPathContext context) throws XPathException {
        Controller controller = context.getController();
        StructuredQName qName = StructuredQName.fromClarkName("{" + Test.TE_NS + "}core");
        @SuppressWarnings("unchecked")
        ObjectValue<TECore> objVal = (ObjectValue<TECore>) controller.getParameter(qName);
        TECore core = objVal.getObject();
        Expression[] argExpressions = getArguments();
        StringBuilder xmlStr = new StringBuilder("<params>\n");
        List<QName> params = fe.getParams();
        for (int i = 0; i < params.size(); i++) {
            QName param = params.get(i);
            xmlStr.append("<param");
            xmlStr.append(" local-name=\"").append(param.getLocalPart()).append("\"");
            xmlStr.append(" namespace-uri=\"").append(param.getNamespaceURI()).append("\"");
            xmlStr.append(" prefix=\"").append(param.getPrefix()).append("\"");
            Sequence seq = ExpressionTool.eagerEvaluate(argExpressions[i], context);
            Item item = SequenceTool.asItem(seq);
            // Value v = Value.asValue(vr);
            try {
                // Node n = (Node) v.convertToJava(Node.class, context);
                Node n = (Node) SequenceTool.convertToJava(item);
                int type = n.getNodeType();
                if (type == Node.ATTRIBUTE_NODE) {
                    xmlStr.append(">\n");
                    Attr attr = (Attr) n;
                    xmlStr.append("<value ").append(attr.getNodeName()).append("=\"");
                    xmlStr.append(attr.getValue().replace("&", "&amp;")).append("\"");

                    if (attr.getPrefix() != null) {
                        xmlStr.append(" xmlns:").append(attr.getPrefix()).append("=\"").append(attr.getNamespaceURI())
                                .append("\"");
                    }
                    xmlStr.append("/>\n");
                } else if (type == Node.ELEMENT_NODE) {
                    xmlStr.append(" type=\"node()\">\n").append("<value>");
                    xmlStr.append(DomUtils.serializeNode(n));
                    xmlStr.append("</value>\n");
                } else if (type == Node.DOCUMENT_NODE) {
                    xmlStr.append(" type=\"document-node()\">\n").append("<value>");
                    xmlStr.append(DomUtils.serializeNode(n));
                    xmlStr.append("</value>\n");
                } else {
                    // ItemType it =
                    // v.getItemType(context.getConfiguration().getTypeHierarchy());
                    ItemType it = SequenceTool.getItemType(seq, context.getConfiguration().getTypeHierarchy());
                    xmlStr.append(" type=\"").append(getTypeName(it)).append("\">\n");
                    xmlStr.append("<value>").append(n.getNodeValue()).append("</value>\n");
                }
            } catch (Exception e) {
                // ItemType it =
                // v.getItemType(context.getConfiguration().getTypeHierarchy());
                ItemType it = SequenceTool.getItemType(seq, context.getConfiguration().getTypeHierarchy());
                xmlStr.append(" type=\"").append(getTypeName(it)).append("\">\n");
                xmlStr.append("<value>").append(item.getStringValue()).append("</value>\n");
            }
            xmlStr.append("</param>\n");
        }
        xmlStr.append("</params>");
        this.logger.log(Level.FINE, xmlStr.toString());
        Source src = new StreamSource(new StringReader(xmlStr.toString()));
        NodeInfo result = null;
        try {
            NodeInfo paramsNode = core.getEngine().getBuilder().build(src).getUnderlyingNode();
            result = core.executeXSLFunction(context, fe, paramsNode);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        if (result == null) {
            return EmptyIterator.getInstance();
        } else {
            return result.iterateAxis(AxisInfo.CHILD);
        }
    }
}
