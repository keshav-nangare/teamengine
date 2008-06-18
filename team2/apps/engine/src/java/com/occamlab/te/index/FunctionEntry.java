package com.occamlab.te.index;

import java.io.File;
import java.lang.reflect.Method;
import java.net.URI;
import java.net.URISyntaxException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.xml.namespace.QName;

import net.sf.saxon.s9api.XdmItem;

import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

public class FunctionEntry extends IndexEntry implements TemplateEntry {
    boolean java;
    boolean initialized;
    boolean usesContext;
    String className;
    String method;
    int minArgs;
    int maxArgs;
    List<QName> params = null;
    List<Node> classParams = null;
    File templateFile;

    FunctionEntry() {
        super();
    }

    FunctionEntry(Element function) {
        super(function);
        try {
            String type = function.getAttribute("type");
            if (type.equals("xsl")) {
                setJava(false);
                setTemplateFile(new File(new URI(function.getAttribute("file"))));
            } else if (type.equals("java")) {
                setJava(true);
            } else {
                throw new RuntimeException("Invalid function type");
            }
            NodeList nl = function.getElementsByTagName("param");
            minArgs = nl.getLength();
            maxArgs = minArgs;
            if (minArgs > 0) {
                params = new ArrayList<QName>();
                for (int i = 0; i < minArgs; i++) {
                    Element el = (Element)nl.item(i);
                    String prefix = el.getAttribute("prefix");
                    String namespaceUri = el.getAttribute("namespace-uri");
                    String localName = el.getAttribute("local-name");
                    params.add(new QName(namespaceUri, localName, prefix));
                }
            }
            nl = function.getElementsByTagName("var-params");
            if (nl.getLength() > 0) {
                Element varParams = (Element)nl.item(0);
                String min = varParams.getAttribute("min");
                if (min != null) {
                    minArgs += Integer.parseInt(min);
                }
                String max = varParams.getAttribute("max");
                if (max != null) {
                    maxArgs += Integer.parseInt(max);
                }
            }
            setUsesContext(Boolean.parseBoolean(function.getAttribute("uses-context")));
            if (usesContext()) {
                minArgs++;
                maxArgs++;
            }
            Element e = (Element)function.getElementsByTagName("java").item(0);
            if (e != null) {
                setClassName(e.getAttribute("class"));
                setMethod(e.getAttribute("method"));
                setInitialized(Boolean.parseBoolean(e.getAttribute("initialized")));
                nl = e.getElementsByTagName("with-param");
                if (nl.getLength() > 0) {
                    setInitialized(true);
                    classParams = new ArrayList<Node>();
                    for (int i = 0; i < nl.getLength(); i++) {
                        Element el = (Element)nl.item(i);
                        Node value = null;
                        NodeList children = el.getChildNodes();
                        for (int j = 0; j < children.getLength(); j++) {
                            Node n = children.item(j);
                            if (n.getNodeType() == Node.TEXT_NODE) {
                                value = n;
                            }
                            if (n.getNodeType() == Node.ELEMENT_NODE) {
                                value = n;
                                break;
                            }
                        }
                        classParams.add(value);
                    }
                }
            }
        } catch (URISyntaxException e) {
            throw new RuntimeException(e);
        }
    }

    public File getTemplateFile() {
        return templateFile;
    }
    public void setTemplateFile(File templateFile) {
        this.templateFile = templateFile;
    }
    public String getClassName() {
        return className;
    }
    public void setClassName(String className) {
        this.className = className;
    }
    public boolean isInitialized() {
        return initialized;
    }
    public void setInitialized(boolean initialized) {
        this.initialized = initialized;
    }
    public boolean isJava() {
        return java;
    }
    public void setJava(boolean java) {
        this.java = java;
    }
    public int getMaxArgs() {
        return maxArgs;
    }
    public void setMaxArgs(int maxArgs) {
        this.maxArgs = maxArgs;
    }
    public int getMinArgs() {
        return minArgs;
    }
    public void setMinArgs(int minArgs) {
        this.minArgs = minArgs;
    }
    public String getMethod() {
        return method;
    }
    public void setMethod(String method) {
        this.method = method;
    }
    public List<Node> getClassParams() {
        return classParams;
    }
    public void setClassParams(List<Node> classParams) {
        this.classParams = classParams;
    }
    public List<QName> getParams() {
        return params;
    }
    public void setParams(List<QName> params) {
        this.params = params;
    }
    public boolean usesContext() {
        return usesContext;
    }
    public void setUsesContext(boolean usesContext) {
        this.usesContext = usesContext;
    }
}
