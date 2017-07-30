<%--
   DO NOT ALTER OR REMOVE COPYRIGHT NOTICES OR THIS HEADER.
  
   Copyright (c) 2005 Sun Microsystems Inc. All Rights Reserved
  
   The contents of this file are subject to the terms
   of the Common Development and Distribution License
   (the License). You may not use this file except in
   compliance with the License.
                                                                                
   You can obtain a copy of the License at
   https://opensso.dev.java.net/public/CDDLv1.0.html or
   opensso/legal/CDDLv1.0.txt
   See the License for the specific language governing
   permission and limitations under the License.
                                                                                
   When distributing Covered Code, include this CDDL
   Header Notice in each file and include the License file
   at opensso/legal/CDDLv1.0.txt.
   If applicable, add the following below the CDDL Header,
   with the fields enclosed by brackets [] replaced by
   your own identifying information:
   "Portions Copyrighted [year] [name of copyright owner]"
                                                                                
   $Id: membership.jsp,v 1.9 2008/12/23 21:24:32 ericow Exp $
                                                                                
   Portions Copyrighted 2012-2014 ForgeRock AS.
--%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
    <%@page info="Membership" language="java"%>
    <%@taglib uri="/WEB-INF/jato.tld" prefix="jato"%>
    <%@taglib uri="/WEB-INF/auth.tld" prefix="auth"%>
    <jato:useViewBean className="com.sun.identity.authentication.UI.LoginViewBean">
        <%@ page contentType="text/html" %>
        <%@ page import = "org.owasp.esapi.ESAPI" %>
        <head>
            <script src='https://www.google.com/recaptcha/api.js'></script>
            <% 
            String ServiceURI = (String) viewBean.getDisplayFieldValue(viewBean.SERVICE_URI);
            String encoded = "false";
            String gotoURL = (String) viewBean.getValidatedInputURL(
                request.getParameter("goto"), request.getParameter("encoded"), request);
            if ((gotoURL != null) && (gotoURL.length() != 0)) {
                encoded = "true";
            }
            %>
            <link href="<%= ServiceURI%>/css/new_style.css" rel="stylesheet" type="text/css" />
            <!--[if IE 9]> <link href="<%= ServiceURI%>/css/ie9.css" rel="stylesheet" type="text/css"> <![endif]-->
            <!--[if lte IE 7]> <link href="<%= ServiceURI%>/css/ie7.css" rel="stylesheet" type="text/css"> <![endif]-->
            <script language="JavaScript" src="<%= ServiceURI%>/js/auth.js" type="text/javascript"></script>
            <jato:content name="validContent">
                <script language="JavaScript" type="text/javascript">
                    <!--
                    var defaultBtn = 'Submit';
                    var elmCount = 0;

                    /** submit form with default command button */
                    function defaultSubmit() {
                        document.getElementById("IDToken1").value = document.getElementById("g-recaptcha-response").value;
                        LoginSubmit(defaultBtn);
                    }

                    /**
                     * submit form with given button value
                     *
                     * @param value of button
                     */
                    function LoginSubmit(value) {
                        document.getElementById("IDToken1").value = document.getElementById("g-recaptcha-response").value;
                        aggSubmit();
                        var hiddenFrm = document.forms['Login'];
        
                        if (hiddenFrm != null) {
                            hiddenFrm.elements['IDButton'].value = value;
                            if (this.submitted) {
                                alert("The request is currently being processed");
                            }
                            else {
                                this.submitted = true;
                                hiddenFrm.submit();
                            }
                        }
                    }
                    -->
                </script>
            </jato:content>
            <script src='https://www.google.com/recaptcha/api.js'></script>
        </head>
        <body onload="placeCursorOnFirstElm();">
            <div class="container_12">
                <div class="grid_4 suffix_8">
                    <a class="logo" href="<%= ServiceURI%>"></a>
                </div>
                <div class="box clear-float">
                    <div class="grid_3">
                        <div class="product-logo"></div>
                    </div>
                    <div class="grid_9 left-seperator">
                        <div class="box-content clear-float">
                            <jato:content name="ContentStaticTextHeader">
                                <h1><jato:getDisplayFieldValue name='StaticTextHeader'
                                                           defaultValue='Authentication' fireDisplayEvents='true'
                                                           escape='false'/></h1>
                                </jato:content>
                                <jato:content name="validContent">
                                    <jato:tiledView name="tiledCallbacks"
                                                    type="com.sun.identity.authentication.UI.CallBackTiledView">

                                    <script language="javascript" type="text/javascript">
                                        <!--
                                        elmCount++;
                                        -->
                                    </script>

                                    <jato:content name="textBox">
                                        <form name="frm<jato:text name="txtIndex" />" action="blank"
                                              onsubmit="defaultSubmit(); return false;" method="post">
                                            <div class="row">
                                                <label for="IDToken<jato:text name="txtIndex" />">
                                                    <jato:text name="txtPrompt" defaultValue="User name:" escape="false" />
                                                    <jato:content name="isRequired">
                                                        <img src="<%= ServiceURI %>/images/required.gif" alt="Required Field"
                                                             title="Required Field" width="7" height="14" />
                                                    </jato:content>
                                                </label>
                                                <input style="display: none" class="textbox" type="text" name="IDToken<jato:text name="txtIndex" />" id="IDToken<jato:text name="txtIndex" />" value="<jato:text name="txtValue" />" />
                                            </div>
                                        </form>
                                    </jato:content>
                                    <jato:content name="password">
                                        <form name="frm<jato:text name="txtIndex" />" action="blank"
                                              onsubmit="defaultSubmit(); return false;" method="post">
                                            <div class="row">
                                                <label for="IDToken<jato:text name="txtIndex" />">
                                                    <jato:text name="txtPrompt" defaultValue="Password:" escape="false" />
                                                    <jato:content name="isRequired">
                                                        <img src="<%= ServiceURI %>/images/required.gif" alt="Required Field"
                                                             title="Required Field" width="7" height="14" />
                                                    </jato:content>
                                                </label>
                                                <input class="textbox" type="password" name="IDToken<jato:text name="txtIndex" />" id="IDToken<jato:text name="txtIndex" />" value="" />
                                            </div>
                                        </form>
                                    </jato:content>
                                </jato:tiledView>
                                <auth:form name="Login" method="post" defaultCommandChild="DefaultLoginURL">
                                    <script language="javascript" type="text/javascript">
                                        <!--
                                        if (elmCount != null) {
                                            for (var i = 0; i < elmCount; i++) {
                                                document.write(
                                                "<input name=\"IDToken" + i + "\" type=\"hidden\">");
                                            }
                                            document.write("<input name=\"IDButton"  + "\" type=\"hidden\">");
                                        }
                                        -->
                                    </script>
                                    <input type="hidden" name="goto" value="<%= ESAPI.encoder().encodeForHTMLAttribute(gotoURL) %>"/>
                                    <input type="hidden" name="encoded" value="<%= encoded %>"/>
                                    <div class="g-recaptcha" data-sitekey="RECAPTCHA_SECRET"></div>
                                </auth:form>
                                <jato:content name="ContentButtonLogin">
                                    <fieldset>
                                        <jato:content name="hasButton">
                                            <div class="row">
                                                <jato:tiledView name="tiledButtons"
                                                                type="com.sun.identity.authentication.UI.ButtonTiledView">
                                                    <input name="Login.Submit" type="button" onclick="LoginSubmit('<jato:text name="txtButton" />'); return false;" class="button" value="<jato:text name="txtButton" />" />

                                                </jato:tiledView>
                                            </div>
                                            <script language="javascript" type="text/javascript">
                                                <!--
                                                defaultBtn = '<jato:text name="defaultBtn" />';
                                                var inputs = document.getElementsByTagName('input');
                                                for (var i = 0; i < inputs.length; i ++) {
                                                    if (inputs[i].type == 'button' && inputs[i].value == defaultBtn) {
                                                        inputs[i].setAttribute("class", "button primary");;
                                                        break;
                                                    }
                                                }
                                                -->
                                            </script>
                                        </jato:content>
                                        <jato:content name="hasNoButton">
                                            <div class="row">
                                                <input name="Login.Submit" type="submit" onclick="LoginSubmit('<jato:text name="cmdSubmit" />'); return false;" class="button primary" value="<jato:text name="lblSubmit" />" />
                                            </div>
                                        </jato:content>
                                    </fieldset>
                                </jato:content>

                            </jato:content>
                        </div>
                    </div>
                </div>
                <div class="footer alt-color">
                    <div class="grid_6 suffix_3">
                        <p><auth:resBundle bundleName="amAuthUI" resourceKey="copyright.notice" /></p>
                    </div>
                </div>
            </div>
        </body>
    </jato:useViewBean>
</html>
