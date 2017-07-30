/**
 * DO NOT ALTER OR REMOVE COPYRIGHT NOTICES OR THIS HEADER.
 *
 * Copyright (c) 2011-2015 ForgeRock AS. All Rights Reserved
 *
 * The contents of this file are subject to the terms
 * of the Common Development and Distribution License
 * (the License). You may not use this file except in
 * compliance with the License.
 *
 * You can obtain a copy of the License at legal/CDDLv1.0.txt.
 * See the License for the specific language governing
 * permission and limitations under the License.
 *
 * When distributing Covered Code, include this CDDL
 * Header Notice in each file and include the License file at legal/CDDLv1.0.txt.
 * If applicable, add the following below the CDDL Header,
 * with the fields enclosed by brackets [] replaced by
 * your own identifying information:
 * "Portions Copyrighted [year] [name of copyright owner]"
 *
 */

package com.mirzlab.openam;

import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.MalformedURLException;
import java.security.Principal;
import java.util.Map;
import java.util.ResourceBundle;
import javax.net.ssl.HttpsURLConnection;
import java.net.URL;
import javax.security.auth.Subject;
import javax.security.auth.callback.Callback;
import javax.security.auth.callback.NameCallback;
import javax.security.auth.login.LoginException;
import javax.servlet.http.HttpServletResponse;
import com.sun.identity.authentication.spi.AMLoginModule;
import com.sun.identity.authentication.spi.AuthLoginException;
import com.sun.identity.authentication.util.ISAuthConstants;
import com.sun.identity.shared.datastruct.CollectionHelper;
import com.sun.identity.shared.debug.Debug;
import org.json.JSONException;
import org.json.JSONObject;

public class RecaptchaModule extends AMLoginModule {

    private final static String DEBUG_NAME = "RecaptchaModule";
    private final static Debug debug = Debug.getInstance(DEBUG_NAME);

    private final static String amAuthRecaptchaModule = "amAuthRecaptchaModule";
    private String userName = null;
    private String secret = null;

    private final static int STATE_BEGIN = 1;

    private Map<String, String> options;
    private ResourceBundle bundle;
    private Map<String, String> sharedState;

    public RecaptchaModule() {
        super();
    }

    private Boolean validateRecaptchaResponse(String response) {
        String url = "https://www.google.com/recaptcha/api/siteverify";
        try {
            URL obj = new URL(url);
            HttpsURLConnection con = (HttpsURLConnection) obj.openConnection();
            String urlParameters = "secret=" + secret + "&response=" + response;

            con.setRequestMethod("POST");

            con.setDoOutput(true);

            DataOutputStream wr = null;
            wr = new DataOutputStream(con.getOutputStream());
            wr.writeBytes(urlParameters);
            wr.flush();
            wr.close();

            int responseCode = con.getResponseCode();
            if (responseCode == HttpServletResponse.SC_OK) {
                BufferedReader in = new BufferedReader(
                        new InputStreamReader(con.getInputStream()));
                String inputLine;
                StringBuffer responseBuffer = new StringBuffer();

                while ((inputLine = in.readLine()) != null) {
                    responseBuffer.append(inputLine);
                }
                in.close();
                JSONObject responseJson = new JSONObject(responseBuffer.toString());
                return responseJson.getBoolean("success");
            }
        } catch (MalformedURLException e) {
            debug.error(e.getMessage());
        } catch (IOException e) {
            debug.error(e.getMessage());
        } catch (JSONException e) {
            debug.error(e.getMessage());
        }
        return false;
    }

    @Override
    public void init(Subject subject, Map sharedState, Map options) {
        this.options = options;
        this.sharedState = sharedState;
        this.bundle = amCache.getResBundle(amAuthRecaptchaModule, getLoginLocale());

        // Retrieve user id from previous module
        userName = (String) sharedState.get(getUserKey());
        secret = CollectionHelper.getMapAttr(
                options, "recaptcha-service-secret", "");
    }

    @Override
    public int process(Callback[] callbacks, int state) throws LoginException {
        switch (state) {
            case STATE_BEGIN:
                NameCallback nc = (NameCallback) callbacks[0];
                String recaptchaValue = nc.getName();
                if (validateRecaptchaResponse(recaptchaValue)) {
                    return ISAuthConstants.LOGIN_SUCCEED;
                }
                throw new AuthLoginException("Recaptcha not valid");
            default:
                throw new AuthLoginException("invalid state");
        }
    }

    @Override
    public Principal getPrincipal() {
        return new RecaptchaModulePrincipal(userName);
    }
}
