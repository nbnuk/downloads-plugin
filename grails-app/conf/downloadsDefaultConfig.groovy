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

downloads.indexedDownloadUrl = "http://biocache.ala.org.au/ws/occurrences/offline/download"
downloads.checklistDownloadUrl = "http://biocache.ala.org.au/ws/occurrences/facets/download"
downloads.fieldguideDownloadUrl = "http://biocache.ala.org.au/occurrences/fieldguide/download"

downloads.indexedFieldsUrl = "http://biocache.ala.org.au/ws/index/fields"

// Define userdetails.baseUrl to enable saving of fields to userdetails instead of cookies.
// e.g. userdetails.baseUrl = "https://auth.ala.org.au/userdetails"
userdetails.baseUrl = ""

downloads {
    customSections {
        //darwinCore = ["recordLevelTerms","occurrence","organism","materialSampleSpecimen","location","geologicalContext","identification","taxon","measurementOrFact","resourceRelationship"],
        darwinCore = ["recordLevelTerms", "occurrence", "organism", "event", "location", "identification", "taxon", "measurementOrFact"] // "geologicalContext", "resourceRelationship"
        speciesTraits = ["conservationStatus", "otherTraits"]
        spatialIntersections = ["environmentalLayers", "contextualLayers"]
        misc = ["qualityAssertions","miscellaneousFields"]
    }
    classMappings {
        Record = "recordLevelTerms"
        Occurrence = "occurrence"
        Organism = "organism"
        Event = "event"
        Location = "location"
        GeologicalContex = "geologicalContext"
        Identification = "identification"
        Taxon = "taxon"
        MeasurementOrFact = "measurementOrFact"
        ResourceRelationship = "resourceRelationship"
    }
}

// other field mappings for classes TODO get from biocache-service
downloads.conservationStatus = ["austConservation.p","stateConservation.p"]
downloads.otherTraits = ["speciesGroups.p","species_subgroup"]
downloads.environmentalLayers = ["el.p"]
downloads.contextualLayers = ["cl.p"]
//biocache.downloads.extra = "dataResourceUid,dataResourceName.p,occurrenceStatus.p"



downloads.mandatoryFields = ["recordLevelTerms","occurrence"]
downloads.excludeFields = ""
downloads.dwcFields = "uuid,catalogue_number,taxon_concept_lsid,raw_taxon_name,raw_common_name,scientificName.p,raw_taxon,common_name,kingdom,phylum,class,order,family,genus,species,subspecies_name,institution_code,collection_code,raw_locality,decimalLatitude,decimalLongitude,decimalLatitude.p,decimalLongitude.p,coordinatePrecision,coordinate_uncertainty,country,cl1048,cl21,state,cl23,min_elevation_d,max_elevation_d_rng,min_depth_d,max_depth_d,individualCount,collector,year,month,day.p,eventDate.p,eventTime.p,raw_basis_of_record,basis_of_record,raw_sex,preparations,informationWithheld.p,dataGeneralizations.p"