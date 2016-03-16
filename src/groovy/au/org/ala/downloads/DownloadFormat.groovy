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

import groovy.util.logging.Log4j

/**
 * Enum for download records format
 *
 * @author "Nick dos Remedios <Nick.dosRemedios@csiro.au>"
 */
@Log4j
enum DownloadFormat {
    DWC("dwc"),
    LEGACY("legacy"),
    CUSTOM("custom")

    String format

    DownloadFormat(String name) {
        this.format = name
    }

    @Override
    public String toString() {
        return this.format;
    }

    /**
     * Do a lookup on the format field
     *
     * @param type
     * @return
     */
    public static DownloadFormat valueOfFormat(String type) {
        for (DownloadFormat df : values()) {
            if (df.format.equals(type)) {
                log.info "matched value = ${df}"
                return df
            }
        }
        throw new IllegalArgumentException("No enum const " + DownloadFormat.class + "@format." + type);
    }
}
