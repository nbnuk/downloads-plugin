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

modules = {
    download {
        dependsOn 'jquery'
        resource url: [dir: 'css', file: 'download.css', plugin: 'downloads-plugin']
        resource url: [dir: 'js', file: 'bootbox.min.js', plugin: 'downloads-plugin']
        resource url: [dir: 'js', file: 'clipboard.min.js', plugin: 'downloads-plugin']
    }
}