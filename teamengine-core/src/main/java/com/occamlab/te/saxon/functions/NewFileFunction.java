package com.occamlab.te.saxon.functions;

import java.io.File;
import net.sf.saxon.s9api.ExtensionFunction;
import net.sf.saxon.s9api.ItemType;
import net.sf.saxon.s9api.ItemTypeFactory;
import net.sf.saxon.s9api.OccurrenceIndicator;
import net.sf.saxon.s9api.Processor;
import net.sf.saxon.s9api.QName;
import net.sf.saxon.s9api.SaxonApiException;
import net.sf.saxon.s9api.SequenceType;
import net.sf.saxon.s9api.XdmAtomicValue;
import net.sf.saxon.s9api.XdmExternalObject;
import net.sf.saxon.s9api.XdmValue;

/**
 * Creates a File instance (wrapped in a
 * <code>net.sf.saxon.s9api.XdmExternalObject</code> object) corresponding to
 * the given absolute pathname string. The function name is
 * {@code "{http://cite.opengeospatial.org/functions}new-file"}.
 */
public class NewFileFunction implements ExtensionFunction {

    @Override
    public QName getName() {
        return new QName("http://cite.opengeospatial.org/functions", "new-file");
    }

    @Override
    public SequenceType getResultType() {
        ItemTypeFactory factory = new ItemTypeFactory(new Processor(false));
        return SequenceType.makeSequenceType(factory.getExternalObjectType(File.class), OccurrenceIndicator.ONE);
    }

    @Override
    public SequenceType[] getArgumentTypes() {
        return new SequenceType[] { SequenceType.makeSequenceType(ItemType.STRING, OccurrenceIndicator.ONE) };
    }

    @Override
    public XdmValue call(XdmValue[] args) throws SaxonApiException {
        String pathName = ((XdmAtomicValue) args[0].itemAt(0)).getStringValue();
        File file = new File(pathName);
        return new XdmExternalObject(file);
    }
}
