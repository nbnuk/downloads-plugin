/*
 * Copyright (C) 2016 Atlas of Living Australia
 * All Rights Reserved.
 * The contents of this file are subject to the Mozilla Public
 * License Version 1.1 (the "License"); you may not use this file
 * except in compliance with the License. You may obtain a copy of
 * the License at http://www.mozilla.org/MPL/
 * Software distributed under the License is distributed on an "AS
 * IS" basis, WITHOUT WARRANTY OF ANY KIND, either express or
 * implied. See the License for the specific language governing
 * rights and limitations under the License.
 */
package au.org.ala.downloads

import groovy.util.logging.Slf4j

/**
 * Enum for download types
 *
 * @author "Nick dos Remedios <Nick.dosRemedios@csiro.au>"
 */
@Slf4j
enum DownloadType {
    RECORDS("records"),
    CHECKLIST("checklist"),
    FIELDGUIDE("fieldguide")

    String type

    DownloadType(String name) {
        this.type = name
    }

    @Override
    public String toString() {
        return this.type;
    }

    /**
     * Do a lookup on the fieldName field
     *
     * @param type
     * @return
     */
    public static DownloadType valueOfType(String type) {
        for (DownloadType dt : values()) {
            if (dt.type.equals(type)) {
                log.info "matched value = ${dt}"
                return dt
            }
        }
        throw new IllegalArgumentException("No enum const " + DownloadType.class + "@type." + type);
    }
}
