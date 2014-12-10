<xsl:transform
  xmlns:viewlog="viewlog"
  xmlns:te="java:com.occamlab.te.TECore"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:encoder="java:java.net.URLEncoder"
  xmlns:file="java:java.io.File"
  xmlns:ctl="http://www.occamlab.com/ctl"
  exclude-result-prefixes="viewlog encoder file te ctl"
  version="2.0">
  <xsl:template name="Client-Result">
    <xsl:param name="continue">-1</xsl:param>
    <xsl:param name="bestPractice">0</xsl:param>
    <xsl:param name="pass">1</xsl:param>
    <xsl:param name="notTested">2</xsl:param>
    <xsl:param name="skipped">3</xsl:param>
    <xsl:param name="warning">4</xsl:param>
    <xsl:param name="inheritedFailure">5</xsl:param>
    <xsl:param name="fail">6</xsl:param>
    <xsl:variable name="coverage-results">
      <service-requests>
        <xsl:for-each select="collection(concat($logdir,'/',$sessionDir,'?select=WMS-*.xml'))">
          <xsl:copy-of select="doc(document-uri(.))"/>
        </xsl:for-each>
      </service-requests>
    </xsl:variable>
    <xsl:variable name="address" select="$TESTNAME"/>
    <!-- Displayed the all test name -->
    <fieldset style="background:#ffffff; border: 0px">
      <div id="WMS-Client">
        <img src="images/minus.png" name="image1" id="WMS-Client__result" align="middle" onclick="toggleDiv(this);"/>
        <img src="images/warning.png" id="WMS-Client-result" align="middle" alt="Begin" />
        <b>Test WMS-Client 1.3</b><xsl:text>&#xa;(</xsl:text>
            <a href="viewClientTestLog.jsp?test={$sessionDir}&amp;testNo=0">View Details</a>
            <xsl:text>)</xsl:text>
      </div>
      <div id="WMS-Client_result">
        <div id="capability" style="margin-left:20px">
          <img src="images/minus.png" name="image1" id="capability__result" align="middle" onclick="toggleDiv(this);"></img>
          <img src="images/warning.png" id="capability_img" align="middle" alt="Begin" />
          <b>Perform at least one GetCapabilities request</b><xsl:text>&#xa;(</xsl:text>
            <a href="viewClientTestLog.jsp?test={$sessionDir}&amp;testNo=1">View Details</a>
            <xsl:text>)</xsl:text>
        </div>
        <div id="capability_result" style="margin-left:40px; margin-top: 0px;margin-bottom: 0px;">
          <p id="2" style="margin-left:20px; margin-top: 0px;margin-bottom: 0px;"/>
        </div>
                            
        <div id="map" style="margin-left:20px">
          <img src="images/minus.png" name="image1" id="map__result" align="middle" onclick="toggleDiv(this);"></img>
          <img src="images/warning.png" id="map_img" align="middle" alt="Begin" />
          <b>Perform GetMap request for all the layers</b><xsl:text>&#xa;(</xsl:text>
            <a href="viewClientTestLog.jsp?test={$sessionDir}&amp;testNo=2">View Details</a>
            <xsl:text>)</xsl:text>
          </div>
        <div id="map_result">
                            
          <div id="Autos" style="margin-left:40px">
            <img src="images/warning.png" id="Autos_img" align="middle" alt="Begin" ></img>
            <b>cite:Autos</b><xsl:text>&#xa;(</xsl:text>
            <a href="viewClientTestLog.jsp?test={$sessionDir}&amp;testNo=3">View Details</a>
            <xsl:text>)</xsl:text>
          </div>
                            
          <p id="4" style="margin-left:60px; margin-top: 0px;margin-bottom: 0px;"/>
                            
          <div id="BasicPolygons" style="margin-left:40px">
            <img src="images/warning.png" id="BasicPolygons_img" align="middle" alt="Begin" ></img>
            <b>cite:BasicPolygons</b><xsl:text>&#xa;(</xsl:text>
            <a href="viewClientTestLog.jsp?test={$sessionDir}&amp;testNo=4">View Details</a>
            <xsl:text>)</xsl:text>
          </div>
                            
          <p id="5" style="margin-left:60px; margin-top: 0px;margin-bottom: 0px;"/>
                                    
          <div id="Bridges" style="margin-left:40px">
            <img src="images/warning.png" id="Bridges_img" align="middle" alt="Begin" ></img>
            <b>cite:Bridges</b><xsl:text>&#xa;(</xsl:text>
            <a href="viewClientTestLog.jsp?test={$sessionDir}&amp;testNo=5">View Details</a>
            <xsl:text>)</xsl:text>
          </div>
                            
          <p id="6" style="margin-left:60px; margin-top: 0px;margin-bottom: 0px;"/>
                            
          <div id="BuildingCenters" style="margin-left:40px">
            <img src="images/warning.png" id="BuildingCenters_img" align="middle" alt="Begin" ></img>
            <b>cite:BuildingCenters</b><xsl:text>&#xa;(</xsl:text>
            <a href="viewClientTestLog.jsp?test={$sessionDir}&amp;testNo=6">View Details</a>
            <xsl:text>)</xsl:text>
          </div>
                            
          <p id="7" style="margin-left:60px; margin-top: 0px;margin-bottom: 0px;"/>
                            
          <div id="Buildings" style="margin-left:40px">
            <img src="images/warning.png" id="Buildings_img" align="middle" alt="Begin" ></img>
            <b>cite:Buildings</b><xsl:text>&#xa;(</xsl:text>
            <a href="viewClientTestLog.jsp?test={$sessionDir}&amp;testNo=7">View Details</a>
            <xsl:text>)</xsl:text>
          </div>
                            
          <p id="8" style="margin-left:60px; margin-top: 0px;margin-bottom: 0px;"/>
                            
          <div id="DividedRoutes" style="margin-left:40px">
            <img src="images/warning.png" id="DividedRoutes_img" align="middle" alt="Begin" ></img>
            <b>cite:DividedRoutes</b><xsl:text>&#xa;(</xsl:text>
            <a href="viewClientTestLog.jsp?test={$sessionDir}&amp;testNo=8">View Details</a>
            <xsl:text>)</xsl:text>
          </div>
                            
          <p id="9" style="margin-left:60px; margin-top: 0px;margin-bottom: 0px;"/>
                            
          <div id="Forests" style="margin-left:40px">
            <img src="images/warning.png" id="Forests_img" align="middle" alt="Begin" ></img>
            <b>cite:Forests</b><xsl:text>&#xa;(</xsl:text>
            <a href="viewClientTestLog.jsp?test={$sessionDir}&amp;testNo=9">View Details</a>
            <xsl:text>)</xsl:text>
          </div>
                            
          <p id="10" style="margin-left:60px; margin-top: 0px;margin-bottom: 0px;"/>
                            
          <div id="Lakes" style="margin-left:40px">
            <img src="images/warning.png" id="Lakes_img" align="middle" alt="Begin" ></img>
            <b>cite:Lakes</b><xsl:text>&#xa;(</xsl:text>
            <a href="viewClientTestLog.jsp?test={$sessionDir}&amp;testNo=10">View Details</a>
            <xsl:text>)</xsl:text>
          </div>
                            
          <p id="11" style="margin-left:60px; margin-top: 0px;margin-bottom: 0px;"/>
                            
          <div id="MapNeatline" style="margin-left:40px">
            <img src="images/warning.png" id="MapNeatline_img" align="middle" alt="Begin" ></img>
            <b>cite:MapNeatline</b><xsl:text>&#xa;(</xsl:text>
            <a href="viewClientTestLog.jsp?test={$sessionDir}&amp;testNo=11">View Details</a>
            <xsl:text>)</xsl:text>
          </div>
                            
          <p id="12" style="margin-left:60px; margin-top: 0px;margin-bottom: 0px;"/>
                            
          <div id="NamedPlaces" style="margin-left:40px">
            <img src="images/warning.png" id="NamedPlaces_img" align="middle" alt="Begin" ></img>
            <b>cite:NamedPlaces</b><xsl:text>&#xa;(</xsl:text>
            <a href="viewClientTestLog.jsp?test={$sessionDir}&amp;testNo=12">View Details</a>
            <xsl:text>)</xsl:text>
          </div>
                            
          <p id="13" style="margin-left:60px; margin-top: 0px;margin-bottom: 0px;"/>
                            
          <div id="Ponds" style="margin-left:40px">
            <img src="images/warning.png" id="Ponds_img" align="middle" alt="Begin" ></img>
            <b>cite:Ponds</b><xsl:text>&#xa;(</xsl:text>
            <a href="viewClientTestLog.jsp?test={$sessionDir}&amp;testNo=13">View Details</a>
            <xsl:text>)</xsl:text>
          </div>
                            
          <p id="14" style="margin-left:60px; margin-top: 0px;margin-bottom: 0px;"/>
                            
          <div id="RoadSegments" style="margin-left:40px">
            <img src="images/warning.png" id="RoadSegments_img" align="middle" alt="Begin" ></img>
            <b>cite:RoadSegments</b><xsl:text>&#xa;(</xsl:text>
            <a href="viewClientTestLog.jsp?test={$sessionDir}&amp;testNo=14">View Details</a>
            <xsl:text>)</xsl:text>
          </div>
                            
          <p id="15" style="margin-left:60px; margin-top: 0px;margin-bottom: 0px;"/>
                            
          <div id="Streams" style="margin-left:40px">
            <img src="images/warning.png" id="Streams_img" align="middle" alt="Begin" ></img>
            <b>cite:Streams</b><xsl:text>&#xa;(</xsl:text>
            <a href="viewClientTestLog.jsp?test={$sessionDir}&amp;testNo=15">View Details</a>
            <xsl:text>)</xsl:text>
          </div>
                            
          <p id="16" style="margin-left:60px; margin-top: 0px;margin-bottom: 0px;"/>
                            
          <div id="Terrain" style="margin-left:40px">
            <img src="images/warning.png" id="Terrain_img" align="middle" alt="Begin" ></img>
            <b>cite:Terrain</b><xsl:text>&#xa;(</xsl:text>
            <a href="viewClientTestLog.jsp?test={$sessionDir}&amp;testNo=16">View Details</a>
            <xsl:text>)</xsl:text>
          </div>

          <p id="17" style="margin-left:60px; margin-top: 0px;margin-bottom: 0px;"/>
                                
        </div>
                            
        <div id="feature" style="margin-left:20px">
          <img src="images/minus.png" name="image1" id="feature__result" align="middle" onclick="toggleDiv(this);"></img>
          <img src="images/warning.png" id="feature_img" align="middle" alt="Begin" />
          <b>Perform at least one GetFeatureInfo request</b><xsl:text>&#xa;(</xsl:text>
            <a href="viewClientTestLog.jsp?test={$sessionDir}&amp;testNo=17">View Details</a>
            <xsl:text>)</xsl:text>
        </div> 
        <div id="feature_result" style="margin-left:40px; margin-top: 0px;margin-bottom: 0px;">
          <p id="18" style="margin-left:20px; margin-top: 0px;margin-bottom: 0px;"/>
        </div>
      </div>
      <p id="show"  style="margin-left:40px; margin-top: 0px;margin-bottom: 0px;"/>
    </fieldset>
    <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.4.2/jquery.min.js"> &#160; </script>
    <!-- Change the image on click show and hide button -->
    <script language="javascript">  
      <xsl:comment><![CDATA[ 
		function toggleDiv(divID) {
		    var url = location.href;
		    var divid = $(divID).attr("id");
		    var value = divid.split("__");
		    var path = $(divID).attr("src");
		    var result_url = url.split("teamengine");
		    var expend = "images/plus.png";
		    var merge = "images/minus.png";
		    var other = result_url[0] + "teamengine/images/abc.png";
		    if (path.indexOf('minus') > -1) {
			$("#" + divid).attr("src", expend);
		    } else if (path.indexOf('plus') > -1) {
			$("#" + divid).attr("src", merge);
		    } else {
			$("#" + divid).attr("src", other);
		    }
		    $("#" + value[0] + "_" + value[1]).toggle();
		}
]]> </xsl:comment>
    </script>
    <!-- getSession and user directory -->
    <script type="text/javascript">
	function getSession() {
	    var sessionID = '<xsl:value-of select="$sessionDir"/>';
	    return sessionID;
	}

	function getUser() {
	    var userName = '<xsl:value-of select="$logdir"/>';
	    return userName.split("users/")[1];
	}
    </script>   
    <!-- Displayed the result on viewSessionLog screen dynamically -->
    <script type="text/javascript">   
      <xsl:comment><![CDATA[ 
            $(document).ready(function() {
                var url = location.href;
                var result_url = url.split("teamengine");
                var c_name_value = getUser();
                var c_sessionID_value = getSession();
                var urlpath = "";
                var success = "images/pass.png";
                var error = "images/fail.png";
                var warning = "images/warning.png";
                urlpath = result_url[0] + "teamengine/restResult/suiteResult?userID=" + c_name_value + "&sessionID=" + c_sessionID_value;
                $.ajax({
                    type: "GET",
                    url: urlpath,
                    success: function(data) {
                        var jsonData = JSON.parse(data);
                        var text = "";
                        if (jsonData.Result !== undefined) {
                            for (var index = 18; index < jsonData.Result.length; index++) {
                                var reqno=jsonData.Result[index].Name.split(" ")[1];
                              if(jsonData.Result[index].Name.indexOf('Passed')>-1){
                                $('#' + jsonData.Result[index].ParentID).append($('<p style="margin-bottom:0px; margin-top:0px;"><img src="' + success + '" ></img>' + jsonData.Result[index].Name +"("+'<a href='+"viewClientTestLog.jsp?test="+c_sessionID_value+"&reqNo="+reqno+"&result=P"+'>'+"View Details"+'</a>'+")"+ '</p>'));
                              }else{
                                $('#' + jsonData.Result[index].ParentID).append($('<p style="margin-bottom:0px; margin-top:0px;"><img src="' + error + '" ></img>' + jsonData.Result[index].Name +"("+'<a href='+"viewClientTestLog.jsp?test="+c_sessionID_value+"&reqNo="+reqno+"&result=F"+'>'+"View Details"+'</a>'+")"+ '</p>'));
                              }
                          }
                        }
                        if (($('#2').text().indexOf('Request') == -1) || ($('#2').text().indexOf('Failed') != -1)) {
                            $('#capability_img').attr("src", error);
                            $('#WMS-Client-result').attr("src", error);
                        } else {
                            $('#capability_img').attr("src", success);
                        }
                        if ($('#4').text().indexOf('Request') == -1) {
                            $('#Autos_img').attr("src", error);
                            $('#map_img').attr("src", error);
                            $('#WMS-Client-result').attr("src", error);
                        } else {
                            $('#Autos_img').attr("src", success);
                        }
                        if ($('#5').text().indexOf('Request') == -1) {
                            $('#BasicPolygons_img').attr("src", error);
                            $('#map_img').attr("src", error);
                            $('#WMS-Client-result').attr("src", error);
                        } else {
                            $('#BasicPolygons_img').attr("src", success);
                        }
                        if ($('#6').text().indexOf('Request') == -1) {
                            $('#Bridges_img').attr("src", error);
                            $('#map_img').attr("src", error);
                            $('#WMS-Client-result').attr("src", error);
                        } else {
                            $('#Bridges_img').attr("src", success);
                        }
                        if ($('#7').text().indexOf('Request') == -1) {
                            $('#BuildingCenters_img').attr("src", error);
                            $('#map_img').attr("src", error);
                            $('#WMS-Client-result').attr("src", error);
                        } else {
                            $('#BuildingCenters_img').attr("src", success);
                        }
                        if ($('#8').text().indexOf('Request') == -1) {
                            $('#Buildings_img').attr("src", error);
                            $('#map_img').attr("src", error);
                            $('#WMS-Client-result').attr("src", error);
                        } else {
                            $('#Buildings_img').attr("src", success);
                        }
                        if ($('#9').text().indexOf('Request') == -1) {
                            $('#DividedRoutes_img').attr("src", error);
                            $('#map_img').attr("src", error);
                            $('#WMS-Client-result').attr("src", error);
                        } else {
                            $('#DividedRoutes_img').attr("src", success);
                        }
                        if ($('#10').text().indexOf('Request') == -1) {
                            $('#Forests_img').attr("src", error);
                            $('#map_img').attr("src", error);
                            $('#WMS-Client-result').attr("src", error);
                        } else {
                            $('#Forests_img').attr("src", success);
                        }
                        if ($('#11').text().indexOf('Request') == -1) {
                            $('#Lakes_img').attr("src", error);
                            $('#map_img').attr("src", error);
                            $('#WMS-Client-result').attr("src", error);
                        } else {
                            $('#Lakes_img').attr("src", success);
                        }
                        if ($('#12').text().indexOf('Request') == -1) {
                            $('#MapNeatline_img').attr("src", error);
                            $('#map_img').attr("src", error);
                            $('#WMS-Client-result').attr("src", error);
                        } else {
                            $('#MapNeatline_img').attr("src", success);
                        }
                        if ($('#13').text().indexOf('Request') == -1) {
                            $('#NamedPlaces_img').attr("src", error);
                            $('#map_img').attr("src", error);
                            $('#WMS-Client-result').attr("src", error);
                        } else {
                            $('#NamedPlaces_img').attr("src", success);
                        }
                        if ($('#14').text().indexOf('Request') == -1) {
                            $('#Ponds_img').attr("src", error);
                            $('#map_img').attr("src", error);
                            $('#WMS-Client-result').attr("src", error);
                        } else {
                            $('#Ponds_img').attr("src", success);
                        }
                        if ($('#15').text().indexOf('Request') == -1) {
                            $('#RoadSegments_img').attr("src", error);
                            $('#map_img').attr("src", error);
                            $('#WMS-Client-result').attr("src", error);
                        } else {
                            $('#RoadSegments_img').attr("src", success);
                        }
                        if ($('#16').text().indexOf('Request') == -1) {
                            $('#Streams_img').attr("src", error);
                            $('#map_img').attr("src", error);
                            $('#WMS-Client-result').attr("src", error);
                        } else {
                            $('#Streams_img').attr("src", success);
                        }
                        if ($('#17').text().indexOf('Request') == -1) {
                            $('#Terrain_img').attr("src", error);
                            $('#map_img').attr("src", error);
                            $('#WMS-Client-result').attr("src", error);
                        } else {
                            $('#Terrain_img').attr("src", success);
                        }
                        if ($('#map_img').attr("src").indexOf('warning') > -1) {
                            $('#map_img').attr("src", success);
                        }
                        if (($('#18').text().indexOf('Request') == -1) || ($('#18').text().indexOf('Failed') != -1)) {
                            $('#feature_img').attr("src", error);
                            $('#WMS-Client-result').attr("src", error);
                        } else {
                            $('#feature_img').attr("src", success);
                        }
                        if ($('#WMS-Client-result').attr("src").indexOf('warning') > -1) {
                            $('#WMS-Client-result').attr("src", success);
                        }
                    },
                    error: function(jqXHR, textStatus, errorThrown) {
                        $('#show').text("");
                    },
                    dataType: "text"
                });
            });   
            ]]> </xsl:comment>
    </script>
                        
    <xsl:if test="test">
      <!-- Count the run test which passed, failed or skipped  -->
      <table id="summary" border="0" cellpadding="4">
        <tr>
          <th align="left" colspan="8" 
                        style="font-family: sans-serif; color: #000099; background:#ccffff">Summary of results</th>
        </tr>
        <tr>
          <td>
            <img src="images/bestPractice.png" /> Best Practice</td>
          <td>
            <img src="images/pass.png" /> Passed</td>
          <td>
            <img src="images/continue.png" /> Continue</td>
          <td>
            <img src="images/notTested.png" /> Not Tested</td>
          <td>
            <img src="images/warn.png" /> Warning</td>
          <td>
            <img src="images/skipped.png" /> Skipped</td>
          <td>
            <img src="images/fail.png" /> Failed</td>
          <td>
            <img src="images/inheritedFailure.png" /> Failed (Inherited)</td>
        </tr>
        <tr>
          <td id="nBestPractice" align="center" bgcolor="#00FF00">
            <xsl:value-of select="count(//test[@result=$bestPractice and @complete='yes'])"/>
          </td>
          <td id="nPass" align="center" bgcolor="#00FF00">
            <xsl:if test="count($coverage-results//param) > 0">
              <xsl:if test="(not(doc-available(concat($logdir,'/',$sessionDir,'/test_data/WMS1-GetCapabilities.xml')))) and (doc-available(concat($logdir,'/',$sessionDir,'/test_data/WMS1-GetFeatureInfo.xml')))">
                <xsl:value-of select="16-(count($coverage-results//param[@name='layers']/value)+1)"/>
              </xsl:if>
              <xsl:if test="(not(doc-available(concat($logdir,'/',$sessionDir,'/test_data/WMS1-GetFeatureInfo.xml')))) and (doc-available(concat($logdir,'/',$sessionDir,'/test_data/WMS1-GetCapabilities.xml')))">
                <xsl:value-of select="16-(count($coverage-results//param[@name='layers']/value)+1)"/>
              </xsl:if>
              <xsl:if test="(not(doc-available(concat($logdir,'/',$sessionDir,'/test_data/WMS1-GetFeatureInfo.xml')))) and (not(doc-available(concat($logdir,'/',$sessionDir,'/test_data/WMS1-GetCapabilities.xml'))))">
                <xsl:value-of select="16-(count($coverage-results//param[@name='layers']/value)+2)"/>
              </xsl:if>
              <xsl:if test="(doc-available(concat($logdir,'/',$sessionDir,'/test_data/WMS1-GetFeatureInfo.xml'))) and (doc-available(concat($logdir,'/',$sessionDir,'/test_data/WMS1-GetCapabilities.xml')))">
                <xsl:value-of select="16-(count($coverage-results//param[@name='layers']/value))"/>
              </xsl:if>     
            </xsl:if>       
          </td>
          <td id="nContinue" align="center" bgcolor="#FFFF00">
            <xsl:value-of select="count(//test[@result=$continue or @complete='no'])"/>
          </td>
          <td id="nNotTested" align="center" bgcolor="#FFFF00">
            <xsl:value-of select="0"/>
          </td>
          <td id="nWarn" align="center" bgcolor="#FFFF00">
            <xsl:value-of select="count(//test[@result=$warning and @complete='yes'])"/>
          </td>
          <td id="nSkipped" align="center" bgcolor="#FFFF00">
            <xsl:value-of select="count(//test[@result=$skipped and @complete='yes'])"/>
          </td>
          <td id="nFail" align="center" bgcolor="#FF0000">
            <xsl:if test="count($coverage-results//param) > 0">
              <xsl:if test="(not(doc-available(concat($logdir,'/',$sessionDir,'/test_data/WMS1-GetCapabilities.xml')))) and (doc-available(concat($logdir,'/',$sessionDir,'/test_data/WMS1-GetFeatureInfo.xml')))">
                <xsl:value-of select="count($coverage-results//param[@name='layers']/value)+1"/>
              </xsl:if>
              <xsl:if test="(not(doc-available(concat($logdir,'/',$sessionDir,'/test_data/WMS1-GetFeatureInfo.xml')))) and (doc-available(concat($logdir,'/',$sessionDir,'/test_data/WMS1-GetCapabilities.xml')))">
                <xsl:value-of select="count($coverage-results//param[@name='layers']/value)+1"/>
              </xsl:if>
              <xsl:if test="(not(doc-available(concat($logdir,'/',$sessionDir,'/test_data/WMS1-GetFeatureInfo.xml')))) and (not(doc-available(concat($logdir,'/',$sessionDir,'/test_data/WMS1-GetCapabilities.xml'))))">
                <xsl:value-of select="count($coverage-results//param[@name='layers']/value)+2"/>
              </xsl:if>
              <xsl:if test="(doc-available(concat($logdir,'/',$sessionDir,'/test_data/WMS1-GetFeatureInfo.xml'))) and (doc-available(concat($logdir,'/',$sessionDir,'/test_data/WMS1-GetCapabilities.xml')))">
                <xsl:value-of select="count($coverage-results//param[@name='layers']/value)"/>
              </xsl:if>
            </xsl:if>
          </td>
          <td id="nInheritedFail" align="center" bgcolor="#FF0000">
            <xsl:value-of select="0"/>
          </td>
        </tr>
      </table>
    </xsl:if>
  </xsl:template>
</xsl:transform>
