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

package au.org.ala.downloads.plugin

class DownloadsTagLib {

    def downloadService
    //static defaultEncodeAs = [taglib:'html']
    //static encodeAsForTags = [tagName: [taglib:'html'], otherTagName: [taglib:'none']]
    static returnObjectForTags = ['getAllLoggerReasons','testListOutput','getLoggerReasons']
    static namespace = 'downloads'
    static defaultEncodeAs = "raw"

    /**
     * Determine the URL prefix for biocache-service AJAX calls. Looks at the
     * biocache.ajax.useProxy config var to see whether or not to use the proxy
     */
    def getBiocacheAjaxUrl = { attrs ->
        String url = grailsApplication.config.biocache.baseUrl
        Boolean useProxy = grailsApplication.config.biocache.ajax.useProxy.toBoolean() // will convert String 'true' to boolean true
        log.debug "useProxy = ${useProxy}"

        if (useProxy) {
            url = g.createLink(uri: '/proxy')
        }

        out << url
    }

    /**
     * Get the list of available reason codes and labels from the Logger app
     *
     * Note: outputs an Object and thus needs:
     *
     *   static returnObjectForTags = ['getAllLoggerReasons']
     *
     * at top of taglib
     */
    def getAllLoggerReasons = { attrs ->
        List allreasons = downloadService.getLoggerReasons()
        log.debug "allreasons => ${allreasons.getClass().name}"
        allreasons
    }

    def testListOutput = { attrs ->
        def outputList = [[name: "foo",id:0],[name: "bar",id:1]]
        outputList
    }

    /**
     * Get the appropriate sourceId for the current hub
     */
    def getSourceId = { attrs ->
        def skin = grailsApplication.config.skin.layout?.toUpperCase()
        log.debug "skin = ${skin}"
        def sources = downloadService.getLoggerSources()
        sources.each {
            log.debug "it = ${it}"
            if (it.name == skin) {
                out << it.id
            }
        }
    }

    /**
     * Get the list of available reason codes and labels from the Logger app
     *
     * Note: outputs an Object and thus needs:
     *
     *   static returnObjectForTags = ['getLoggerReasons']
     *
     * at top of taglib
     */
    def getLoggerReasons = { attrs ->
        downloadService.getLoggerReasons()
    }

    /**
     * Add extra class name if current param name & value match the provided
     * version
     *
     * @attr fld REQUIRED the field name
     * @attr val REQUIRED the value name
     */
    def btnState = { attrs ->
        def outputClass = ""
        def field = attrs.fld
        def value = attrs.val
        def activeClass = attrs.msg ?: "btn-inverse"

        log.debug "field = ${field} || value = ${value}"
        log.debug "params = ${params}"

        if (params.containsKey(field) && (params.get(field) as String) == value) {
            outputClass = activeClass
        } else if (field == "*" && value == "*") {
            outputClass = activeClass
        }

        out << outputClass
    }

    /**
     * If field.info exists, then format field.dwcTerm as a link
     * with field.info as the href attr.
     *
     * @attr field REQUIRED the field Map
     */
    def formatDwcTerm = { attrs ->
        Map fieldMap = attrs.field
        def text = fieldMap?.dwcTerm

        if (fieldMap.containsKey("info")) {
            String link = fieldMap.info
            if (link.startsWith("http")) {
                text = "<a href='${link}' target='ext'>${text}</a>"
            }
        }

        out << text
    }

    /**
     * Format HTML to be inserted into popup
     *
     * @attr group REQUIRED
     * @attr filter REQUIRED
     * @attr fields REQUIRED
     * @attr action
     */
    def groupHelpHtml = { attrs ->
        def group = attrs.group
        def filter = attrs.filter
        def fields = attrs.fields
        def action = attrs.action ?: "fields"
        def html
        log.debug "attrs = ${attrs}"

        if (filter && fields) {
            html =  "<a href='${g.createLink(action: action)}?filter=${filter}' target='_fields'>" +
                    g.message(code:"downloads.fields.group.${group}", default: group) +
                    " (click for full list of fields)</a> which include: ${fields}"
        } else {
            html = g.message(code:"downloads.fields.group.${group}", default: group)
        }

        out << html
    }
}
