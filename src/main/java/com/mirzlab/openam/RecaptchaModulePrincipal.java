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

import java.io.Serializable;
import java.security.Principal;

/**
 * RecaptchaModulePrincipal represents the user entity.
 */
public class RecaptchaModulePrincipal implements Principal, Serializable {
    private final static String COLON = " : ";

    private final String name;

    public RecaptchaModulePrincipal(String name) {

        if (name == null) {
            throw new NullPointerException("illegal null input");
        }

        this.name = name;
    }

    /**
     * Return the LDAP username for this <code>RecaptchaModulePrincipal</code>.
     *
     * @return the LDAP username for this <code>RecaptchaModulePrincipal</code>
     */
    @Override
    public String getName() {
        return name;
    }

    /**
     * Return a string representation of this <code>RecaptchaModulePrincipal</code>.
     *
     * @return a string representation of this
     *         <code>TestAuthModulePrincipal</code>.
     */
    @Override
    public String toString() {
        return new StringBuilder().append(this.getClass().getName())
                .append(COLON).append(name).toString();
    }

    /**
     * Compares the specified Object with this <code>RecaptchaModulePrincipal</code>
     * for equality. Returns true if the given object is also a
     * <code> RecaptchaModulePrincipal </code> and the two RecaptchaModulePrincipal have
     * the same username.
     *
     * @param o Object to be compared for equality with this
     *          <code>RecaptchaModulePrincipal</code>.
     * @return true if the specified Object is equal equal to this
     *         <code>RecaptchaModulePrincipal</code>.
     */
    @Override
    public boolean equals(Object o) {
        if (o == null) {
            return false;
        }

        if (this == o) {
            return true;
        }

        if (!(o instanceof RecaptchaModulePrincipal)) {
            return false;
        }
        RecaptchaModulePrincipal that = (RecaptchaModulePrincipal) o;

        if (this.getName().equals(that.getName())) {
            return true;
        }
        return false;
    }

    /**
     * Return a hash code for this <code>RecaptchaModulePrincipal</code>.
     *
     * @return a hash code for this <code>RecaptchaModulePrincipal</code>.
     */
    @Override
    public int hashCode() {
        return name.hashCode();
    }
}
