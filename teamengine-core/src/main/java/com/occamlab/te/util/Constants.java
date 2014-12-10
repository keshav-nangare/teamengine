package com.occamlab.te.util;

import com.occamlab.te.Test;
import net.sf.saxon.s9api.QName;

public class Constants {
  public static final String GET_FEATURE_INFO = "GetFeatureInfo";
  public static final String GET_CAPABILITY ="GetCapabilities";
  public static final String GET_MAP ="GetMap";
  public static final String YYYY_M_MDD_H_HMMSS = "yyyy/MM/dd-HH:mm:ss";
  public static final String TEST_RESULTTXT = "/test_result.txt";
  public static final String result_logxml = "/result_log.xml";
  public static final String tmp_File="/result_log1.xml";
  public static final int CONTINUE = -1;
  public static final int BEST_PRACTICE = 0;
  public static final int PASS = 1;
  public static final int NOT_TESTED = 2;
  public static final int SKIPPED = 3;
  public static final int WARNING = 4;
  public static final int INHERITED_FAILURE = 5;
  public static final int FAIL = 6;

  public static final int MANDATORY = 0;
  public static final int MANDATORY_IF_IMPLEMENTED = 1;
  public static final int OPTIONAL = 2;
  public static final String SOAP_V_1_1 = "1.1";
  public static final String SOAP_V_1_2 = "1.2";
  public static final String XSL_NS = Test.XSL_NS;
  public static final String CTL_NS = Test.CTL_NS;
  public static final String TE_NS = Test.TE_NS;
  public static final QName TECORE_QNAME = new QName("te", TE_NS, "core");
  public static final QName TEPARAMS_QNAME = new QName("te", TE_NS, "params");
  public static final QName LOCALNAME_QNAME = new QName("local-name");
  public static final QName LABEL_QNAME = new QName("label");
  public static final String HEADER_BLOCKS = "header-blocks";
}
