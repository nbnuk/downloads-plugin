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

// These are sensible defaults that are copied into the application's config object and can be overridden
// by the client application or its external config file

customSections = [
    darwinCore: ["recordLevelTerms","occurrence","organism","materialSampleSpecimen","location","geologicalContext","identification","taxon","measurementOrFact","resourceRelationship"],
    speciesTraits: ["conservationStatus"],
    spatialIntersections: ["environmentalLayers","contextualLayers"],
    quality: ["qualityAssertions"]
]

mandatoryFields = ["recordLevelTerms","occurrence"]

extraFields = "dataResourceUid,dataResourceName.p,occurrenceStatus.p"

indexedDownloadUrl = "http://biocache.ala.org.au/ws/occurrences/offline/download"